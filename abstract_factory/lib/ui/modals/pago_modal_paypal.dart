import 'package:abstract_factory/models/paypal.dart';
import 'package:abstract_factory/service/pago_servicio.dart';
import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

class PagoModalPayPal extends StatefulWidget {
  final Paypal paypal;
  const PagoModalPayPal({super.key, required this.paypal});

  @override
  State<PagoModalPayPal> createState() => _PagoModalPayPalState();
}

class _PagoModalPayPalState extends State<PagoModalPayPal> {
  String tipo = "";
  String id = "";
  double limite = 0.0;

  double monto = 0;
  Future<Map<String, dynamic>>? _futurePago;

  @override
  void initState() {
    super.initState();

    tipo = widget.paypal.obtenerTipoTarjeta;
    id = widget.paypal.obtenerEmail;
    limite = widget.paypal.obtenerLimitePayPal;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Imgrese Monto Para: $tipo, $id, $limite"),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.close_outlined),
              ),
            ],
          ),
          Divider(),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Monto"),
              hintText: "Ej: 20000",
            ),
            onChanged: (value) {
              monto = double.parse(value);
            },
            validator: Validatorless.multiple([Validatorless.required("Este campo es requerido")]),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _futurePago = PagoServicio.procesarPago(tipo, id, limite, monto);
              });
            },
            child: Text("PROCESAR"),
          ),
          if (_futurePago != null) ...[
            FutureBuilder<Map<String, dynamic>>(
              future: _futurePago,
              builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Esperando el resultado
                } else if (snapshot.hasError) {

                  // Usamos un post-frame callback para mostrar el SnackBar después de que el build haya terminado
                  // 🧠 Usamos `WidgetsBinding.instance.addPostFrameCallback` para ejecutar este bloque
                  // de código DESPUÉS de que Flutter haya terminado de construir y pintar el widget.
                  // 🔧 Es útil cuando necesitamos mostrar un SnackBar, abrir un Dialog, navegar,
                  // o usar el BuildContext justo después de un `build()` o en un `FutureBuilder`.
                  //
                  // ❗ Si lo hacemos directamente sin este método, puede fallar con errores como:
                  // "Cannot use BuildContext across async gaps" o "context does not contain a Scaffold"
                  //
                  // 🎭 Analogía: Es como esperar que termine el montaje del escenario
                  // antes de hacer entrar al actor principal. Si se mete antes... ¡se rompe todo!

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('❌ Error: ${snapshot.error}')));
                  });
                  return SizedBox.shrink(); // Si hay error, no mostramos nada más.
                } else if (snapshot.hasData) {
                  final resp = snapshot.data!;

                  if (resp["success"] == true) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('✅ Pago exitoso'),
                              Text('💳 Tipo Tarjeta: ${resp['tipo']}'),
                              Text('👤 Id: ${resp['id']}'),
                              Text('💵 Monto Final: ${resp['monto_final']}'),
                              Text('💰 Nuevo Limite: ${resp['nuevo_limite']}'),
                              Text('💬 Mensaje: ${resp['mensaje']}'),
                            ],
                          ),
                        ),
                      );
                    });
                  } else {
                    // Si el pago falló
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('❌ Pago fallido: ${resp['mensaje']}')));
                    });
                  }
                  return SizedBox.shrink(); // Si ya procesaste los datos, no necesitamos mostrar nada más.
                } else {
                  return SizedBox.shrink(); // Si no hay datos aún, no mostramos nada.
                }
              },
            ),
          ],
        ],
      ),
    );
  }
}
