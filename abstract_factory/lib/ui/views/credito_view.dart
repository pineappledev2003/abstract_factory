import 'package:abstract_factory/providers/credito_debito_form_provider.dart';
import 'package:abstract_factory/service/pago_servicio.dart';
import 'package:abstract_factory/ui/shared/custom_tarjeta.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

class CreditoView extends StatefulWidget {
  final String baseURL;

  const CreditoView({super.key, required this.baseURL});

  @override
  State<CreditoView> createState() => _CreditoViewState();
}

class _CreditoViewState extends State<CreditoView> {
  double monto = 0.0;
  Future<Map<String, dynamic>>? _futurePago;

  /*
╔════════════════════════════════════════════════════════════╗
║               📌 USO RECOMENDADO DE `listen`              ║
╚════════════════════════════════════════════════════════════╝

🟢 Dentro de build() y muestras info en pantalla
✅ listen: true
👉 El widget debe reconstruirse automáticamente si cambia el estado del provider.

🟠 Dentro de un botón, método o función (onPressed, callbacks, etc.)
✅ listen: false
👉 Solo necesitás acceder a datos o ejecutar métodos, sin redibujar el widget.

🔵 Dentro de una función async (como un onPressed con await)
✅ listen: false
👉 Evitás errores como: "Don't use BuildContext across async gaps".

🔴 Si querés llamar notifyListeners() y que otro widget reaccione
✅ listen: true
👉 Alguien debe estar escuchando los cambios para que haya una reacción visual.

💡 Regla de oro:
Usá `listen: true` solo cuando el widget necesita reconstruirse al cambiar el estado.
En todo otro caso, `listen: false` es más seguro y eficiente.
*/

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CreditoDebitoFormProvider(),
      child: Builder(
        builder: (context) {
          final creditoDebitoFormProvider = Provider.of<CreditoDebitoFormProvider>(context);

          return Column(
            children: [
              CustomTarjeta(
                width: 700,
                height: 200,
                pathImage: "visa_logo.png",
                campos: [
                  MapEntry("Tarjeta:", widget.baseURL),
                  MapEntry("Numero Tarjeta:", creditoDebitoFormProvider.numeroTarjeta),
                  MapEntry("Nombre Titular:", creditoDebitoFormProvider.nombreTitular),
                  MapEntry("CVV:", creditoDebitoFormProvider.cvv),
                  MapEntry("Limite Credito:", creditoDebitoFormProvider.limiteCredito.toString()),
                ],
              ),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 20),

              Text("DATOS NECESARIOS", style: GoogleFonts.roboto(fontSize: 30)),

              SizedBox(height: 20),

              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 300),
                child: Form(
                  key: creditoDebitoFormProvider.formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Wrap(
                    runSpacing: 10,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Tipo Tarjeta"),
                          hintText: "Ej: debito, credito, paypal",
                        ),
                        readOnly: true,
                        initialValue: widget.baseURL,
                        validator: Validatorless.multiple([
                          Validatorless.required("Este campo es requerido"),
                        ]),
                      ),

                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Numero Tarjeta"),
                          hintText: "Ej: 1234567890",
                        ),
                        onChanged: (value) {
                          creditoDebitoFormProvider.setNumeroTarjeta = value;
                        },
                        validator: Validatorless.multiple([
                          Validatorless.required("Este campo es requerido"),
                        ]),
                      ),

                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Titular"),
                          hintText: "Ej: Juan",
                        ),
                        onChanged: (value) {
                          creditoDebitoFormProvider.setNombreTitular = value;
                        },
                        validator: Validatorless.multiple([
                          Validatorless.required("Este campo es requerido"),
                        ]),
                      ),

                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Cvv"),
                          hintText: "Ej: 123",
                        ),
                        onChanged: (value) {
                          creditoDebitoFormProvider.setCvv = value;
                        },
                        validator: Validatorless.multiple([
                          Validatorless.required("Este campo es requerido"),
                        ]),
                      ),

                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Limite Credito"),
                          hintText: "Ej: 20000",
                        ),
                        onChanged: (value) {
                          final parse = double.tryParse(value);
                          creditoDebitoFormProvider.setLimiteCredito = parse!;
                        },
                        validator: Validatorless.multiple([
                          Validatorless.required("Este campo es requerido"),
                        ]),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Monto"),
                          hintText: "Ej: 20000",
                        ),
                        onChanged: (value) {
                          monto = double.parse(value);
                        },
                        validator: Validatorless.multiple([
                          Validatorless.required("Este campo es requerido"),
                        ]),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final validForm =
                              Provider.of<CreditoDebitoFormProvider>(
                                context,
                                listen: false,
                              ).validateForm();
                          if (validForm) {
                            setState(() {
                              _futurePago = PagoServicio.procesarPago(
                                widget.baseURL,
                                creditoDebitoFormProvider.numeroTarjeta,
                                double.parse(creditoDebitoFormProvider.limiteCredito.toString()),
                                monto,
                              );
                            });
                          }
                        },
                        child: Text("GUARDAR"),
                      ),
                    ],
                  ),
                ),
              ),

              if (_futurePago != null) ...[
                FutureBuilder<Map<String, dynamic>>(
                  future: _futurePago,
                  builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(); // Esperando el resultado
                    } else if (snapshot.hasError) {
                      // Usamos un post-frame callback para mostrar el SnackBar después de que el build haya terminado
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
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('❌ Pago fallido: ${resp['mensaje']}')),
                          );
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
          );
        },
      ),
    );
  }
}
