import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectButtons extends StatelessWidget {
  const SelectButtons({
    super.key,
    required this.onTap,
    required this.text,
    required this.iconData,
  });

  final VoidCallback onTap;
  final String text;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: InkWell(
        borderRadius: BorderRadius.circular(24.r),
        onTap: onTap,
        child: Container(

          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(10.w),
          margin: EdgeInsets.all(10.w),
          child: Row(
            children: [
              Icon(iconData),
              SizedBox(width: 10.w),
              Text(text),
            ],
          ),
        ),
      ),
    );
  }
}
