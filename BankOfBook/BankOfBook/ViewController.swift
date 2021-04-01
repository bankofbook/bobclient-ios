//
//  ViewController.swift
//  BankOfBook
//
//  Created by xdf_yanqing on 3/29/21.
//

import UIKit
import WebKit
class ViewController: UIViewController {
//
    override func loadView() {
        let config = WKWebViewConfiguration()
        config.userContentController = WKUserContentController()
        config.userContentController.add(self, name: "jsCallNativeMethod")
        let webView = MyWebView(frame: UIScreen.main.nativeBounds, configuration: config)
        self.view = webView
    }
    var url : URL?
    
    convenience init(_ url : URL) {
        self.init()
        self.url = url
    }
    
    var myView: WKWebView? {
        return self.view as? WKWebView
    }
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        guard let url = self.url else {
            return
        }
        let version = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
        let customUA =  "bbc.ios.v." + version + "." + modelName
//        let baseAgent = (self.myView?.value(forKeyPath: "applicationNameForUserAgent") as? String) ?? ""
        let userAgent = customUA
        self.myView?.evaluateJavaScript("navigator.userAgent") {[weak self] (result, error) in
            let oldAgent = result as? String ?? ""
            let newAgent = userAgent + "(\(oldAgent))"
            UserDefaults.standard.register(defaults: ["UserAgent":newAgent])
            UserDefaults.standard.synchronize()
            self?.myView?.customUserAgent = newAgent
            self?.myView?.load(URLRequest(url: url))

        }
    }
    
    deinit {
        self.myView?.configuration.userContentController.removeScriptMessageHandler(forName: "jsCallNativeMethod")
    }

 
    
    func share(_ title : String , urlStr : String) {
        
        let image = UIImage(named: "icon")
        var items = [Any]()
        let url = URL(string: urlStr)
        items.append(image)
        items.append(title)
        items.append(url)
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        controller.completionWithItemsHandler = {( type , completed , items , error) in
            
        }
        self.present(controller, animated: true, completion: nil)
    }
    
    fileprivate  func getAppIcon() -> String? {
        let info = Bundle.main.infoDictionary
        if let dict = info?["CFBundleIcons"] as? [String : Any]{
            if let dict = dict["CFBundlePrimaryIcon"] as? [String : Any] {
                if let icons = dict["CFBundleIconFiles"] as? [String] {
                    return icons.last
                }
            }
        }
        return nil
    }
}

extension ViewController : WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
         debugPrint(message)
        guard let body = message.body as? String else {
            return
        }
        guard  let data = body.data(using: String.Encoding.utf8) else { return }
        do {
            if let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
                debugPrint(dict)
                guard let title = dict["title"] as? String else  { return }
                guard let url = dict["url"] as? String else { return }
                share(title, urlStr: url)
            }
            
        } catch {
            debugPrint("转化失败")
        }
    }
    
    
}
