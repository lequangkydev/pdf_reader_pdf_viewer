import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../../module/hive/hive_box.dart';
import '../../config/navigation/app_router.dart';
import '../../gen/assets.gen.dart';
import '../../shared/constants/app_colors.dart';
import '../../shared/extension/context_extension.dart';
import '../../shared/extension/number_extension.dart';
import '../../shared/widgets/app_bar/custom_appbar.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/dialog/loading_dialog.dart';
import 'widget/empty_signature.dart';
import 'widget/signature_painter.dart';

@RoutePage()
class SignatureScreen extends StatelessWidget {
  const SignatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: context.l10n.signature,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8).r,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: HiveBox.signature.listenable(),
                  builder: (context, value, child) {
                    if (value.isEmpty) {
                      return const EmptySignature();
                    }
                    return ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: value.length,
                      separatorBuilder: (context, index) => 8.vSpace,
                      itemBuilder: (context, index) {
                        final signature = value.getAt(index);
                        if (signature == null) {
                          return const SizedBox();
                        }
                        return SignatureItem(
                          signature: signature,
                          onDeleteTap: () {
                            signature.delete();
                          },
                          onTap: (imageBytes) {
                            context.maybePop(imageBytes);
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              10.vSpace,
              GestureDetector(
                onTap: () async {
                  context.pushRoute(const SignaturePadRoute());
                },
                child: DottedBorder(
                  options: const RoundedRectDottedBorderOptions(
                    padding: EdgeInsets.zero,
                    color: AppColors.b10,
                    radius: Radius.circular(10),
                    strokeWidth: 2,
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 14.r),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAFAFA),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.add, color: AppColors.pr),
                        12.horizontalSpace,
                        Text(
                          context.l10n.createSignature,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.pr,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              50.vSpace,
            ],
          ),
        ),
      ),
    );
  }
}

class SignatureItem extends StatefulWidget {
  const SignatureItem({
    super.key,
    required this.signature,
    required this.onDeleteTap,
    required this.onTap,
  });

  final Signature signature;
  final VoidCallback onDeleteTap;
  final void Function(File? file) onTap;

  @override
  State<SignatureItem> createState() => _SignatureItemState();
}

class _SignatureItemState extends State<SignatureItem>
    with TickerProviderStateMixin {
  late final SlidableController _slidableController = SlidableController(this);

  // key để capture widget
  final GlobalKey repaintKey = GlobalKey();

  Future<File?> _captureWidget() async {
    try {
      LoadingOverlay.show();
      final RenderRepaintBoundary boundary = repaintKey.currentContext!
          .findRenderObject()! as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? byteData =
          await image.toByteData(format: ImageByteFormat.png);
      if (byteData == null) {
        LoadingOverlay.hide();
        return null;
      }
      final file = await saveUint8ListToImage(
        byteData.buffer.asUint8List(),
        DateTime.now().toIso8601String(),
      );
      LoadingOverlay.hide();
      return file;
    } catch (e) {
      LoadingOverlay.hide();
      debugPrint("Error capturing widget: $e");
      return null;
    }
  }

  Future<File> saveUint8ListToImage(
      Uint8List imageBytes, String fileName) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(path.join(dir.path, '$fileName.png'));
    return file.writeAsBytes(imageBytes, flush: true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.redFF,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Slidable(
        // Specify a key if the Slidable is dismissible.
        key: const ValueKey(0),
        controller: _slidableController,

        // The end action pane is the one at the right or the bottom side.
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: .25,
          children: [
            SlidableAction(
              padding: EdgeInsets.zero,
              borderRadius: BorderRadius.circular(10.r),
              onPressed: (context) {
                widget.onDeleteTap();
              },
              backgroundColor: AppColors.redFF,
              foregroundColor: Colors.white,
              label: context.l10n.delete,
            ),
          ],
        ),

        // The child of the Slidable is what the user sees when the
        // component is not dragged.
        child: GestureDetector(
          onTap: () async {
            final bytes = await _captureWidget();
            if (bytes != null) {
              widget.onTap(bytes);
            }
          },
          child: Container(
            height: 60.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: const Color(0xfff2f2f2),
              ),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: RepaintBoundary(
                        key: repaintKey,
                        child: SizedBox(
                          width: widget.signature.width,
                          height: widget.signature.height,
                          child: CustomPaint(
                            painter: SignaturePainter(
                                widget.signature.strokes, null),
                            child: Container(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                CustomButton(
                  onTap: () {
                    _slidableController.openEndActionPane(
                      duration: Duration(milliseconds: 200),
                    );
                  },
                  padding:
                      EdgeInsets.symmetric(vertical: 19.h, horizontal: 13.w),
                  child: Assets.icons.icCloseRounded.svg(width: 20.r),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _slidableController.dispose();
    super.dispose();
  }
}
