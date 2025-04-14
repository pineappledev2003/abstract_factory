import 'package:abstract_factory/providers/credito_debito_form_provider.dart';
import 'package:abstract_factory/ui/shared/custom_tarjeta.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';



class DebitoView extends StatefulWidget {

  final String baseURL;

  const DebitoView({super.key, required this.baseURL});

  @override
  State<DebitoView> createState() => _DebitoViewState();
}

class _DebitoViewState extends State<DebitoView> {
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
                pathImage: "masterd_card_logo.png",
                campos: [
                  MapEntry("Tarjeta:", widget.baseURL),
                  MapEntry("Numero Tarjeta:", creditoDebitoFormProvider.numeroTarjeta),
                  MapEntry("Nombre Titular:", creditoDebitoFormProvider.nombreTitular),
                  MapEntry("CVV:", creditoDebitoFormProvider.cvv),
                  MapEntry("Saldo Disponible:", creditoDebitoFormProvider.limiteCredito.toString()),
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
                        initialValue: widget.baseURL,
                        readOnly: true,
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
                          label: Text("Saldo Disponible"),
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
                      ElevatedButton(onPressed: () {
                        final validForm = creditoDebitoFormProvider.validateForm();

                        if (validForm == true) {
                          print("OK");
                        }else{
                          print("NOT OOK");
                        }
                      }, child: Text("GUARDAR"))
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
