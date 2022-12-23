import 'package:flutter/cupertino.dart';
import 'package:whats_app_clone/utils/dimensions.dart';

class CustomText extends StatelessWidget {
  final String text;
  double fontSize;
  FontWeight fontWeight;
  Color? color;
  TextAlign? textAlign;
  CustomText({Key? key, required this.text, this.fontSize = 0, this.fontWeight = FontWeight.normal, this.color, this.textAlign}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize:fontSize == 0 ? Dimensions.font16 : fontSize,
          fontWeight: fontWeight, color: color,
      ),
    );
  }
}
