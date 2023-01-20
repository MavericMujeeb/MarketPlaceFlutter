import 'package:flutter/material.dart';
import 'package:marketplace/app/common/utils/constants.dart';

class CustomSearch extends StatelessWidget {

  final List<Map> searchOptions;
  static TextEditingController ?searchTextController;
  static FocusNode? searchFocusNode;
  Function? onSearchStarted;
  Function? detailActionCallBack;

  CustomSearch(Key? key, {required this.searchOptions, this.onSearchStarted, this.detailActionCallBack}) : super(key: key);

  static String _displayStringForOption(option) => option['name'];

  static Widget _customFieldViewBuilder(context, textEditingController, FocusNode focusNode, callBack){
    searchFocusNode = focusNode;
    searchTextController = textEditingController;
    return TextFormField(
      decoration: const InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        prefixIcon: Icon(Icons.search, size: 18, color: AppColor.white_color,),
        hintText: Constants.app_search_hint,
        hintStyle: TextStyle(color: AppColor.white_color),
      ),
      style: TextStyle(color: AppColor.white_color),
      controller: textEditingController,
      focusNode: focusNode,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Autocomplete<Map>(
      fieldViewBuilder:  _customFieldViewBuilder,
      displayStringForOption: _displayStringForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        onSearchStarted!(textEditingValue.text, searchTextController, searchFocusNode);
        return const Iterable.empty();
      },
      onSelected: (selectedOption){
        if(selectedOption['name'] == 'Addepar'){
          searchTextController?.text = '';
          searchFocusNode?.unfocus();
        }
      },
    );
  }
}