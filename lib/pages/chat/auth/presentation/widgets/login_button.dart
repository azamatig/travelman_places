import 'package:flutter/material.dart';
import 'package:travelman/pages/chat/core/export.dart';

class LoginButton extends StatelessWidget {
  final String text;
  final bool isLoading;
  final VoidCallback onTap;

  const LoginButton(this.text, {Key key, this.onTap, this.isLoading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 40),
      padding: EdgeInsets.symmetric(vertical: 6),
      height: 50,
      width: isLoading ? 60 : 200,
      decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
          borderRadius: BorderRadius.circular(40)),
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: isLoading
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(theme.iconTheme.color),
                )
              : Text(
                  text,
                  style: theme.textTheme.headline6.copyWith(
                    color: theme.iconTheme.color,
                  ),
                ),
        ),
      ),
    );
  }
}
