import 'package:flutter/material.dart';
import '../core/export.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool isLoading;
  final VoidCallback onTap;
  final double width;

  const CustomButton(this.text,
      {Key key, this.onTap, this.isLoading = false, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 40),
      padding: EdgeInsets.symmetric(vertical: 6),
      height: 50,
      width: isLoading ? 70 : width ?? 200,
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(20),
      ),
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(theme.iconTheme.color),
              ),
            )
          : GestureDetector(
              onTap: onTap,
              child: Center(
                child: Text(text, style: theme.textTheme.headline6),
              ),
            ),
    );
  }
}
