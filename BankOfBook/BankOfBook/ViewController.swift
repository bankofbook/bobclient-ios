//
//  ViewController.swift
//  BankOfBook
//
//  Created by xdf_yanqing on 3/29/21.
//

import UIKit
import WebKit
class ViewController: UIViewController {
    
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
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        guard let url = self.url else {
            return
        }
        self.myView?.load(URLRequest(url: url))
    }
    
    deinit {
        self.myView?.configuration.userContentController.removeScriptMessageHandler(forName: "jsCallNativeMethod")
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
            }
            
        } catch {
            debugPrint("转化失败")
        }
    }
    
    
}
