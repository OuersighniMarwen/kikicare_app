import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kBackgroundColor = Color(0xFFF8F8F8);
const kActiveIconColor = Color(0xFFE68342);
const kTextColor = Color(0xFF222B45);
const kBlueLightColor = Color(0xFFFFAB91);
const kBlueColor = Color(0xFFFF9100);
const kShadowColor = Color(0xFFE6E6E6);
const t = Color(0xFF8825063);

const String appName = "KiKiCare App";
const String host = "http://10.0.2.2:1225";
const String hostPicture = "http://10.0.2.2:1225/images";

const Color loginGradientStart = const Color(0x99F3D617);
const Color loginGradientMiddle = const Color(0xFFFF9100);
const Color loginGradientEnd = const Color(0xFFF9429E);

const primaryGradient = const LinearGradient(
  colors: const [loginGradientStart, loginGradientEnd],
  stops: const [0.0, 1.0],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
