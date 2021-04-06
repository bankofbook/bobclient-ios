 

import UIKit
import SafariServices
import SwiftHEXColors
class SFViewController: SFSafariViewController {
    
    override init(url URL: URL, configuration: SFSafariViewController.Configuration) {
        super.init(url: URL, configuration: configuration)
        self.preferredBarTintColor = UIColor(hexString: "#70BAE0")
        self.preferredControlTintColor = UIColor.white
        
        self.dismissButtonStyle = .close
        self.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SFViewController : SFSafariViewControllerDelegate {
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        debugPrint(#function)
        UIApplication.shared.perform(NSSelectorFromString("suspend"))
    }
    
    func safariViewController(_ controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool) {
        debugPrint(#function)
    }
    
//    func safariViewController(_ controller: SFSafariViewController, activityItemsFor URL: URL, title: String?) -> [UIActivity] {
//
//        return [YJUIActivity()]
//    }
//
//    func safariViewController(_ controller: SFSafariViewController, excludedActivityTypesFor URL: URL, title: String?) -> [UIActivity.ActivityType] {
//
//        return []
//    }
}

private class YJUIActivity: UIActivity {
    
    override var activityTitle: String? {
        return "书行"
    }
    
    override var activityType: UIActivity.ActivityType? {
        return UIActivity.ActivityType("custom")
    }
    
    override var activityImage: UIImage? {
        return UIImage(named: "AppIcon")
    }
    
    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        if activityItems.count > 0 {
            return true
        }
        return false
    }
    
    override class var activityCategory: UIActivity.Category {
        return .action
    }
    
    override func perform() {
        
    }

}
