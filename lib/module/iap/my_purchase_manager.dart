import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ads/ads_flutter.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_iap/flutter_iap.dart';
import 'package:injectable/injectable.dart';

import '../../flavors.dart';
import '../../src/config/di/di.dart';
import '../../src/config/navigation/app_router.dart';
import '../../src/data/local/shared_preferences_manager.dart';
import '../../src/global/global.dart';
import '../../src/shared/extension/context_extension.dart';
import '../adjust/adjust_util.dart';
import 'firebase_event_service.dart';
import 'product_id.dart';

@singleton
class MyPurchasesManager extends PurchasesManager {
  bool isLoading = false;

  @override
  Set<String> productIds = <String>{
    productKeyWeekly,
    productKeyMonthly,
    productKeyLifeTime,
  };

  @override
  Future<void> loadPurchases() async {
    if (F.appFlavor == Flavor.dev) {
      emit(state.copyWith(
        products: productIds
            .map((e) => PurchasableProduct(ProductDetails(
                  currencyCode: '',
                  description: '',
                  id: e,
                  price: r'1.00$',
                  rawPrice: 1,
                  title: 'hehe',
                )))
            .toList(),
        storeState: StoreState.available,
      ));
      return;
    }
    return super.loadPurchases();
  }

  @override
  Future<void> buy(PurchasableProduct product) async {
    if (F.appFlavor == Flavor.dev) {
      updateStatus(product.id, ProductStatus.purchased);
      MyAds.instance.appLifecycleReactor?.setShouldShow(false);
      return;
    }
    final PurchaseParam purchaseParam =
        PurchaseParam(productDetails: product.productDetails);
    switch (product.id) {
      case productKeyWeekly:
      case productKeyMonthly:
      case productKeyLifeTime:
        await iapConnection.buyNonConsumable(purchaseParam: purchaseParam);
        return;
      default:
        throw ArgumentError.value(
            product.productDetails, '${product.id} is not a known product');
    }
  }

  @override
  Future<void> checkLocalPurchase() async {
    if (SharedPreferencesManager.instance
        .getPremiumStatus(PremiumType.isPremium)) {
      updateStatus(productKeyLifeTime, ProductStatus.purchased);
    } else if (SharedPreferencesManager.instance
        .getPremiumStatus(PremiumType.isMonthlyPremium)) {
      await restorePurchases();
    } else if (SharedPreferencesManager.instance
        .getPremiumStatus(PremiumType.isWeeklyPremium)) {
      await restorePurchases();
    }
  }

  @override
  Future<void> restorePurchases() async {
    showLoading();
    // reset subscription
    SharedPreferencesManager.instance
        .setPremiumStatus(PremiumType.isPremium, false);
    SharedPreferencesManager.instance
        .setPremiumStatus(PremiumType.isMonthlyPremium, false);
    SharedPreferencesManager.instance
        .setPremiumStatus(PremiumType.isWeeklyPremium, false);
    await iapConnection.restorePurchases();
    hideLoading();
  }

  @override
  Future<void> handlePurchaseCanceled(PurchaseDetails purchaseDetails) async {
    hideLoading();
    switch (purchaseDetails.productID) {
      // cancel
      case productKeyLifeTime:
        updateStatus(productKeyLifeTime, ProductStatus.purchasable);
        SharedPreferencesManager.instance
            .setPremiumStatus(PremiumType.isPremium, false);
        break;

      case productKeyWeekly:
        updateStatus(productKeyWeekly, ProductStatus.purchasable);
        SharedPreferencesManager.instance
            .setPremiumStatus(PremiumType.isWeeklyPremium, false);
        break;

      case productKeyMonthly:
        updateStatus(productKeyMonthly, ProductStatus.purchasable);
        SharedPreferencesManager.instance
            .setPremiumStatus(PremiumType.isMonthlyPremium, false);
        break;
    }
  }

  @override
  Future<void> handlePurchaseError(PurchaseDetails purchaseDetails) async {
    hideLoading();
    await showDialog(
      context: getIt<AppRouter>().navigatorKey.currentContext!,
      builder: (BuildContext ctx) {
        String errorMessage = ctx.l10n.unexpectedError;
        if (purchaseDetails.error?.message ==
            'BillingResponse.itemAlreadyOwned') {
          errorMessage = ctx.l10n.alreadyOwnError;
        }
        return AlertDialog(
          content: Text(
            errorMessage,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                getIt<AppRouter>().maybePop();
              },
              child: Text(
                ctx.l10n.confirm,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (purchaseDetails.error?.message != 'BillingResponse.itemAlreadyOwned') {
      getIt<AppRouter>().maybePop();
    }
  }

  @override
  Future<void> handlePurchasePending(PurchaseDetails purchaseDetails) async {
    hideLoading();
    showLoading();
  }

  void showLoading() {
    if (Global.instance.initEasyLoading) {
      EasyLoading.show();
    }
  }

  void hideLoading() {
    if (Global.instance.initEasyLoading) {
      EasyLoading.dismiss();
    }
  }

  @override
  Future<void> handlePurchaseRestored(PurchaseDetails purchaseDetails) async {
    hideLoading();
    final purchaseDate = purchaseDetails.transactionDate != null
        ? DateTime.fromMillisecondsSinceEpoch(
            int.parse(purchaseDetails.transactionDate!))
        : null;
    switch (purchaseDetails.productID) {
      // apply
      case productKeyLifeTime:
        updateStatus(productKeyLifeTime, ProductStatus.purchased);
        hideAdOpenInstantly();
        SharedPreferencesManager.instance
            .setPremiumStatus(PremiumType.isPremium, true);

        break;
      case productKeyWeekly:
        if (purchaseDate == null ||
            DateTime.now()
                .isBefore(purchaseDate.add(const Duration(days: 7)))) {
          updateStatus(productKeyWeekly, ProductStatus.purchased);
          hideAdOpenInstantly();
          SharedPreferencesManager.instance
              .setPremiumStatus(PremiumType.isWeeklyPremium, true);
        }
        break;
      case productKeyMonthly:
        if (purchaseDate == null ||
            DateTime.now()
                .isBefore(purchaseDate.add(const Duration(days: 31)))) {
          updateStatus(productKeyMonthly, ProductStatus.purchased);
          hideAdOpenInstantly();
          SharedPreferencesManager.instance
              .setPremiumStatus(PremiumType.isMonthlyPremium, true);
        }
        break;
    }
  }

  @override
  Future<void> handlePurchaseSuccess(PurchaseDetails purchaseDetails) async {
    final product = state.products.firstWhere(
      (e) => e.id == purchaseDetails.productID,
    );
    // Log revenue của các product theo event token của product đó
    // (được khai báo ở productRevenueTokens khi khởi tạo AdjustUtil)
    AdjustUtil.instance.trackSubscriptionRevenue(
      price: product.productDetails.rawPrice,
      currencyCode: product.productDetails.currencyCode,
      productId: product.id,
    );

    // Log revenue của các product lên cùng 1 event token
    // (được khai báo ở totalRevenueToken khi khởi tạo AdjustUtil)
    AdjustUtil.instance.trackTotalIapRevenue(
      price: product.productDetails.rawPrice,
      currencyCode: product.productDetails.currencyCode,
      productId: product.id,
    );
    hideLoading();
    getIt<FirebaseEventService>().logUserPayment(purchaseDetails.productID);
    MyAds.instance.appLifecycleReactor?.setShouldShow(false);
    switch (purchaseDetails.productID) {
      case productKeyLifeTime:
        updateStatus(productKeyLifeTime, ProductStatus.purchased);
        hideAdOpenInstantly();
        SharedPreferencesManager.instance
            .setPremiumStatus(PremiumType.isPremium, true);
        break;
      case productKeyWeekly:
        updateStatus(productKeyWeekly, ProductStatus.purchased);
        hideAdOpenInstantly();
        if (SharedPreferencesManager.instance
                .getPremiumStatus(PremiumType.isWeeklyPremium) !=
            true) {
          SharedPreferencesManager.instance
              .setPremiumStatus(PremiumType.isWeeklyPremium, true);
        }
        break;
      case productKeyMonthly:
        updateStatus(productKeyMonthly, ProductStatus.purchased);
        hideAdOpenInstantly();
        if (SharedPreferencesManager.instance
                .getPremiumStatus(PremiumType.isMonthlyPremium) !=
            true) {
          SharedPreferencesManager.instance
              .setPremiumStatus(PremiumType.isMonthlyPremium, true);
        }
        break;
    }
  }

  void hideAdOpenInstantly() {
    MyAds.instance.appLifecycleReactor?.setShouldShow(false);
  }
}

extension CheckPremium on PurchaseState {
  bool isPremium() {
    return products.any((PurchasableProduct product) =>
        product.status == ProductStatus.purchased);
  }
}
