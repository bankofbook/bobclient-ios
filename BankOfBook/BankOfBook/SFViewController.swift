//
//  SFViewController.swift
//  BankOfBook
//
//  Created by xdf_yanqing on 3/29/21.
//

import UIKit
import SafariServices
#if os(OSX)

#else
import SwiftHEXColors
#endif
class SFViewController: SFSafariViewController {
    
    override init(url URL: URL, configuration: SFSafariViewController.Configuration) {
        super.init(url: URL, configuration: configuration)
        #if os(iOS)
        self.preferredBarTintColor = UIColor(hexString: "#70BAE0") // UIColor.red// #70BAE0
        #endif
        self.preferredControlTintColor = UIColor.white
        self.dismissButtonStyle = .close
        self.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SFViewController : SFSafariViewControllerDelegate {
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        debugPrint(#function)
        UIApplication.shared.perform(NSSelectorFromString("suspend"))
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            exit(0)
        }
 
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
