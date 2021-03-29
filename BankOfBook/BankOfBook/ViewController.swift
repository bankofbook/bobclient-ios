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
        self.view = MyWebView(frame: UIScreen.main.nativeBounds)
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

}

