import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/train.dart';
import '../theme.dart';

class NextTrainWidget extends StatelessWidget {
  final Train? nextTrain;
  final String direction;
  final int? minutesUntil;

  const NextTrainWidget({
    super.key,
    required this.nextTrain,
    required this.direction,
    this.minutesUntil,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isUp = direction == 'UP';
    final dirColor = isUp ? AppTheme.upDirectionColor : AppTheme.dnDirectionColor;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            dirColor.withValues(alpha: isDark ? 0.25 : 0.12),
            dirColor.withValues(alpha: isDark ? 0.10 : 0.05),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: dirColor.withValues(alpha: 0.3), width: 1.5),
      ),
      child: nextTrain == null
          ? Row(
              children: [
                Icon(Icons.train_outlined, color: dirColor, size: 20),
                const SizedBox(width: 10),
                Text(
                  'No more trains today',
                  style: GoogleFonts.oswald(
                    color: dirColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.asset(
                      'lib/assets/logo.jpg',
                      width: 34,
                      height: 34,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'NEXT $direction TRAIN',
                        style: TextStyle(
                          color: dirColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        nextTrain!.trainName,
                        style: GoogleFonts.oswald(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '#${nextTrain!.trainNo}  ·  Dep: ${nextTrain!.depTime12}',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                if (minutesUntil != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: dirColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Text(
                          minutesUntil! < 60
                              ? '${minutesUntil}m'
                              : '${minutesUntil! ~/ 60}h ${minutesUntil! % 60}m',
                          style: GoogleFonts.jetBrainsMono(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Text(
                          'AWAY',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 8,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
    );
  }
}
