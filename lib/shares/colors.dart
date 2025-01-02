import 'package:flutter/cupertino.dart';
import 'package:usemain/providers/config.dart';

const Color commonColor = Color(0xFF266ED7);
const Color commonDetultColor = Color(0xFF4D8AEB);

const LinearGradient commonGradient = LinearGradient(
  colors: [
    commonColor,
    commonDetultColor,
  ],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

Color isBackgroundColor(ConfigProvider configProvider) {
  if (configProvider.isLight) {
    return const Color(0xFFFFFFFF);
  } else {
    return const Color(0xFF141414);
  }
}

Color isThemeBgColor(ConfigProvider configProvider) {
  if (configProvider.isLight) {
    return const Color(0xFFF5F5F5);
  } else {
    return const Color(0xFF010101);
  }
}

Color isThemePopupBgColor(ConfigProvider configProvider) {
  if (configProvider.isLight) {
    return const Color(0xFFFFFFFF);
  } else {
    return const Color.fromARGB(255, 20, 20, 23);
  }
}

Color isSwitchBgColor(ConfigProvider configProvider) {
  if (configProvider.isLight) {
    return const Color(0xFFE4E4E7);
  } else {
    return const Color.fromARGB(255, 43, 43, 43);
  }
}

Color isSwitchColor(ConfigProvider configProvider) {
  if (configProvider.isLight) {
    return Color(0xFFFFFFFF);
  } else {
    return const Color.fromARGB(255, 102, 102, 102);
  }
}
