import 'package:flutter/material.dart';

const googleLogo = 'assets/logos/googleLogo.webp';

// image
const successImage = 'assets/images/success.webp';
const failedImage = 'assets/images/failed.webp';
const warningImage = 'assets/images/warning.webp';
const noDataImage = 'assets/images/nodata.webp';
const logoAppImage = 'assets/images/logoApp.webp';

// icons
const workProcess = 'assets/icons/work_process.webp';
const check = 'assets/icons/check.webp';
const excellence = 'assets/icons/excellence.webp';
const failure = 'assets/icons/failure.webp';

// sizebox
const SizedBox sbWidth10 = SizedBox(width: 10);
const SizedBox sbHeight10 = SizedBox(height: 10);
const SizedBox sbHeight20 = SizedBox(height: 20);
const SizedBox sbHeight30 = SizedBox(height: 30);

// border radius
const double defaultBorderRadius = 13.0;

// color
// ------- main color -----------
const Color mainGreen = Color(0xFF5D9C59);
const Color secondGreen = Color(0xFFC7E8CA);
const Color thirdGreen = Color(0xFFDDF7E3);
const Color redColors = Color(0xFFDF2E38);
const Color mainWhite = Color(0xFFFDFAF6);

const Color waitingColor = Color(0xFFFFEBEB);
const Color progressColor = Color(0xFFADE4DB);
const Color readyColor = Color(0xFFF6BA6F);
const Color orderCompletedColor = Color(0xFF92B4EC);
const Color billIsReadyColor = Color(0xFFFFFFFF);
const Color paymentCompleteColor = Color(0xFFFFB2A6);
const Color cancelColor = Color(0xFFFF6464);

// ------- end main color -------

const color1 = Color(0xFF3B2D60);
const errorMessageColor = Color(0xFFFF3333);
const Color activeIconColor = Color(0xFF198754);
// const Color inActiveIconColor = Color(0xFFd3d3d3);
const Color inActiveIconColor = Colors.grey;
const Color cancelIconColor = Color(0xFFcf142b);

const Color deepPineGreenColor = Color(0xFF1d3c45);
const Color orangeColor = Color(0xFFd2601a);
const Color lightPeachColor = Color(0xFFfff1e1);

const Color mustardColor = Color(0xFFe3b448);
const Color sageColor = Color(0xFFcbd18f);
const Color forestGreenColor = Color(0xFF3a6b35);

// text color
const Color blackTextColor = Color(0xFF212427);
Color blackOpacity06TextColor = const Color(0xFF212427).withOpacity(0.6);

// #e3b448, #cbd18f, #3a6b35
// #1d3c45, #d2601a, #fff1e1

BoxShadow boxShadowMenu = BoxShadow(
  color: color1.withOpacity(0.5),
  spreadRadius: 4,
  blurRadius: 10,
  offset: const Offset(0, 3), // changes position of shadow
);
