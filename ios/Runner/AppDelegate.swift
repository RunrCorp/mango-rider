import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool { 
    // GMSServices.provideAPIKey("GOOGLE_MAPS_API_KEY")
    // **Exactly** as shown in the sample above, pass the GOOGLE_MAPS_API_KEY from .env into the function below
    let googleMapsAPIKey = "GOOGLE_MAPS_API_KEY"
    GMSServices.provideAPIKey(googleMapsAPIKey)
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
