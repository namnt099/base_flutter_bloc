import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sdk_wallet_flutter/config/resources/dimens.dart';
import 'package:sdk_wallet_flutter/config/resources/styles.dart';
import 'package:sdk_wallet_flutter/config/themes/app_theme.dart';
import 'package:sdk_wallet_flutter/utils/constants/image_asset.dart';
import 'package:sdk_wallet_flutter/utils/extensions/app_dimen.dart';
import 'package:sdk_wallet_flutter/utils/log/log_utils.dart';

import '../../utils/style_utils.dart';

class OutlineDropDown<T> extends StatefulWidget {
  final String placeHolder;
  final List<T> dropdownItems;
  final ValueChanged<T> onChanged;

  const OutlineDropDown({
    super.key,
    required this.placeHolder,
    required this.dropdownItems,
    required this.onChanged,
  });

  @override
  _OutlineDropDownState<T> createState() => _OutlineDropDownState<T>();
}

class _OutlineDropDownState<T> extends State<OutlineDropDown<T>> {
  String _result = '';
  late final FocusNode _focusNode;

  OverlayEntry? _overlayEntry;

  late final LayerLink _layerLink;

  @override
  void initState() {
    _focusNode = FocusNode()..addListener(_onFocus);
    _layerLink = LayerLink();
    super.initState();
  }

  void _onFocus() {
    if (_focusNode.hasFocus) {
      Log.d('open');
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    } else {
      Log.d('close');
      _overlayEntry?.remove();
    }
    setState(() {});
  }

  OverlayEntry _createOverlayEntry() {
    // ignore: cast_nullable_to_non_nullable
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + Dimens.d5.responsive()),
          child: Material(
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                boxShadow: ShadowUtil.shadowB17,
                color: AppTheme.getInstance().secondaryColor,
                borderRadius: BorderRadius.circular(Dimens.d8.responsive()),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.dropdownItems.map((item) {
                  return GestureDetector(
                    onTap: () {
                      widget.onChanged(item);
                      _focusNode.unfocus();
                      _result = item.toString();
                    },
                    child: Container(
                      width: double.infinity,
                      color: _result == item.toString()
                          ? AppTheme.getInstance().statusComplete
                          : null,
                      padding: EdgeInsets.all(Dimens.d16.responsive()),
                      child: Text(
                        item.toString(),
                        style: AppTextStyle.regularText.copyWith(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      child: CompositedTransformTarget(
        link: _layerLink,
        child: GestureDetector(
          onTap: () {
            if (_focusNode.hasFocus) {
              _focusNode.unfocus();
              return;
            }
            _focusNode.requestFocus();
          },
          child: Container(
            padding: EdgeInsets.all(Dimens.d16.responsive()),
            decoration: BoxDecoration(
              border: Border.all(
                color: !_focusNode.hasFocus
                    ? AppTheme.getInstance().textStroke
                    : AppTheme.getInstance().textPrimary,
              ),
              borderRadius: BorderRadius.circular(Dimens.d8.responsive()),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_result.isNotEmpty)
                  Text(
                    _result,
                    style: AppTextStyle.regularText.copyWith(
                      fontSize: 14,
                    ),
                  )
                else
                  Text(
                    widget.placeHolder,
                    style: AppTextStyle.regularText.copyWith(
                      fontSize: 14,
                      color: AppTheme.getInstance().textSecondary,
                    ),
                  ),
                if (!_focusNode.hasFocus)
                  ImageAssets.images.icChevronDown.svg()
                else
                  Transform.rotate(
                    angle: -pi / 2,
                    child: ImageAssets.images.icChevronDown.svg(),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
