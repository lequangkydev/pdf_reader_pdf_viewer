import UIKit
import Flutter
import FirebaseCore
import google_mobile_ads
import FBAudienceNetwork
import UnityAds
import IronSource
import FBSDKCoreKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // meta ads
        FBAdSettings.setAdvertiserTrackingEnabled(true)
        FBSDKCoreKit.ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        // unity ads
        let gdprMetaData = UADSMetaData()
        gdprMetaData.set("gdpr.consent", value: true)
        gdprMetaData.commit()
        let ccpaMetaData = UADSMetaData()
        ccpaMetaData.set("privacy.consent", value: true)
        ccpaMetaData.commit()
        // ironSource
        IronSource.setConsent(true)
        IronSource.setMetaDataWithKey("do_not_sell", value: "YES")

        registerPlugins()
        registerAdFactory()
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func registerAdFactory() {
        FLTGoogleMobileAdsPlugin.registerNativeAdFactory(
            self, factoryId: "bottomExtraNativeAd", nativeAdFactory: ExtractNativeAdFactory())
        FLTGoogleMobileAdsPlugin.registerNativeAdFactory(
            self, factoryId: "topExtraNativeAd", nativeAdFactory: ExtractNativeAdFactory(buttonPosition: ButtonPosition.top))
        FLTGoogleMobileAdsPlugin.registerNativeAdFactory(
            self, factoryId: "bottomNormalNativeAd", nativeAdFactory: NormalNativeAdFactory())
        FLTGoogleMobileAdsPlugin.registerNativeAdFactory(
            self, factoryId: "topNormalNativeAd", nativeAdFactory: NormalNativeAdFactory(buttonPosition: ButtonPosition.top))
        FLTGoogleMobileAdsPlugin.registerNativeAdFactory(
            self, factoryId: "homeNativeAd", nativeAdFactory: HomeNativeAdFactory())
        FLTGoogleMobileAdsPlugin.registerNativeAdFactory(
            self, factoryId: "smallNativeAd", nativeAdFactory: SmallNativeAdFactory())
        
    }
}
// MARK: - Plugin Registration
extension AppDelegate {
    private func registerPlugins() {
        guard let controller = window?.rootViewController as? FlutterViewController,
        let registrar = controller.registrar(forPlugin: "FileReaderPlugin") else {
            return
        }
        SwiftFlutterFileReaderPlugin.register(with: registrar)
        // Register generated plugins
        GeneratedPluginRegistrant.register(with: self)
    }
}
