import 'package:flutter/material.dart';
import 'package:material_table_view/material_table_view.dart';

final globalTargetPlatform = ValueNotifier<TargetPlatform?>(null);

class StylingController with ChangeNotifier {
  final int verticalDividerWigglesPerRow = 1;
  final double verticalDividerWiggleOffset = 9.0;

  TableViewStyle get tableViewStyle => TableViewStyle(
    dividers: TableViewDividersStyle(
      vertical: TableViewVerticalDividersStyle.symmetric(
        TableViewVerticalDividerStyle(
          wiggleOffset: verticalDividerWiggleOffset,
          wigglesPerRow: verticalDividerWigglesPerRow,
        ),
      ),
    ),
  );
}
