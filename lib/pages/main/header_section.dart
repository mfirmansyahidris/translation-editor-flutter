import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:msq_translation_editor/msq_translation_editor.dart';

class HeaderSection extends StatelessWidget {
  final Function(String)? onSearch;
  final VoidCallback? onAdd;

  HeaderSection({super.key, this.onSearch, this.onAdd});

  final Debounce _debounce = Debounce(delay: 300);

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.spaceDefault),
      child: Row(
        children: [
          ElevatedButton.icon(
            onPressed: onAdd,
            icon: const Icon(Icons.add),
            label: const Text(Strings.add).tr(),
          ),
          const Spacer(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Palette.outlineVariant)),
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.spaceDefault,
                  vertical: Dimens.spaceXXS + 1),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.search,
                    size: Dimens.iconL,
                    color: Palette.outline,
                  ),
                  SpacerH.XS,
                  Expanded(
                    child: TextFormField(
                      controller: _searchController,
                      style: TextStyles.bodyMedium,
                      maxLines: 1,
                      onChanged: (value){
                        _debounce.execute(() { 
                          onSearch?.call(value);
                        });
                      },
                      decoration: InputDecoration.collapsed(
                        hintText: Strings.search.tr(),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: (){
                      _searchController.clear();
                      onSearch?.call("");
                    }, 
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimens.spaceDefault,
                        vertical: Dimens.spaceXS
                      ),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(Strings.clear).tr()
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
