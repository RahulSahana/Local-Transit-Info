import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color _primaryBrown = Color(0xFF3E2723);
  static const Color _accentGold = Color(0xFFe8b84b);
  static const Color _runningGreen = Color(0xFF22c55e);
  static const Color _reachedGray = Color(0xFF64748b);
  static const Color _cancelledRed = Color(0xFFef4444);
  static const Color _shortTerminateOrange = Color(0xFFf97316);
  static const Color _shortOriginPurple = Color(0xFF8b5cf6);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: _primaryBrown,
      secondary: _accentGold,
      surface: Color(0xFFfdfaf9),
      surfaceContainerHighest: Color(0xFFefebe9),
    ),
    textTheme: GoogleFonts.sourceCodeProTextTheme(),
    scaffoldBackgroundColor: const Color(0xFFf5f5f5),
    appBarTheme: AppBarTheme(
      backgroundColor: _primaryBrown,
      foregroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: GoogleFonts.oswald(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
      ),
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF8D6E63),
      secondary: _accentGold,
      surface: Color(0xFF2D2421),
      surfaceContainerHighest: Color(0xFF3E332F),
    ),
    textTheme: GoogleFonts.sourceCodeProTextTheme(ThemeData.dark().textTheme),
    scaffoldBackgroundColor: const Color(0xFF1B1514),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF2D2421),
      foregroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: GoogleFonts.oswald(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
      ),
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF2D2421),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );

  static Color statusColor(String status) {
    switch (status) {
      case 'running': return _runningGreen;
      case 'reached': return _reachedGray;
      case 'cancelled': return _cancelledRed;
      case 'shortTerminate': return _shortTerminateOrange;
      case 'shortOrigin': return _shortOriginPurple;
      default: return const Color(0xFF795548);
    }
  }

  static Color upDirectionColor = const Color(0xFF16a34a);
  static Color dnDirectionColor = const Color(0xFFdc2626);
  static Color alertColor = const Color(0xFFf59e0b);
}
