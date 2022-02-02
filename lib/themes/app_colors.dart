import 'package:flutter/material.dart';

class AppColors {
  static const azoxo = Color(0xFFa020f0);
  static const totalmenteBranco = Color(0xFFFFFFFF);
  static const cinxo = Color(0xFF99AAB5);
  static const escuro = Color(0xFF2C2F33);
  static const meioPretinho = Color(0xFF23272A);
  static const pretoMesmo = Color(0xFF000000);
  static const online = Color(0xFF43B581);
  static const ausente = Color(0xFFFAA61A);
  static const naoPertube = Color(0xFFF04747);
  static const ofline = Color(0xFF727D8A);
  static const quaseBranco = Color(0xFFF8F6F7);
}

abstract class LightColors {
  static const background = AppColors.quaseBranco;
  static const card = AppColors.totalmenteBranco;
  static const textLigth = AppColors.pretoMesmo;
  static const iconLight = AppColors.pretoMesmo;
}

abstract class DarkColors {
  static const background = AppColors.meioPretinho;
  static const card = AppColors.escuro;
  static const textDark = AppColors.totalmenteBranco;
  static const iconDark = AppColors.totalmenteBranco;
}
