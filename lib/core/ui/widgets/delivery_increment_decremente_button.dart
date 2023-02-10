
import 'package:flutter/material.dart';
import 'package:vakinha_burguer/core/ui/styles/colors_app.dart';
import 'package:vakinha_burguer/core/ui/styles/text_styles.dart';

class DeliveryIncrementDecrementButton extends StatelessWidget {

  final int amount;
  final VoidCallback incrementTap;
  final VoidCallback decrementTap;
  final bool compact;

  const DeliveryIncrementDecrementButton({
    super.key,
    required this.amount,
    required this.incrementTap,
    required this.decrementTap,
  }) : compact = false;


  const DeliveryIncrementDecrementButton.compact({
    super.key,
    required this.amount,
    required this.incrementTap,
    required this.decrementTap,
  }) : compact = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: compact ? const EdgeInsets.all(7) : null,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: decrementTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text("-" ,
                style: context.textStyles.textMedium.copyWith(
                    fontSize: compact ? 10 : 22,
                    color: Colors.grey
                ),
              ),
            ),
          ),


          Text(amount.toString() ,
            style: context.textStyles.textRegular.copyWith(
                fontSize: compact ? 13 : 17,
                color: context.colors.secondary),
          ),

          InkWell(
            onTap: incrementTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text("+" ,
                style: context.textStyles.textMedium.copyWith(
                    fontSize: compact ? 10 : 22,
                    color: context.colors.secondary),),
            ),
          ),
        ],
      ),
    );
  }
}
