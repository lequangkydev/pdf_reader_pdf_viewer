// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_ads/ads_flutter.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../gen/assets.gen.dart';
// import '../../../presentation/all_documents/cubit/all_file_cubit.dart';
// import '../../../services/default_app_checker.dart';
// import '../../constants/app_colors.dart';
// import '../../enum/app_enum.dart';
// import '../../extension/context_extension.dart';
// import '../../extension/number_extension.dart';
// import '../../helpers/permission_util.dart';
// import '../custom_switch.dart';
//
// Future<void> showPermissionExternalBottomSheet(BuildContext context) async {
//   await showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//     ),
//     builder: (context1) {
//       return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 47),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             8.vSpace,
//             Container(
//               width: 40,
//               height: 4,
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade400,
//                 borderRadius: BorderRadius.circular(2),
//               ),
//             ),
//             12.vSpace,
//
//             // Title
//             Text(
//               context.l10n.permission,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             12.vSpace,
//
//             SizedBox(
//               height: 220,
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Assets.images.permissionApp.image(
//                     fit: BoxFit.contain,
//                   ),
//                   Positioned(
//                     bottom: 30,
//                     left: 0,
//                     right: 0,
//                     child: Container(
//                       padding: const EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(15),
//                         border: Border.all(color: AppColors.pr),
//                         color: Colors.white,
//                       ),
//                       child: Row(
//                         children: [
//                           Assets.icons.folder.svg(
//                             colorFilter: const ColorFilter.mode(
//                               AppColors.pr,
//                               BlendMode.srcIn,
//                             ),
//                           ),
//                           8.hSpace,
//                           Expanded(
//                             child: Text(
//                               context.l10n.allowAccess,
//                               style: const TextStyle(
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w500,
//                                 color: Color(0xff404040),
//                               ),
//                             ),
//                           ),
//                           50.hSpace,
//                           CustomSwitch(
//                             value: true,
//                             onChanged: (value) {},
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             // Description Text
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 30),
//               child: Text(
//                 context.l10n.pleaseAllowAll('PDF Reader - PDF Viewer'),
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                   color: Color(0xff404040),
//                 ),
//               ),
//             ),
//
//             // Allow Permission Button
//             SizedBox(
//               width: double.infinity,
//               height: 48.h,
//               child: ElevatedButton(
//                 onPressed: () async {
//                   context1.maybePop();
//                   MyAds.instance.appLifecycleReactor?.setIsExcludeScreen(true);
//                   await PermissionUtil.instance.requestStoragePermission();
//                   if (context.mounted) {
//                     context.read<AllFileCubit>().reloadFile(TabBarType.all);
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.pr,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: Text(
//                   context.l10n.allowPermission,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//             60.vSpace
//           ],
//         ),
//       );
//     },
//   );
// }
