import 'package:abstract_factory/ui/shared/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomTarjeta extends StatelessWidget {
  final String pathImage;
  final List<MapEntry<String, String>> campos;
  final double? width;
  final double? height;

  const CustomTarjeta({super.key, required this.campos, required this.pathImage, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(colors: [Colors.black, Colors.grey.shade800]),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
      ),
      child: Row(
        children: [
          Image.asset(pathImage, width: 300, fit: BoxFit.fitHeight),

          SizedBox(width: 10),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: Wrap(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        campos.map((campo) {
                          return CustomText(
                            label: campo.key,
                            value: campo.value,
                            color: Colors.white,
                          );
                        }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
