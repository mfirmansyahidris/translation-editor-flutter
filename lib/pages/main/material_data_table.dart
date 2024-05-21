import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:material_table_view/default_animated_switcher_transition_builder.dart';
import 'package:material_table_view/material_table_view.dart';
import 'package:material_table_view/shimmer_placeholder_shade.dart';
import 'package:material_table_view/table_column_control_handles_popup_route.dart';
import 'package:material_table_view/table_view_typedefs.dart';
import 'package:msq_translation_editor/msq_translation_editor.dart';

class _MyTableColumn extends TableColumn {
  _MyTableColumn({
    required int index,
    required this.label,
    required super.width,
    super.freezePriority = 0,
    super.sticky = false,
    super.flex = 0,
    super.translation = 0,
    super.minResizeWidth,
    super.maxResizeWidth,
  })  : key = ValueKey<int>(index),
        // ignore: prefer_initializing_formals
        index = index;

  final int index;
  final String label;

  @override
  final ValueKey<int> key;

  @override
  _MyTableColumn copyWith({
    double? width,
    int? freezePriority,
    bool? sticky,
    int? flex,
    double? translation,
    double? minResizeWidth,
    double? maxResizeWidth,

  }) =>
      _MyTableColumn(
        index: index,
        label: label,
        width: width ?? this.width,
        freezePriority: freezePriority ?? this.freezePriority,
        sticky: sticky ?? this.sticky,
        flex: flex ?? this.flex,
        translation: translation ?? this.translation,
        minResizeWidth: minResizeWidth ?? this.minResizeWidth,
        maxResizeWidth: maxResizeWidth ?? this.maxResizeWidth,
      );
}


class MaterialDataTable extends StatefulWidget {
  const MaterialDataTable({super.key});

  @override
  State<MaterialDataTable> createState() => MaterialDataTableState();
}

class MaterialDataTableState extends State<MaterialDataTable>
    with SingleTickerProviderStateMixin<MaterialDataTable> {

  final stylingController = StylingController();

  int? selection;
  int placeholderOffsetIndex = 0;


  List<String> get _languages => Di.translation.languages.keys.toList();

  List<String> _keys = [];

  final columns = <_MyTableColumn>[];

  @override
  void initState() {
    super.initState();

    columns.addAll([
      _MyTableColumn(
        index: 0,
        label: "#",
        width: 100,
        freezePriority: 1,
        sticky: true,
      ),

      _MyTableColumn(
        index: 1,
        label: "key",
        width: 200,
        freezePriority: 1,
        sticky: true,
      ),

      for (var i = 0; i < _languages.length; i++)
        _MyTableColumn(
          index: i + 2,
          label: _languages[i],
          width: 250,
          minResizeWidth: 64.0,
        ),
    ]);
    setKeys();
  }

  void setKeys({String? search}){
    final keys = <String>{};
    for (var language in _languages) { 
      keys.addAll(Di.translation.languages[language]?.keys.toList() ?? []);
    }
    final listKey = keys.toList();
    listKey.sort((a, b) => a.compareTo(b));

    if((search ?? '').isNotEmpty){
      _keys = listKey.where((element) => element.toUpperCase().contains(search!.toUpperCase())).toList();
    }else{
      _keys = listKey;
    }
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    const shimmerBaseColor = Color(0x20808080);
    const shimmerHighlightColor = Color(0x40FFFFFF);

    return Scaffold(
      body: ShimmerPlaceholderShadeProvider(
        loopDuration: const Duration(seconds: 2),
        colors: const [
          shimmerBaseColor,
          shimmerHighlightColor,
          shimmerBaseColor,
          shimmerHighlightColor,
          shimmerBaseColor
        ],
        stops: const [.0, .45, .5, .95, 1],
        builder: (context, placeholderShade) => LayoutBuilder(
          builder: (context, constraints) {
            columns[0] =
                columns[0].copyWith(sticky: constraints.maxWidth <= 512);
            return _buildBoxExample(
              context,
              placeholderShade,
            );
          },
        ),
      ),
    );
  }

  Widget _buildBoxExample(
    BuildContext context,
    TablePlaceholderShade placeholderShade,
  ) =>
      TableView.builder(
        columns: columns,
        style: TableViewStyle(
          dividers: TableViewDividersStyle(
            vertical: TableViewVerticalDividersStyle.symmetric(
              TableViewVerticalDividerStyle(
                  wigglesPerRow:
                      stylingController.verticalDividerWigglesPerRow,
                  wiggleOffset:
                      stylingController.verticalDividerWiggleOffset
              ),
            ),
          ),
        ),
        rowHeight: 48.0 + 4 * Theme.of(context).visualDensity.vertical,
        rowCount: _keys.length,
        rowBuilder: _rowBuilder,
        placeholderBuilder: _placeholderBuilder,
        placeholderShade: placeholderShade,
        headerBuilder: _headerBuilder,
        bodyContainerBuilder: (context, bodyContainer) => bodyContainer,
      );

  Widget _headerBuilder(
    BuildContext context,
    TableRowContentBuilder contentBuilder,
  ) =>
      contentBuilder(
        context,
        (context, column) => Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: () => Navigator.of(context)
                  .push(_createColumnControlsRoute(context, column)),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    columns[column].label,
                    style: TextStyles.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),
          ),
      );

  ModalRoute<void> _createColumnControlsRoute(
    BuildContext cellBuildContext,
    int columnIndex,
  ) =>
      TableColumnControlHandlesPopupRoute.realtime(
        controlCellBuildContext: cellBuildContext,
        columnIndex: columnIndex,
        tableViewChanged: null,
        onColumnTranslate: (index, newTranslation) => setState(
          () => columns[index] =
              columns[index].copyWith(translation: newTranslation),
        ),
        onColumnResize: (index, newWidth) => setState(
          () => columns[index] = columns[index].copyWith(width: newWidth),
        ),
        onColumnMove: (oldIndex, newIndex) => setState(
          () => columns.insert(newIndex, columns.removeAt(oldIndex)),
        ),
        leadingImmovableColumnCount: 1,
        popupBuilder: (context, animation, secondaryAnimation, columnWidth) =>
            PreferredSize(
          preferredSize: Size(min(256, max(192, columnWidth)), 256),
          child: FadeTransition(
            opacity: animation,
            child: Material(
              type: MaterialType.card,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                side: Divider.createBorderSide(context),
                borderRadius: const BorderRadius.all(
                  Radius.circular(16.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Custom widget to control sorting, stickiness and whatever',
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Button to cancel the controls',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget _wrapRow(Widget child) => DecoratedBox(
        position: DecorationPosition.foreground,
        decoration: BoxDecoration(
          border: Border(bottom: Divider.createBorderSide(context))
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: tableRowDefaultAnimatedSwitcherTransitionBuilder,
          child: child,
        ),
      );

  Widget? _rowBuilder(
    BuildContext context,
    int row,
    TableRowContentBuilder contentBuilder,
  ) {
    final selected = selection == row;

    var textStyle = Theme.of(context).textTheme.bodyMedium;
    if (selected) {
      textStyle = textStyle?.copyWith(
          color: Theme.of(context).colorScheme.onPrimaryContainer);
    }
    
    // return null to display shimmer effect

    return _wrapRow(
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              color: Theme.of(context)
                  .colorScheme
                  .primaryContainer
                  .withAlpha(selected ? 0xFF : 0),
              child: Material(
                type: MaterialType.transparency,
                child: GestureDetector(
                  onSecondaryTapUp: (detail){
                    setState(() {
                      selection = row;
                    });
                    _showContextMenu(context, detail.globalPosition);
                  },
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        selection = row;
                      });
                      final Map<String, String> translation = {};
                      for(final lang in _languages){
                        translation[lang] = Di.translation.languages[lang]?[_keys[row]] ?? "";
                      }
                      showDialog(
                        context: context, 
                        builder: (context) => DetailDialog(
                          keyword: _keys[row],
                          isEdit: true,
                          translation: translation,
                        )
                      );
                    },
                    child: contentBuilder(
                      context,
                      (context, column){
                        String text = "";
                        if(column == 0){
                          text = (row + 1).toString();
                        }else if(column == 1){
                          text = _keys[row];
                        }else{
                          text = Di.translation.languages[_languages[column - 2]]?[_keys[row]] ?? "";
                        }
                        return Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              text,
                              style: textStyle,
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  void _showContextMenu(BuildContext context, Offset position) {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    showMenu(
      context: context,
      position: RelativeRect.fromRect(
        Rect.fromPoints(
          overlay.localToGlobal(position),
          overlay.localToGlobal(position),
        ),
        Offset.zero & overlay.size,
      ),
      items: <PopupMenuEntry>[
        PopupMenuItem(
          onTap: (){
            
          },
          child: const Text(Strings.view).tr(),
        ),
        PopupMenuItem(
          child: Text(
            Strings.delete,
            style: TextStyle(
              color: Palette.error
            ),
          ).tr(),
        ),
      ],
    );
  }

  Widget _placeholderBuilder(
    BuildContext context,
    TableRowContentBuilder contentBuilder,
  ) =>
      _wrapRow(
        contentBuilder(
          context, (context, column) => const Padding(
              padding: EdgeInsets.all(8.0),
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(16)))),
            ),
        ),
      );
}