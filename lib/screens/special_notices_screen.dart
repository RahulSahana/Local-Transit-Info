import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/train_data.dart';
import '../models/train.dart';
import '../theme.dart';
import '../widgets/status_badge.dart';
import '../widgets/train_details_sheet.dart';

class SpecialNoticesScreen extends StatelessWidget {
  const SpecialNoticesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const notices = TrainData.specialNotices;

    // Group by date
    final Map<String, List<SpecialNotice>> grouped = {};
    for (final n in notices) {
      grouped.putIfAbsent(n.date, () => []).add(n);
    }

    return notices.isEmpty
        ? Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle_outline_rounded,
                    size: 48,
                    color: const Color(0xFF22c55e).withValues(alpha: 0.6)),
                const SizedBox(height: 12),
                Text(
                  'No special notices',
                  style: GoogleFonts.oswald(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          )
        : ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            children: grouped.entries.map((entry) {
              return _DateGroup(
                date: entry.key,
                notices: entry.value,
                isDark: isDark,
              );
            }).toList(),
          );
  }
}

class _DateGroup extends StatelessWidget {
  final String date;
  final List<SpecialNotice> notices;
  final bool isDark;

  const _DateGroup({
    required this.date,
    required this.notices,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    // Sub-group by notice type
    final Map<TrainStatus, List<SpecialNotice>> byType = {};
    for (final n in notices) {
      byType.putIfAbsent(n.noticeType, () => []).add(n);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Date header
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            color: AppTheme.alertColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppTheme.alertColor.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Icon(Icons.calendar_today_rounded,
                  size: 14, color: AppTheme.alertColor),
              const SizedBox(width: 8),
              Text(
                date,
                style: TextStyle(
                  color: AppTheme.alertColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  letterSpacing: 0.3,
                ),
              ),
              const Spacer(),
              Text(
                '${notices.length} train${notices.length != 1 ? 's' : ''}',
                style: TextStyle(
                  color: AppTheme.alertColor.withValues(alpha: 0.7),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
        ...byType.entries.map((e) => _TypeGroup(
              type: e.key,
              notices: e.value,
              isDark: isDark,
            )),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _TypeGroup extends StatelessWidget {
  final TrainStatus type;
  final List<SpecialNotice> notices;
  final bool isDark;

  const _TypeGroup({
    required this.type,
    required this.notices,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(2, 4, 0, 6),
          child: Row(
            children: [
              StatusBadge(status: type),
              const SizedBox(width: 6),
              Text(
                '${notices.length}',
                style: TextStyle(
                  fontSize: 11,
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ),
        ...notices.map((n) => _NoticeCard(notice: n, isDark: isDark)),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _NoticeCard extends StatelessWidget {
  final SpecialNotice notice;
  final bool isDark;

  const _NoticeCard({required this.notice, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final train = notice.train;
    final isUp = train.direction == 'UP';
    final dirColor = isUp ? AppTheme.upDirectionColor : AppTheme.dnDirectionColor;

    return GestureDetector(
      onTap: () => showTrainDetails(context, train),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1e293b) : Colors.white,
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
                Text(
                  '#${train.trainNo}',
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                  decoration: BoxDecoration(
                    color: dirColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    train.direction,
                    style: TextStyle(
                      color: dirColor,
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  'Dep: ${train.depTime12}',
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 10,
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              train.trainName,
              style: GoogleFonts.oswald(
                fontSize: 13.5,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            if (notice.detail != null && notice.detail!.isNotEmpty) ...[
              const SizedBox(height: 6),
              Row(
                children: [
                  Icon(Icons.info_outline_rounded,
                      size: 12, color: AppTheme.alertColor),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      notice.detail!,
                      style: TextStyle(
                        fontSize: 11,
                        color: AppTheme.alertColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
