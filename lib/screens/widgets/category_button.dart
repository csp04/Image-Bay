import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton({
    @required this.categoryLabel,
    @required this.isSelected,
    @required this.selectedColor,
    this.onTap,
    Key key,
  }) : super(key: key);

  final bool isSelected;
  final Color selectedColor;
  final String categoryLabel;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20.0),
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          categoryLabel,
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5.0,
              offset: Offset(0.0, 1.0),
            )
          ],
          color: isSelected ? selectedColor : Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}
