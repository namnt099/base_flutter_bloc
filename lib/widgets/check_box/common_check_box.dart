import 'package:flutter/material.dart';
import 'package:sdk_wallet_flutter/config/themes/app_theme.dart';

class CommonCheckBox extends StatefulWidget {
  const CommonCheckBox({
    super.key,
    required this.initValue,
    required this.onChanged,
  });
  final bool initValue;
  final Function(bool) onChanged;

  @override
  State<CommonCheckBox> createState() => _CommonCheckBoxState();
}

class _CommonCheckBoxState extends State<CommonCheckBox> {
  bool _value = false;

  @override
  void initState() {
    _value = widget.initValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: _value,
      side: BorderSide(color: AppTheme.getInstance().textPrimary),
      activeColor: AppTheme.getInstance().primaryColor,
      onChanged: (value) {
        widget.onChanged(value ?? false);
        setState(() {
          _value = value ?? false;
        });
      },
    );
  }
}
