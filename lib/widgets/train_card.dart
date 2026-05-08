import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/train.dart';
import '../theme.dart';
import 'status_badge.dart';

class TrainCard extends StatelessWidget {
  final Train train;
  final VoidCallback onTap;

  const TrainCard({super.key, required this.train, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isRunning = train.status == TrainStatus.running;
    final isReached = train.status == TrainStatus.reached;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: isRunning
              ? AppTheme.upDirectionColor.withValues(alpha: isDark ? 0.12 : 0.06)
              : isDark
                  ? const Color(0xFF1e293b)
                  : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isRunning
                ? AppTheme.upDirectionColor.withValues(alpha: 0.4)
                : isDark
                    ? const Color(0xFF334155)
                    : const Color(0xFFe2e8f0),
            width: isRunning ? 1.5 : 1,
          ),
          boxShadow: isRunning
              ? [
                  BoxShadow(
                    color: AppTheme.upDirectionColor.withValues(alpha: 0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  )
                ]
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Row(
            children: [
              // Direction badge
              DirectionBadge(direction: train.direction),
              const SizedBox(width: 12),
              // Train info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '#${train.trainNo}',
                          style: GoogleFonts.jetBrainsMono(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        if (isRunning) ...[
                          const SizedBox(width: 6),
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: Color(0xFF22c55e),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      train.trainName,
                      style: GoogleFonts.oswald(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w500,
                        color: isReached
                            ? Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5)
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Times column
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.arrow_forward_rounded,
                          size: 10,
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4)),
                      const SizedBox(width: 3),
                      Text(
                        train.depTime12,
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: isReached
                              ? Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.45)
                              : Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  StatusBadge(status: train.status, small: true),
                ],
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.chevron_right_rounded,
                size: 16,
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
