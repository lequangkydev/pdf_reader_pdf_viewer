import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../gen/assets.gen.dart';
import '../../../shared/extension/context_extension.dart';
import '../cubit/pdf_search_cubit.dart';
import '../cubit/toggle_ui_cubit.dart';

typedef SearchTapCallback = void Function(Object item);

class SearchToolbar extends StatefulWidget {
  const SearchToolbar({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  SearchToolbarState createState() => SearchToolbarState();
}

class SearchToolbarState extends State<SearchToolbar> {
  FocusNode? focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    focusNode!.addListener(() {
      if (focusNode!.hasFocus) {
        context.read<ToggleUiCubit>().show();
      }
    });
  }

  @override
  void dispose() {
    focusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PdfSearchCubit, PdfSearchState>(
      builder: (context, state) {
        return Row(
          children: <Widget>[
            IconButton(
              onPressed: () {
                widget.searchController.clear();
                context.read<PdfSearchCubit>().clear();
                context.maybePop();
              },
              icon: Assets.icons.arrowBack.svg(
                width: 24,
                height: 24,
              ),
            ),
            12.horizontalSpace,
            Flexible(
              child: TextField(
                style: TextStyle(
                    color: const Color(0x00000000).withOpacity(0.87),
                    fontSize: 12),
                enableInteractiveSelection: false,
                focusNode: focusNode,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                controller: widget.searchController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  hintText: context.l10n.search,
                  hintStyle: TextStyle(
                      color: const Color(0x00000000).withOpacity(0.34)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Color(0xffEDEDED)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Color(0xffEDEDED)),
                  ),
                ),
                onChanged: (text) {
                  if (text.isNotEmpty) {
                    context.read<PdfSearchCubit>().search(text);
                  } else {
                    widget.searchController.clear();
                    context.read<PdfSearchCubit>().clear();
                  }
                },
              ),
            ),
            Visibility(
              visible: widget.searchController.text.isNotEmpty,
              child: Material(
                color: Colors.transparent,
                child: IconButton(
                  icon: const Icon(
                    Icons.clear,
                    color: Color.fromRGBO(0, 0, 0, 0.54),
                    size: 24,
                  ),
                  onPressed: () {
                    context.read<ToggleUiCubit>().toggle();
                    context.read<PdfSearchCubit>().clear();
                    widget.searchController.clear();
                  },
                ),
              ),
            ),
            Visibility(
              visible: state.searchResult.hasResult,
              child: Row(
                children: [
                  Text(
                    '${state.searchResult.currentInstanceIndex}',
                    style: TextStyle(
                        color: const Color.fromRGBO(0, 0, 0, 0.54)
                            .withOpacity(0.87),
                        fontSize: 16),
                  ),
                  Text(
                    ' - ',
                    style: TextStyle(
                        color: const Color.fromRGBO(0, 0, 0, 0.54)
                            .withOpacity(0.87),
                        fontSize: 16),
                  ),
                  Text(
                    '${state.searchResult.totalInstanceCount}',
                    style: TextStyle(
                        color: const Color.fromRGBO(0, 0, 0, 0.54)
                            .withOpacity(0.87),
                        fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: state.searchResult.previousInstance,
                    child: const Icon(
                      Icons.navigate_before,
                      color: Color.fromRGBO(0, 0, 0, 0.54),
                      size: 28,
                    ),
                  ),
                  GestureDetector(
                    onTap: state.searchResult.nextInstance,
                    child: const Icon(
                      Icons.navigate_next,
                      color: Color.fromRGBO(0, 0, 0, 0.54),
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
