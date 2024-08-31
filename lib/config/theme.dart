import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff435e91),
      surfaceTint: Color(0xff435e91),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffd8e2ff),
      onPrimaryContainer: Color(0xff001a41),
      secondary: Color(0xff775a0b),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffffdf9e),
      onSecondaryContainer: Color(0xff261a00),
      tertiary: Color(0xff39693c),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffbaf0b7),
      onTertiaryContainer: Color(0xff002106),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfff9f9ff),
      onSurface: Color(0xff1a1b20),
      onSurfaceVariant: Color(0xff44474f),
      outline: Color(0xff74777f),
      outlineVariant: Color(0xffc4c6d0),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2f3036),
      inversePrimary: Color(0xffadc7ff),
      primaryFixed: Color(0xffd8e2ff),
      onPrimaryFixed: Color(0xff001a41),
      primaryFixedDim: Color(0xffadc7ff),
      onPrimaryFixedVariant: Color(0xff2a4678),
      secondaryFixed: Color(0xffffdf9e),
      onSecondaryFixed: Color(0xff261a00),
      secondaryFixedDim: Color(0xffe9c16c),
      onSecondaryFixedVariant: Color(0xff5b4300),
      tertiaryFixed: Color(0xffbaf0b7),
      onTertiaryFixed: Color(0xff002106),
      tertiaryFixedDim: Color(0xff9ed49c),
      onTertiaryFixedVariant: Color(0xff205026),
      surfaceDim: Color(0xffd9d9e0),
      surfaceBright: Color(0xfff9f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f3fa),
      surfaceContainer: Color(0xffededf4),
      surfaceContainerHigh: Color(0xffe8e7ee),
      surfaceContainerHighest: Color(0xffe2e2e9),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff264273),
      surfaceTint: Color(0xff435e91),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff5a74a9),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff563f00),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff907023),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff1c4c22),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff4f8050),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff9f9ff),
      onSurface: Color(0xff1a1b20),
      onSurfaceVariant: Color(0xff40434b),
      outline: Color(0xff5c5f67),
      outlineVariant: Color(0xff787a83),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2f3036),
      inversePrimary: Color(0xffadc7ff),
      primaryFixed: Color(0xff5a74a9),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff415c8e),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff907023),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff755708),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff4f8050),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff366639),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd9d9e0),
      surfaceBright: Color(0xfff9f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f3fa),
      surfaceContainer: Color(0xffededf4),
      surfaceContainerHigh: Color(0xffe8e7ee),
      surfaceContainerHighest: Color(0xffe2e2e9),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff00214d),
      surfaceTint: Color(0xff435e91),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff264273),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff2e2000),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff563f00),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff002909),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff1c4c22),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff9f9ff),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff21242b),
      outline: Color(0xff40434b),
      outlineVariant: Color(0xff40434b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2f3036),
      inversePrimary: Color(0xffe6ecff),
      primaryFixed: Color(0xff264273),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff092b5c),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff563f00),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff3b2a00),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff1c4c22),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff01350e),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd9d9e0),
      surfaceBright: Color(0xfff9f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f3fa),
      surfaceContainer: Color(0xffededf4),
      surfaceContainerHigh: Color(0xffe8e7ee),
      surfaceContainerHighest: Color(0xffe2e2e9),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffadc7ff),
      surfaceTint: Color(0xffadc7ff),
      onPrimary: Color(0xff0f2f60),
      primaryContainer: Color(0xff2a4678),
      onPrimaryContainer: Color(0xffd8e2ff),
      secondary: Color(0xffe9c16c),
      onSecondary: Color(0xff3f2e00),
      secondaryContainer: Color(0xff5b4300),
      onSecondaryContainer: Color(0xffffdf9e),
      tertiary: Color(0xff9ed49c),
      onTertiary: Color(0xff053911),
      tertiaryContainer: Color(0xff205026),
      onTertiaryContainer: Color(0xffbaf0b7),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff111318),
      onSurface: Color(0xffe2e2e9),
      onSurfaceVariant: Color(0xffc4c6d0),
      outline: Color(0xff8e9099),
      outlineVariant: Color(0xff44474f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe2e2e9),
      inversePrimary: Color(0xff435e91),
      primaryFixed: Color(0xffd8e2ff),
      onPrimaryFixed: Color(0xff001a41),
      primaryFixedDim: Color(0xffadc7ff),
      onPrimaryFixedVariant: Color(0xff2a4678),
      secondaryFixed: Color(0xffffdf9e),
      onSecondaryFixed: Color(0xff261a00),
      secondaryFixedDim: Color(0xffe9c16c),
      onSecondaryFixedVariant: Color(0xff5b4300),
      tertiaryFixed: Color(0xffbaf0b7),
      onTertiaryFixed: Color(0xff002106),
      tertiaryFixedDim: Color(0xff9ed49c),
      onTertiaryFixedVariant: Color(0xff205026),
      surfaceDim: Color(0xff111318),
      surfaceBright: Color(0xff37393e),
      surfaceContainerLowest: Color(0xff0c0e13),
      surfaceContainerLow: Color(0xff1a1b20),
      surfaceContainer: Color(0xff1e2025),
      surfaceContainerHigh: Color(0xff282a2f),
      surfaceContainerHighest: Color(0xff33353a),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffb3cbff),
      surfaceTint: Color(0xffadc7ff),
      onPrimary: Color(0xff001537),
      primaryContainer: Color(0xff7691c7),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffedc670),
      onSecondary: Color(0xff1f1500),
      secondaryContainer: Color(0xffaf8c3d),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffa3d8a0),
      onTertiary: Color(0xff001b04),
      tertiaryContainer: Color(0xff6a9d6a),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff111318),
      onSurface: Color(0xfffbfaff),
      onSurfaceVariant: Color(0xffc9cad4),
      outline: Color(0xffa0a2ac),
      outlineVariant: Color(0xff81838c),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe2e2e9),
      inversePrimary: Color(0xff2c4779),
      primaryFixed: Color(0xffd8e2ff),
      onPrimaryFixed: Color(0xff00102d),
      primaryFixedDim: Color(0xffadc7ff),
      onPrimaryFixedVariant: Color(0xff173566),
      secondaryFixed: Color(0xffffdf9e),
      onSecondaryFixed: Color(0xff191000),
      secondaryFixedDim: Color(0xffe9c16c),
      onSecondaryFixedVariant: Color(0xff473300),
      tertiaryFixed: Color(0xffbaf0b7),
      onTertiaryFixed: Color(0xff001603),
      tertiaryFixedDim: Color(0xff9ed49c),
      onTertiaryFixedVariant: Color(0xff0d3f17),
      surfaceDim: Color(0xff111318),
      surfaceBright: Color(0xff37393e),
      surfaceContainerLowest: Color(0xff0c0e13),
      surfaceContainerLow: Color(0xff1a1b20),
      surfaceContainer: Color(0xff1e2025),
      surfaceContainerHigh: Color(0xff282a2f),
      surfaceContainerHighest: Color(0xff33353a),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffbfaff),
      surfaceTint: Color(0xffadc7ff),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffb3cbff),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfffffaf7),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffedc670),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfff0ffeb),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffa3d8a0),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff111318),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfffbfaff),
      outline: Color(0xffc9cad4),
      outlineVariant: Color(0xffc9cad4),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe2e2e9),
      inversePrimary: Color(0xff052959),
      primaryFixed: Color(0xffdee7ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffb3cbff),
      onPrimaryFixedVariant: Color(0xff001537),
      secondaryFixed: Color(0xffffe4af),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffedc670),
      onSecondaryFixedVariant: Color(0xff1f1500),
      tertiaryFixed: Color(0xffbef5bb),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffa3d8a0),
      onTertiaryFixedVariant: Color(0xff001b04),
      surfaceDim: Color(0xff111318),
      surfaceBright: Color(0xff37393e),
      surfaceContainerLowest: Color(0xff0c0e13),
      surfaceContainerLow: Color(0xff1a1b20),
      surfaceContainer: Color(0xff1e2025),
      surfaceContainerHigh: Color(0xff282a2f),
      surfaceContainerHighest: Color(0xff33353a),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.surface,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
