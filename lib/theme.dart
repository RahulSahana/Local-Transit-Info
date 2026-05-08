import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color _primaryBlue = Color(0xFF1a365d);
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
      primary: _primaryBlue,
      secondary: _accentGold,
      surface: Color(0xFFf8fafc),
      surfaceContainerHighest: Color(0xFFe2e8f0),
    ),
    textTheme: GoogleFonts.sourceCodeProTextTheme(),
    scaffoldBackgroundColor: const Color(0xFFf1f5f9),
    appBarTheme: AppBarTheme(
      backgroundColor: _primaryBlue,
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
      primary: Color(0xFF3b82f6),
      secondary: _accentGold,
      surface: Color(0xFF1e293b),
      surfaceContainerHighest: Color(0xFF334155),
    ),
    textTheme: GoogleFonts.sourceCodeProTextTheme(ThemeData.dark().textTheme),
    scaffoldBackgroundColor: const Color(0xFF0f172a),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF1e293b),
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
      color: const Color(0xFF1e293b),
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
      default: return const Color(0xFF3b82f6);
    }
  }

  static Color upDirectionColor = const Color(0xFF16a34a);
  static Color dnDirectionColor = const Color(0xFFdc2626);
  static Color alertColor = const Color(0xFFf59e0b);
}
