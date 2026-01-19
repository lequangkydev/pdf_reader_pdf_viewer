import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../extension/context_extension.dart';
import '../../utils/style_utils.dart';

final searchKey = GlobalKey<_SearchAppBarState>();

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  const SearchAppBar({
    super.key,
    required this.title,
    required this.onSearchChanged,
    this.onSearchDone,
    this.actionWidget,
    this.leadingWidget,
    this.onBack,
    this.tapSearch,
  });

  final String title;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String>? onSearchDone;
  final Widget? actionWidget;
  final Widget? leadingWidget;
  final VoidCallback? onBack;
  final VoidCallback? tapSearch;

  @override
  _SearchAppBarState createState() => _SearchAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SearchAppBarState extends State<SearchAppBar> {
  bool isSearch = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  void closeSearch() {
    setState(() {
      isSearch = false;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.title.isEmpty) {
      setState(() {
        isSearch = true;
      });
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      title: isSearch || widget.title.isEmpty
          ? TextField(
              focusNode: _focusNode,
              onChanged: widget.onSearchChanged,
              onSubmitted: widget.onSearchDone,
              decoration: InputDecoration(
                hintText: '${context.l10n.search}...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                hintStyle: const TextStyle(color: Colors.grey),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Assets.icons.search.svg(width: 16),
                ),
              ),
            )
          : Text(
              widget.title,
              style: StyleUtils.style.s18.semiBold.b75,
            ),
      actions: [
        if (widget.actionWidget == null)
          if (!isSearch)
            GestureDetector(
              onTap: () {
                widget.tapSearch?.call();
                _focusNode.requestFocus();
                setState(() {
                  isSearch = true;
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Assets.icons.search.svg(width: 24),
              ),
            ),
        if (widget.actionWidget != null) widget.actionWidget!
      ],
      leading: GestureDetector(
        onTap: () {
          //trường hợp cho AI
          if (widget.title.isEmpty) {
            context.maybePop();
            return;
          }
          if (isSearch) {
            setState(() {
              isSearch = false;
            });
            if (widget.onSearchDone != null) {
              widget.onSearchDone!('');
            }
          } else {
            if (widget.onBack != null) {
              widget.onBack!();
              return;
            }
            context.router.back();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: widget.leadingWidget ??
              Assets.icons.arrowBack.svg(width: 24, height: 24),
        ),
      ),
    );
  }
}
