import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    GMSServices.provideAPIKey("AIzaSyC_tn011tDjOe-oCd5p2Ey_5Tl7AK_2ASs")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
