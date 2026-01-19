import 'package:flutter/material.dart';

import '../../../data/model/file_model.dart';
import '../../../gen/assets.gen.dart';
import 'pdf_item.dart';

class PdfListView extends StatelessWidget {
  const PdfListView({
    super.key,
    required this.pdfList,
    required this.onTapPdf,
    this.pdfTrainIcon,
  });

  final List<FileModel> pdfList;
  final void Function(FileModel file) onTapPdf;
  final Widget? pdfTrainIcon;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: pdfList.length,
      itemBuilder: (context, index) {
        final fileData = pdfList[index];
        return GestureDetector(
          onTap: () => onTapPdf(fileData),
          child: PdfItem(
            pdfFile: fileData.file,
            trailing: pdfTrainIcon ?? Assets.icons.arrowRight.svg(),
            isLock: fileData.isLock,
          ),
        );
      },
      separatorBuilder: (context, index) => const Padding(
        padding: EdgeInsets.only(left: 44 + 32, right: 16),
        child: Divider(
          color: Color(0xffF2F2F2),
          height: 0,
        ),
      ),
    );
  }
}
