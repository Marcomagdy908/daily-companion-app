// ─── features/altar/presentation/widgets/commitment_type_selector.dart ─
// Daily Companion (رفيق يومي) — Commitment type icon/grid selector
import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../models/altar_commitment.dart';

class CommitmentTypeSelector extends StatelessWidget {
  final CommitmentType? selectedType;
  final ValueChanged<CommitmentType> onTypeSelected;

  const CommitmentTypeSelector({
    super.key,
    required this.selectedType,
    required this.onTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    final types = CommitmentType.values;

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: types.map((type) {
        final info = commitmentTypeInfo[type.name] ??
            const CommitmentTypeInfo(
              labelAr: 'مخصص',
              labelEn: 'Custom',
              iconAsset: '✍️',
              colorHex: '#A8E6CF',
            );

        final isSelected = selectedType == type;
        final color = Color(int.parse(info.colorHex.replaceFirst('#', '0xFF')));

        return GestureDetector(
          onTap: () => onTypeSelected(type),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? color.withOpacity(0.3) : Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isSelected ? color : Colors.white.withOpacity(0.15),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(info.iconAsset, style: const TextStyle(fontSize: 18)),
                const SizedBox(width: 8),
                Text(
                  info.labelAr,
                  style: TextStyle(
                    color: isSelected ? color : Colors.white70,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
