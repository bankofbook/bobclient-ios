 
import UIKit
import SafariServices
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.isHidden = false
//        let config = SFSafariViewController.Configuration();
//        let safari = SFViewController(url: URL(string: "http://bankofbook.com/")!, configuration: config)
        let safari = ViewController(URL(string: "http://bankofbook.com/")!)
        safari.view.insetsLayoutMarginsFromSafeArea = false
        self.window?.rootViewController = safari
        self.window?.makeKeyAndVisible()
        return true
    }


}

