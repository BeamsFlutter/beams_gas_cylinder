import 'package:flutter/material.dart';

//=====================================================APP COLORS

const Color primaryColor = Color(0xFF063261);
const Color subColor = Colors.redAccent;
const Color blackYellow = Color(0xFFFBBC05);
const Color blackBlue = Color(0xFF001540);
const Color buttonColor = Color(0xFF001540);
const Color txtColor = Color(0xFF000000);
const Color txtSubColor = Color(0xFF4D4D4D);
const Color black = Color(0xFF000000);
const Color white = Color(0xFFFFFFFF);
// const Color bgColor = Color(0xFF586BFF);
// const Color bgColorDark = Color(0xFF3546C9);
const Color bgColor = Color(0xFF063261);
const Color bgColorDark = Color(0xFF4B60D0);

const Color color1 = Color(0xFF049DDB);
const Color color2 = Color(0xFF224AFF);
const Color color3 = Color(0xFF679FC9);
const Color bGreyLight = Color(0xFFF8F9FA);
const Color bGreyRedLight = Color(0xFFEFA2A2);


//=====================================================COLORS

const Color redLight = Color(0xFFFFE8E8);
const Color greyLight = Color(0xFFF1F1F1);
const Color blueLight = Color(0xFFE4EDFC);
const Color baseLight = Color(0xFFF6F6F6);
const Color yellowLight = Color(0xFFFFECCA);
const Color greenLight = Color(0xFFD4FFE2);
const Color appLight = Color(0xFFF8F8F8);
const Color textField = Color(0xFFE2E1E1);

const Color notWhite = Color(0xFFEDF0F2);
const Color nearlyWhite = Color(0xFFFEFEFE);
const Color nearlyBlack = Color(0xFF213333);
const Color grey = Color(0xFF3A5160);
const Color dark_grey = Color(0xFF313A44);


//=====================================================Gradient
class CustomColors {
  static Color primaryTextColor = Colors.white;
  static Color dividerColor = Colors.white54;
  static Color pageBackgroundColor = const Color(0xFF2D2F41);
  static Color menuBackgroundColor = const Color(0xFF242634);

  static Color clockBG = const Color(0xFF444974);
  static Color clockOutline = const Color(0xFFEAECFF);
  static Color secHandColor = Colors.orange;
  static Color minHandStatColor = const Color(0xFFC0A625);
  static Color minHandEndColor = const Color(0xFF77DDFF);
  static Color hourHandStatColor = const Color(0xFFC279FB);
  static Color hourHandEndColor = const Color(0xFFEA74AB);

}
class GradientColors {
  final List<Color> colors;
  GradientColors(this.colors);
  static List<Color> darkblueGradient = [const Color(0xFF6984FF), const Color(0xFF224AFF)];
  static List<Color> sky = [const Color(0xFF6448FE), const Color(0xFF5FC6FF)];
  static List<Color> sunset = [const Color(0xFFFE6197), const Color(0xFFFFB463)];
  static List<Color> sea = [const Color(0xFF10C1C6), const Color(0xFF49B0C4)];
  static List<Color> mango = [const Color(0xFFFFA738), const Color(0xFFFFE130)];
  static List<Color> fire = [const Color(0xFFFF5DCD), const Color(0xFFFF8484)];
  static List<Color> beamsGradient = [const Color(0xFF006AA8) , const Color(0xFF00CED5)];
  static List<Color> greenGradient = [const Color(0xFF1FB7B6), const Color(0xFF188785)];
  static List<Color> orangeGradient = [const Color(0xFFFF784E), const Color(0xFFE44F22)];
  static List<Color> orangeGradient1 = [const Color(0xFFE44F22),const Color(0xFFFF784E) ];
  static List<Color> pinkGradient = [const Color(0xFFF6587D), const Color(0xFFCC0031)];
  static List<Color> blueGradient = [const Color(0xFF259CE2), const Color(0xFF18DDFC)];
  static List<Color> yellowGradient = [const Color(0xFFFFAE21), const Color(0xFFE99E11)];
  static List<Color> yellowGradient1 = [const Color(0xFFE99E11),const Color(0xFFFFC353)];
  static List<Color> yellowGradient2 = [const Color(0xFFFFDD00), const Color(0xFFE59500)];
  static List<Color> redGradient = [const Color(0xFFD20000), const Color(0xFFFF3939)];
  static List<Color> redGradient3 = [const Color(0xFFFF3636).withOpacity(0.9), const Color(
      0xFF710000).withOpacity(0.8)];
  static List<Color> redGradient2 = [const Color(0xFFEC9A05).withOpacity(0.9), const Color(
      0xFF580000).withOpacity(0.7)];
  static List<Color> redGradient4 = [const Color(0xFF710000).withOpacity(0.7), const Color(
      0xFFFF3636).withOpacity(0.9)];
  static List<Color> yellowGradient4 = [const Color(0xFF8E6300).withOpacity(0.7), const Color(
      0xFFFFAB00)];
  static List<Color> blueGradientOp = [const Color(0xFF4444A2).withOpacity(0.9), const Color(
      0xFF191965).withOpacity(0.7)];
  static List<Color> bgGradient = [bgColorDark.withOpacity(0.9), bgColorDark.withOpacity(0.7)];
  static List<Color> whiteOpacity = [const Color(0xFFFFFFFF).withOpacity(0.4), const Color(
      0xFFFAFAFA).withOpacity(0.4)];
  static List<Color> whiteOpacity2 = [const Color(0xFFFFFFFF).withOpacity(0.6), const Color(
      0xFFFAFAFA).withOpacity(0.6)];
  static List<Color> whiteOpacity0 = [const Color(0xFFFFFFFF).withOpacity(0.1), const Color(
      0xFFFAFAFA).withOpacity(0.1)];
  static List<Color> blueGradient2 = [color1,  color2];
  static List<Color> waterBg = [ color2.withOpacity(0.9), color1.withOpacity(0.4)];
}
class GradientTemplate {
  static List<GradientColors> gradientTemplate = [
    GradientColors(GradientColors.darkblueGradient),
    GradientColors(GradientColors.sky),
    GradientColors(GradientColors.sunset),
    GradientColors(GradientColors.sea),
    GradientColors(GradientColors.mango),
    GradientColors(GradientColors.fire),
    GradientColors(GradientColors.blueGradient),
    GradientColors(GradientColors.greenGradient),
    GradientColors(GradientColors.orangeGradient),
    GradientColors(GradientColors.orangeGradient1),
    GradientColors(GradientColors.pinkGradient),
    GradientColors(GradientColors.blueGradient),
    GradientColors(GradientColors.yellowGradient),
    GradientColors(GradientColors.redGradient),
    GradientColors(GradientColors.yellowGradient1),
    GradientColors(GradientColors.redGradient2),
    GradientColors(GradientColors.yellowGradient2),
    GradientColors(GradientColors.redGradient3),
    GradientColors(GradientColors.redGradient4),
    GradientColors(GradientColors.yellowGradient4),
    GradientColors(GradientColors.blueGradientOp),
    GradientColors(GradientColors.bgGradient),
    GradientColors(GradientColors.whiteOpacity),
    GradientColors(GradientColors.whiteOpacity2),
    GradientColors(GradientColors.whiteOpacity0),
    GradientColors(GradientColors.blueGradient2),
    GradientColors(GradientColors.waterBg),

  ];
}
class BeamsGradientTemplate {
  static List<GradientColors> gradientTemplate = [

    GradientColors(GradientColors.beamsGradient),
    GradientColors(GradientColors.greenGradient),
    GradientColors(GradientColors.orangeGradient),
    GradientColors(GradientColors.pinkGradient),
    GradientColors(GradientColors.blueGradient)

  ];
}
class UserGradientTemplate {
  static List<GradientColors> gradientTemplate = [

    GradientColors(GradientColors.pinkGradient),
    GradientColors(GradientColors.greenGradient),
    GradientColors(GradientColors.beamsGradient),
    GradientColors(GradientColors.orangeGradient),
    GradientColors(GradientColors.blueGradient),
    GradientColors(GradientColors.pinkGradient),
    GradientColors(GradientColors.greenGradient),
    GradientColors(GradientColors.beamsGradient),
    GradientColors(GradientColors.orangeGradient),
    GradientColors(GradientColors.blueGradient),
    GradientColors(GradientColors.pinkGradient),
    GradientColors(GradientColors.greenGradient),
    GradientColors(GradientColors.beamsGradient),
    GradientColors(GradientColors.orangeGradient),
    GradientColors(GradientColors.blueGradient),
    GradientColors(GradientColors.pinkGradient),
    GradientColors(GradientColors.greenGradient),
    GradientColors(GradientColors.beamsGradient),
    GradientColors(GradientColors.orangeGradient),
    GradientColors(GradientColors.blueGradient)

  ];
}
class ColorsList {
  static List<Color> gradientTemplate = [
    const Color(0xFFE30031),
    const Color(0xFF188785),
    const Color(0xFFE88B0B),
    const Color(0xFF027DA1),
    const Color(0xFF5468BB),
    const Color(0xFF6448FE),
    const Color(0xFFB75786),
    const Color(0xFFFF7C30),
    const Color(0xFF08A85F),
    const Color(0xFF3546C9),
    const Color(0xFFD73800),
    const Color(0xFFFF7C30),
    const Color(0xFFDA2188),
    const Color(0xFFFFCC00),
    const Color(0xFF1656A6),
    const Color(0xFFE8563F),
    const Color(0xFF000000),


  ];
}


class AppTheme {
  AppTheme._();
  static const Color nearlyWhite = Color(0xFFFAFAFA);
  static const Color white = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF4F4FC);
  static const Color nearlyDarkBlue = Color(0xFF2633C5);

  static const Color nearlyBlue = Color(0xFF00B6F0);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color grey = Color(0xFF3A5160);
  static const Color dark_grey = Color(0xFF313A44);

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color spacer = Color(0xFFF2F2F2);
  static const String fontName = 'Roboto';

  static const TextTheme textTheme = TextTheme(
    headline4: display1,
    headline5: headline,
    headline6: title,
    subtitle2: subtitle,
    bodyText2: body2,
    bodyText1: body1,
    caption: caption,
  );

  static const TextStyle display1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkerText,
  );

  static const TextStyle headline = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: darkerText,
  );

  static const TextStyle title = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: darkerText,
  );

  static const TextStyle subtitle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: darkText,
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: darkText,
  );

  static const TextStyle body1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkText,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: lightText, // was lightText
  );
}