import 'package:flutter/material.dart';

class BotSheet extends StatelessWidget {
  BotSheet({
    this.onTap,
    this.icon,
    this.label,
  });

  final VoidCallback onTap;
  final icon;
  final label;

  @override
  Widget build(BuildContext context) {
    return ListTile(leading: Icon(icon), title: Text(label), onTap: onTap);
  }
}