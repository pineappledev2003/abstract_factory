import 'package:abstract_factory/controller/paypal_controller.dart';
import 'package:abstract_factory/providers/paypal_form_provider.dart';
import 'package:abstract_factory/ui/shared/custom_tarjeta.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

class PayPalView extends StatefulWidget {
  final String baseURL;

  const PayPalView({super.key, required this.baseURL});

  @override
  State<PayPalView> createState() => _PayPalViewState();
}

class _PayPalViewState extends State<PayPalView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PaypalFormProvider(),
      child: Builder(
        builder: (context) {
          final payPalFormProvider = Provider.of<PaypalFormProvider>(context);
          final payPalController = Provider.of<PaypalController>(context, listen: false);
          return Column(
            children: [
              CustomTarjeta(
                width: 700,
                height: 200,
                pathImage: "logo_paypal.png",
                campos: [
                  MapEntry("Tarjeta:", widget.baseURL),
                  MapEntry("Email:", payPalFormProvider.email),
                  MapEntry("Limite Paypal:", payPalFormProvider.limitePayPal.toString()),
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
                  key: payPalFormProvider.formKey,
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
                          label: Text("Email"),
                          hintText: "Ej: example@example.com",
                        ),
                        onChanged: (value) {
                          payPalFormProvider.nuevoEmail = value;
                        },
                        validator: Validatorless.multiple([
                          Validatorless.required("Este campo es requerido"),
                        ]),
                      ),

                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Limite Paypal"),
                          hintText: "Ej: 20000",
                        ),
                        onChanged: (value) {
                          final parse = double.tryParse(value);
                          payPalFormProvider.nuevoLimitePayPal = parse!;
                        },
                        validator: Validatorless.multiple([
                          Validatorless.required("Este campo es requerido"),
                        ]),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final validForm = payPalFormProvider.validateForm();

                          if (validForm == true) {
                            payPalController.registrarPayPal(
                              widget.baseURL,
                              payPalFormProvider.email,
                              payPalFormProvider.limitePayPal,
                            );
                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(SnackBar(content: Text('✅ Tarjeta registrada')));
                          } else {
                            print("NOT OOK");
                          }
                        },
                        child: Text("GUARDAR"),
                      ),
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
