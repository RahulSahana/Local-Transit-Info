import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/train.dart';
import '../theme.dart';
import 'status_badge.dart';

void showTrainDetails(BuildContext context, Train train) {
  final isUp = train.direction == 'UP';
  final dirColor = isUp ? AppTheme.upDirectionColor : AppTheme.dnDirectionColor;
  final isDark = Theme.of(context).brightness == Brightness.dark;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) => Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1e293b) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF475569) : const Color(0xFFcbd5e1),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: dirColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.train_rounded, color: dirColor, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      train.trainName,
                      style: GoogleFonts.oswald(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(ctx).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Text(
                          'Train #${train.trainNo}',
                          style: GoogleFonts.jetBrainsMono(
                            fontSize: 12,
                            color: Theme.of(ctx).colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: dirColor.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            train.direction,
                            style: TextStyle(
                              color: dirColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              StatusBadge(status: train.status),
            ],
          ),

          const SizedBox(height: 20),
          Divider(color: isDark ? const Color(0xFF334155) : const Color(0xFFe2e8f0)),
          const SizedBox(height: 16),

          // Time info
          Row(
            children: [
              Expanded(
                child: _InfoTile(
                  icon: Icons.departure_board_rounded,
                  label: 'DEPARTURE',
                  value: train.depTime12,
                  color: dirColor,
                  isDark: isDark,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _InfoTile(
                  icon: Icons.flag_rounded,
                  label: 'ARRIVAL',
                  value: train.arrTime12,
                  color: dirColor,
                  isDark: isDark,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Duration
          _durationTile(context, train, dirColor, isDark),

          if (train.detail != null && train.detail!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.alertColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppTheme.alertColor.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline_rounded, color: AppTheme.alertColor, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      train.detail!,
                      style: TextStyle(
                        color: AppTheme.alertColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => Navigator.pop(ctx),
              style: TextButton.styleFrom(
                backgroundColor: isDark ? const Color(0xFF334155) : const Color(0xFFf1f5f9),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text(
                'Close',
                style: GoogleFonts.oswald(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(ctx).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final bool isDark;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0f172a) : const Color(0xFFf8fafc),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isDark ? const Color(0xFF334155) : const Color(0xFFe2e8f0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: color),
              const SizedBox(width: 5),
              Text(
                label,
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  color: color,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.jetBrainsMono(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _durationTile(BuildContext context, Train train, Color color, bool isDark) {
  final dep = train.depMinutes;
  var arr = train.arrMinutes;
  if (arr < dep) arr += 24 * 60; // crosses midnight
  final diff = arr - dep;
  final h = diff ~/ 60;
  final m = diff % 60;
  final durationStr = h > 0 ? '${h}h ${m}m' : '${m}m';

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: isDark ? const Color(0xFF0f172a) : const Color(0xFFf8fafc),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: isDark ? const Color(0xFF334155) : const Color(0xFFe2e8f0),
      ),
    ),
    child: Row(
      children: [
        Icon(Icons.timer_outlined, size: 16, color: color),
        const SizedBox(width: 8),
        Text(
          'Journey Duration: ',
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        Text(
          durationStr,
          style: GoogleFonts.jetBrainsMono(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ],
    ),
  );
}
