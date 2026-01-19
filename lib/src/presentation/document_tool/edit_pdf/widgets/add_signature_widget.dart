// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../gen/assets.gen.dart';
// import '../../signature/widget/signature_painter.dart';
// import '../cubit/add_signature_cubit.dart';
// import '../cubit/edit_tool_type_cubit.dart';
// import '../cubit/position_tool_cubit.dart';
// import '../cubit/select_detail_tool_cubit.dart';
// import '../edit_pdf_screen.dart';
// import '../model/add_signature_state.dart';
//
// class AddSignatureWidget extends StatelessWidget {
//   const AddSignatureWidget({super.key, required this.pageSize});
//
//   final Size pageSize;
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<PositionToolCubit, Offset>(
//       builder: (context, positionState) {
//         return Positioned(
//           left: positionState.dx,
//           top: positionState.dy,
//           child: BlocBuilder<AddSignatureCubit, AddSignatureState>(
//             builder: (context, stateSignature) {
//               if (stateSignature.signature == null) {
//                 return const SizedBox.shrink();
//               }
//               return Stack(
//                 children: [
//                   GestureDetector(
//                     key: positionToolKey,
//                     onPanUpdate: (details) {
//                       context
//                           .read<PositionToolCubit>()
//                           .dragUpdatePosition(details, pageSize);
//                     },
//                     child: Container(
//                       margin: const EdgeInsets.all(10),
//                       padding: const EdgeInsets.all(8),
//                       alignment: Alignment.center,
//                       decoration: const BoxDecoration(
//                         color: Colors.transparent,
//                       ),
//                       constraints: const BoxConstraints(
//                         minWidth: 50,
//                         minHeight: 50,
//                       ),
//                       child: FittedBox(
//                         fit: BoxFit.scaleDown,
//                         child: SizedBox(
//                           width: stateSignature.width,
//                           height: stateSignature.height,
//                           child: CustomPaint(
//                             painter: SignaturePainter(
//                               stateSignature.signature!.strokes,
//                               null,
//                             ),
//                             child: Container(),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     child: GestureDetector(
//                       onTap: () {
//                         context.read<SelectDetailToolCubit>().clearDetailTool();
//                         context.read<EditToolTypeCubit>().clearTool();
//                       },
//                       child: Assets.icons.close.svg(width: 20),
//                     ),
//                   ),
//                   Positioned(
//                     right: 0,
//                     bottom: 0,
//                     child: GestureDetector(
//                       onPanUpdate: (details) {
//                         final newSize = Size(
//                           (stateSignature.width + details.delta.dx)
//                               .clamp(50, 300),
//                           (stateSignature.height + details.delta.dy)
//                               .clamp(50, 300),
//                         );
//                         context.read<AddSignatureCubit>().onResize(newSize);
//                       },
//                       child: Assets.icons.zoomInOut.svg(width: 20),
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }
