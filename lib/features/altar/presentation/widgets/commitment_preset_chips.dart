// ─── features/altar/presentation/widgets/commitment_preset_chips.dart ──
// Daily Companion (رفيق يومي) — Quick-select preset commitment phrases
import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';

class CommitmentPresetChips extends StatelessWidget {
  final ValueChanged<String> onPresetSelected;

  const CommitmentPresetChips({super.key, required this.onPresetSelected});

  @override
  Widget build(BuildContext context) {
    // Using Arabic presets by default
    final presets = AppConstants.commitmentPresets['ar']!;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: presets.map((preset) {
        return GestureDetector(
          onTap: () => onPresetSelected(preset),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.15)),
            ),
            child: Text(
              preset,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 13,
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
        );
      }).toList(),
    );
  }
}
