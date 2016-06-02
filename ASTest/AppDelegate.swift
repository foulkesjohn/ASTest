import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    let frame = UIScreen.mainScreen().bounds
    self.window = UIWindow(frame: frame)
    self.window?.rootViewController = ViewController()
    self.window?.makeKeyAndVisible()
    
    return true
  }

}
