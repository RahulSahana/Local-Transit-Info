import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/train_data.dart';
import '../models/train.dart';
import '../widgets/next_train_widget.dart';
import '../widgets/train_card.dart';
import '../widgets/train_details_sheet.dart';

class TrainScheduleScreen extends StatefulWidget {
  final String direction; // 'UP' or 'DN'

  const TrainScheduleScreen({super.key, required this.direction});

  @override
  State<TrainScheduleScreen> createState() => _TrainScheduleScreenState();
}

class _TrainScheduleScreenState extends State<TrainScheduleScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  late Timer _timer;
  late DateTime _now;
  List<Train> _filteredTrains = [];

  List<Train> get _allTrains =>
      widget.direction == 'UP' ? TrainData.upTrains : TrainData.dnTrains;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _applyFilter();
    _timer = Timer.periodic(const Duration(seconds: 30), (_) {
      setState(() {
        _now = DateTime.now();
        _applyFilter();
      });
    });
    _searchController.addListener(() {
      setState(() {
        _query = _searchController.text.toLowerCase();
        _applyFilter();
      });
    });
  }

  void _applyFilter() {
    _filteredTrains = _allTrains.where((t) {
      if (_query.isEmpty) return true;
      return t.trainNo.contains(_query) ||
          t.trainName.toLowerCase().contains(_query);
    }).toList();
  }

  @override
  void dispose() {
    _timer.cancel();
    _searchController.dispose();
    super.dispose();
  }

  TrainStatus _computeStatus(Train t) {
    final nowMins = _now.hour * 60 + _now.minute;
    final dep = t.depMinutes;
    var arr = t.arrMinutes;
    if (arr < dep) arr += 24 * 60;

    if (nowMins > arr) return TrainStatus.reached;
    if (nowMins >= dep && nowMins <= arr) return TrainStatus.running;
    return TrainStatus.scheduled;
  }

  ({Train? train, int? minutesUntil}) _nextTrain() {
    final nowMins = _now.hour * 60 + _now.minute;
    for (final t in _allTrains) {
      final dep = t.depMinutes;
      if (dep > nowMins) {
        return (train: t, minutesUntil: dep - nowMins);
      }
    }
    return (train: null, minutesUntil: null);
  }

  Train _withLiveStatus(Train t) {
    final status = _computeStatus(t);
    return Train(
      trainNo: t.trainNo,
      trainName: t.trainName,
      direction: t.direction,
      depTime: t.depTime,
      arrTime: t.arrTime,
      status: status,
      detail: t.detail,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final next = _nextTrain();

    final liveFiltered = _filteredTrains
        .map((t) => _withLiveStatus(t))
        .toList();

    return Column(
      children: [
        // Next train widget
        const SizedBox(height: 12),
        NextTrainWidget(
          nextTrain: next.train,
          direction: widget.direction,
          minutesUntil: next.minutesUntil,
        ),

        // Search bar
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search by train number or name...',
              hintStyle: TextStyle(
                fontSize: 13,
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
              ),
              prefixIcon: Icon(
                Icons.search_rounded,
                size: 18,
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
              ),
              suffixIcon: _query.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear_rounded, size: 16),
                      onPressed: () => _searchController.clear(),
                    )
                  : null,
              filled: true,
              fillColor: isDark ? const Color(0xFF2D2421) : Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: isDark ? const Color(0xFF3E332F) : const Color(0xFFe2e8f0),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: isDark ? const Color(0xFF3E332F) : const Color(0xFFe2e8f0),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 1.5,
                ),
              ),
            ),
            style: GoogleFonts.jetBrainsMono(fontSize: 13),
          ),
        ),

        // Count indicator
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: Row(
            children: [
              Text(
                '${liveFiltered.length} train${liveFiltered.length != 1 ? 's' : ''}',
                style: TextStyle(
                  fontSize: 11,
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              // Legend
              const _LegendDot(color: Color(0xFF22c55e), label: 'Running'),
              const SizedBox(width: 10),
              const _LegendDot(color: Color(0xFF64748b), label: 'Reached'),
              const SizedBox(width: 10),
              const _LegendDot(color: Color(0xFF795548), label: 'Scheduled'),
            ],
          ),
        ),

        // Train list
        Expanded(
          child: liveFiltered.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.search_off_rounded,
                          size: 40,
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3)),
                      const SizedBox(height: 8),
                      Text(
                        'No trains found',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: liveFiltered.length,
                  padding: const EdgeInsets.only(bottom: 20),
                  itemBuilder: (context, index) {
                    final train = liveFiltered[index];
                    return TrainCard(
                      train: train,
                      onTap: () => showTrainDetails(context, train),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 3),
        Text(
          label,
          style: TextStyle(
            fontSize: 9,
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }
}
