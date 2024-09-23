import 'package:flutter/cupertino.dart';
import 'package:sdk_wallet_flutter/config/resources/dimens.dart';
import 'package:sdk_wallet_flutter/utils/extensions/app_dimen.dart';

import '../../config/themes/app_theme.dart';

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({
    super.key,
    required this.onChanged,
    this.initialValue = false,
  });
  final Function(bool) onChanged;
  final bool initialValue;

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  late bool _value;
  @override
  void initState() {
    _value = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimens.d31.responsive(),
      width: Dimens.d50.responsive(),
      child: CupertinoSwitch(
        trackColor: AppTheme.getInstance().formColor,
        activeColor: AppTheme.getInstance().primaryColor,
        value: _value,
        onChanged: (value) {
          _value = value;
          widget.onChanged(_value);
          setState(() {});
        },
      ),
    );
  }
}
