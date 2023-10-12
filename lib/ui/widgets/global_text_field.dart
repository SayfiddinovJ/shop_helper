import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GlobalTextField extends StatefulWidget {
  final String hintText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Widget? prefixIcon;
  final String caption;
  final ValueChanged? onChanged;
  final FocusNode? focusNode;
  final bool readOnly;
  final TextInputFormatter? textFormatter;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final bool? obscureText;
  final EdgeInsets? contentPadding;
  final int? maxLines;
  final int? maxLength;
  final TextCapitalization textCapitalization;

  const GlobalTextField({
    Key? key,
    required this.hintText,
    this.textCapitalization = TextCapitalization.none,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.prefixIcon,
    this.maxLength,
    this.maxLines = 1,
    this.caption = "",
    this.suffixIcon,
    this.readOnly = false,
    this.controller,
    this.onChanged,
    this.focusNode,
    this.textFormatter,
    this.obscureText,
    this.contentPadding,
  }) : super(key: key);

  @override
  State<GlobalTextField> createState() => _GlobalTextFieldState();
}

class _GlobalTextFieldState extends State<GlobalTextField> {
  late TextEditingController _internalController;
  final internalFocusNode = FocusNode();
  Color color = const Color(0xFFFAFAFA);

  @override
  void initState() {
    super.initState();
    _internalController = widget.controller ?? TextEditingController();
    widget.focusNode?.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    widget.focusNode?.removeListener(_onFocusChange);
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChanged,
      obscuringCharacter: '●',
      readOnly: widget.readOnly,
      controller: _internalController,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      textCapitalization: widget.textCapitalization,
      focusNode: widget.focusNode ?? internalFocusNode,
      inputFormatters:
      widget.textFormatter != null ? [widget.textFormatter!] : [],
      obscureText: widget.obscureText ?? false,
      decoration: InputDecoration(
        counterText: '',
        hintStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xff9e9e9e),
          height: 20 / 14,
        ),
        contentPadding: widget.contentPadding,
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
      ),
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
    );
  }
}
