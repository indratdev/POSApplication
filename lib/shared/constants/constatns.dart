import 'package:flutter/material.dart';

const googleLogo = 'assets/logos/googleLogo.webp';

// image
const successImage = 'assets/images/success.webp';
const failedImage = 'assets/images/failed.webp';
const warningImage = 'assets/images/warning.webp';
const noDataImage = 'assets/images/nodata.webp';

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
const color1 = Color(0xFF3B2D60);

const Color activeIconColor = Color(0xFF198754);
// const Color inActiveIconColor = Color(0xFFd3d3d3);
const Color inActiveIconColor = Colors.grey;
const Color cancelIconColor = Color(0xFFcf142b);

BoxShadow boxShadowMenu = BoxShadow(
  color: color1.withOpacity(0.5),
  spreadRadius: 4,
  blurRadius: 10,
  offset: const Offset(0, 3), // changes position of shadow
);
