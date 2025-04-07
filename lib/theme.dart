import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff00395b),
      surfaceTint: Color(0xff2d628c),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff3e719b),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff293846),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff606f7e),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff3e3050),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff766689),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff7f9ff),
      onSurface: Color(0xff0e1215),
      onSurfaceVariant: Color(0xff31373d),
      outline: Color(0xff4d535a),
      outlineVariant: Color(0xff686e74),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d3135),
      inversePrimary: Color(0xff9acbfa),
      primaryFixed: Color(0xff3e719b),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff215981),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff606f7e),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff475665),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff766689),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff5d4e70),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc4c6cc),
      surfaceBright: Color(0xfff7f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff1f4f9),
      surfaceContainer: Color(0xffe6e8ee),
      surfaceContainerHigh: Color(0xffdadde2),
      surfaceContainerHighest: Color(0xffcfd2d7),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffc1e0ff),
      surfaceTint: Color(0xff9acbfa),
      onPrimary: Color(0xff002841),
      primaryContainer: Color(0xff6495c1),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffcedef0),
      onSecondary: Color(0xff182734),
      secondaryContainer: Color(0xff8392a3),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffe9d5fd),
      onTertiary: Color(0xff2d1f3e),
      tertiaryContainer: Color(0xff9b8aaf),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff101418),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffd8dde4),
      outline: Color(0xffadb2ba),
      outlineVariant: Color(0xff8b9198),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e2e8),
      inversePrimary: Color(0xff0d4c74),
      primaryFixed: Color(0xffcde5ff),
      onPrimaryFixed: Color(0xff001222),
      primaryFixedDim: Color(0xff9acbfa),
      onPrimaryFixedVariant: Color(0xff00395b),
      secondaryFixed: Color(0xffd4e4f6),
      onSecondaryFixed: Color(0xff03121f),
      secondaryFixedDim: Color(0xffb9c8da),
      onSecondaryFixedVariant: Color(0xff293846),
      tertiaryFixed: Color(0xffeedcff),
      onTertiaryFixed: Color(0xff170a28),
      tertiaryFixedDim: Color(0xffd2bfe7),
      onTertiaryFixedVariant: Color(0xff3e3050),
      surfaceDim: Color(0xff101418),
      surfaceBright: Color(0xff414549),
      surfaceContainerLowest: Color(0xff05080b),
      surfaceContainerLow: Color(0xff1a1e22),
      surfaceContainer: Color(0xff25282c),
      surfaceContainerHigh: Color(0xff2f3337),
      surfaceContainerHighest: Color(0xff3a3e42),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
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

  List<ExtendedColor> get extendedColors => [];
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
