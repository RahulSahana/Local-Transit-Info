import 'package:flutter/material.dart';
import '../models/train.dart';
import '../theme.dart';

class StatusBadge extends StatelessWidget {
  final TrainStatus status;
  final bool small;

  const StatusBadge({super.key, required this.status, this.small = false});

  @override
  Widget build(BuildContext context) {
    final (label, color) = _statusInfo(status);
    final fontSize = small ? 9.0 : 10.5;
    final padding = small
        ? const EdgeInsets.symmetric(horizontal: 6, vertical: 2)
        : const EdgeInsets.symmetric(horizontal: 8, vertical: 4);

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  static (String, Color) _statusInfo(TrainStatus status) {
    switch (status) {
      case TrainStatus.running:
        return ('RUNNING', AppTheme.statusColor('running'));
      case TrainStatus.reached:
        return ('REACHED', AppTheme.statusColor('reached'));
      case TrainStatus.cancelled:
        return ('CANCELLED', AppTheme.statusColor('cancelled'));
      case TrainStatus.shortTerminate:
        return ('SHORT TERM.', AppTheme.statusColor('shortTerminate'));
      case TrainStatus.shortOrigin:
        return ('SHORT ORIG.', AppTheme.statusColor('shortOrigin'));
      case TrainStatus.scheduled:
        return ('SCHEDULED', AppTheme.statusColor('scheduled'));
    }
  }
}

class DirectionBadge extends StatelessWidget {
  final String direction;

  const DirectionBadge({super.key, required this.direction});

  @override
  Widget build(BuildContext context) {
    final isUp = direction == 'UP';
    final color = isUp ? AppTheme.upDirectionColor : AppTheme.dnDirectionColor;

    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Icon(
          isUp ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
          color: Colors.white,
          size: 16,
        ),
      ),
    );
  }
}
