// import 'package:flutter/material.dart';
// import 'package:flutter_ads/ads_flutter.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../config/di/di.dart';
// import '../../../config/navigation/app_router.dart';
// import '../../../gen/assets.gen.dart';
// import '../../../presentation/all_documents/cubit/all_file_cubit.dart';
// import '../../constants/app_colors.dart';
// import '../../cubit/ad_visibility_cubit.dart';
// import '../../enum/app_enum.dart';
// import '../../extension/context_extension.dart';
// import '../../helpers/permission_util.dart';
//
// class StoragePermissionBottomSheet extends StatefulWidget {
//   const StoragePermissionBottomSheet({super.key});
//
//   static Future<void> show({
//     required BuildContext context,
//   }) async {
//     getIt<AdVisibilityCubit>().update(false);
//     return showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(
//         top: Radius.circular(20.r),
//       )),
//       builder: (context) => const StoragePermissionBottomSheet(),
//     ).then(
//       (value) {
//         getIt<AdVisibilityCubit>().update(true);
//       },
//     );
//   }
//
//   @override
//   State<StoragePermissionBottomSheet> createState() =>
//       _StoragePermissionBottomSheetState();
// }
//
// class _StoragePermissionBottomSheetState
//     extends State<StoragePermissionBottomSheet> with TickerProviderStateMixin {
//   late final AnimationController _animationController = AnimationController(
//     vsync: this,
//     duration: const Duration(milliseconds: 500),
//     lowerBound: 1,
//     upperBound: 1.05,
//   )
//     ..addListener(
//       () {
//         if (_animationController.isCompleted) {
//           _animationController.reverse();
//         } else if (_animationController.isDismissed) {
//           _animationController.forward();
//         }
//       },
//     )
//     ..forward();
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 1.sw,
//       padding: const EdgeInsets.all(8.0).r,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             width: 32.w,
//             height: 3.h,
//             decoration: BoxDecoration(
//               color: AppColors.b10,
//               borderRadius: BorderRadius.circular(10.r),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 12).h,
//             child: Text(
//               context.l10n.permission,
//               style: TextStyle(
//                 fontSize: 16.sp,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//           Stack(
//             children: [
//               Assets.images.storagePermission.image(
//                 height: 210.r,
//               ),
//               Positioned(
//                 right: 10.r,
//                 top: 118.r,
//                 child: Assets.lotties.switchToggle.lottie(width: 50.r),
//               )
//             ],
//           ),
//           16.verticalSpace,
//           Text(
//             context.l10n.pleaseAllowAllDocumentsViewer,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 14.sp,
//               fontWeight: FontWeight.w600,
//               color: AppColors.color40,
//             ),
//           ),
//           32.verticalSpace,
//           AnimatedBuilder(
//               animation: _animationController,
//               builder: (context, child) {
//                 return Transform.scale(
//                   scale: _animationController.value,
//                   child: FilledButton(
//                     style: FilledButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 14,
//                           horizontal: 70,
//                         ).w,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12.r),
//                         )),
//                     onPressed: () async {
//                       getIt<AppRouter>().maybePop();
//                       MyAds.instance.appLifecycleReactor
//                           ?.setIsExcludeScreen(true);
//                       final status = await PermissionUtil.instance
//                           .requestStoragePermission();
//                       if (status && context.mounted) {
//                         context.read<AllFileCubit>().reloadFile(TabBarType.all);
//                       }
//                     },
//                     child: Text(
//                       context.l10n.allowPermission,
//                       style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 16.sp,
//                       ),
//                     ),
//                   ),
//                 );
//               }),
//           100.verticalSpace,
//         ],
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
// }
