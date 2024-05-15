import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class AppThemes {
  final TextTheme textTheme;

  const AppThemes(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff002589),
      surfaceTint: Color(0xff3153ce),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff2347c3),
      onPrimaryContainer: Color(0xfff7f6ff),
      secondary: Color(0xff785a00),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xfff2b915),
      onSecondaryContainer: Color(0xff423000),
      tertiary: Color(0xff002589),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff2347c3),
      onTertiaryContainer: Color(0xfff7f6ff),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      background: Color(0xfffbf8ff),
      onBackground: Color(0xff1a1b23),
      surface: Color(0xfffbf8ff),
      onSurface: Color(0xff1a1b23),
      surfaceVariant: Color(0xffe1e1f3),
      onSurfaceVariant: Color(0xff444654),
      outline: Color(0xff747685),
      outlineVariant: Color(0xffc4c5d6),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2f3038),
      inverseOnSurface: Color(0xfff1f0fa),
      inversePrimary: Color(0xffb8c4ff),
      primaryFixed: Color(0xffdde1ff),
      onPrimaryFixed: Color(0xff001454),
      primaryFixedDim: Color(0xffb8c4ff),
      onPrimaryFixedVariant: Color(0xff0938b6),
      secondaryFixed: Color(0xffffdf9c),
      onSecondaryFixed: Color(0xff251a00),
      secondaryFixedDim: Color(0xfff8be1d),
      onSecondaryFixedVariant: Color(0xff5b4300),
      tertiaryFixed: Color(0xffdde1ff),
      onTertiaryFixed: Color(0xff001454),
      tertiaryFixedDim: Color(0xffb8c4ff),
      onTertiaryFixedVariant: Color(0xff0938b6),
      surfaceDim: Color(0xffdad9e4),
      surfaceBright: Color(0xfffbf8ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff4f2fd),
      surfaceContainer: Color(0xffeeedf8),
      surfaceContainerHigh: Color(0xffe8e7f2),
      surfaceContainerHighest: Color(0xffe2e1ec),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xffb8c4ff),
      surfaceTint: Color(0xffb8c4ff),
      onPrimary: Color(0xff002486),
      primaryContainer: Color(0xff002da0),
      onPrimaryContainer: Color(0xffc3ccff),
      secondary: Color(0xffffd780),
      onSecondary: Color(0xff3f2e00),
      secondaryContainer: Color(0xffe1aa00),
      onSecondaryContainer: Color(0xff342500),
      tertiary: Color(0xffb8c4ff),
      onTertiary: Color(0xff002486),
      tertiaryContainer: Color(0xff002da0),
      onTertiaryContainer: Color(0xffc3ccff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      background: Color(0xff12131a),
      onBackground: Color(0xffe2e1ec),
      surface: Color(0xff12131a),
      onSurface: Color(0xffe2e1ec),
      surfaceVariant: Color(0xff444654),
      onSurfaceVariant: Color(0xffc4c5d6),
      outline: Color(0xff8e909f),
      outlineVariant: Color(0xff444654),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe2e1ec),
      inverseOnSurface: Color(0xff2f3038),
      inversePrimary: Color(0xff3153ce),
      primaryFixed: Color(0xffdde1ff),
      onPrimaryFixed: Color(0xff001454),
      primaryFixedDim: Color(0xffb8c4ff),
      onPrimaryFixedVariant: Color(0xff0938b6),
      secondaryFixed: Color(0xffffdf9c),
      onSecondaryFixed: Color(0xff251a00),
      secondaryFixedDim: Color(0xfff8be1d),
      onSecondaryFixedVariant: Color(0xff5b4300),
      tertiaryFixed: Color(0xffdde1ff),
      onTertiaryFixed: Color(0xff001454),
      tertiaryFixedDim: Color(0xffb8c4ff),
      onTertiaryFixedVariant: Color(0xff0938b6),
      surfaceDim: Color(0xff12131a),
      surfaceBright: Color(0xff383941),
      surfaceContainerLowest: Color(0xff0c0e15),
      surfaceContainerLow: Color(0xff1a1b23),
      surfaceContainer: Color(0xff1e1f27),
      surfaceContainerHigh: Color(0xff282931),
      surfaceContainerHighest: Color(0xff33343c),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary, 
    required this.surfaceTint, 
    required this.onPrimary, 
    required this.primaryContainer, 
    required this.onPrimaryContainer, 
    required this.secondary, 
    required this.onSecondary, 
    required this.secondaryContainer, 
    required this.onSecondaryContainer, 
    required this.tertiary, 
    required this.onTertiary, 
    required this.tertiaryContainer, 
    required this.onTertiaryContainer, 
    required this.error, 
    required this.onError, 
    required this.errorContainer, 
    required this.onErrorContainer, 
    required this.background, 
    required this.onBackground, 
    required this.surface, 
    required this.onSurface, 
    required this.surfaceVariant, 
    required this.onSurfaceVariant, 
    required this.outline, 
    required this.outlineVariant, 
    required this.shadow, 
    required this.scrim, 
    required this.inverseSurface, 
    required this.inverseOnSurface, 
    required this.inversePrimary, 
    required this.primaryFixed, 
    required this.onPrimaryFixed, 
    required this.primaryFixedDim, 
    required this.onPrimaryFixedVariant, 
    required this.secondaryFixed, 
    required this.onSecondaryFixed, 
    required this.secondaryFixedDim, 
    required this.onSecondaryFixedVariant, 
    required this.tertiaryFixed, 
    required this.onTertiaryFixed, 
    required this.tertiaryFixedDim, 
    required this.onTertiaryFixedVariant, 
    required this.surfaceDim, 
    required this.surfaceBright, 
    required this.surfaceContainerLowest, 
    required this.surfaceContainerLow, 
    required this.surfaceContainer, 
    required this.surfaceContainerHigh, 
    required this.surfaceContainerHighest, 
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
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

TextTheme createTextTheme(
    BuildContext context, String bodyFontString, String displayFontString) {
  TextTheme baseTextTheme = Theme.of(context).textTheme;
  TextTheme bodyTextTheme = GoogleFonts.getTextTheme(bodyFontString, baseTextTheme);
  TextTheme displayTextTheme =
      GoogleFonts.getTextTheme(displayFontString, baseTextTheme);
  TextTheme textTheme = displayTextTheme.copyWith(
    bodyLarge: bodyTextTheme.bodyLarge,
    bodyMedium: bodyTextTheme.bodyMedium,
    bodySmall: bodyTextTheme.bodySmall,
    labelLarge: bodyTextTheme.labelLarge,
    labelMedium: bodyTextTheme.labelMedium,
    labelSmall: bodyTextTheme.labelSmall,
  );
  return textTheme;
}