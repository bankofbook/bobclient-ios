//
//  MyWebView.swift
//  BankOfBook
//
//  Created by xdf_yanqing on 3/29/21.
//

import WebKit

class MyWebView: WKWebView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect, configuration: WKWebViewConfiguration) {
//        let config = configuration
//        let userContentController = WKUserContentController()
//        let userScript = WKUserScript(source: "<meta name=\"viewport\" content=\"viewport-fit=cover\"/>", injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: true)
//        userContentController.addUserScript(userScript)
//        config.userContentController = userContentController

        super.init(frame: frame, configuration: configuration)
        self.insetsLayoutMarginsFromSafeArea = false
        self.backgroundColor = UIColor.red
        self.scrollView.contentInsetAdjustmentBehavior = .never
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
}
