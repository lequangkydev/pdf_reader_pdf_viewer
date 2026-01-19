import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_colors.dart';
import '../../extension/context_extension.dart';

class InputSearch extends StatefulWidget {
  const InputSearch({
    super.key,
    this.hintText,
    this.onChanged,
  });

  final String? hintText;
  final Function(String value)? onChanged;

  @override
  State<InputSearch> createState() => _InputSearchState();
}

class _InputSearchState extends State<InputSearch> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
      ),
      height: 40.h,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _controller,
              onChanged: widget.onChanged,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              cursorColor: Colors.black54,
              decoration: InputDecoration(
                hintText: context.l10n.search,
                isDense: true,
                hintStyle: const TextStyle(
                  color: Colors.black38,
                  fontSize: 16,
                  height: 1,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                suffixIcon: _controller.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _controller.clear();
                        },
                        icon: const Icon(Icons.close, size: 20),
                        color: Colors.grey,
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50), // bo tròn
                  borderSide: const BorderSide(color: Colors.grey, width: 0.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: Colors.grey, width: 0.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: AppColors.pr),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
