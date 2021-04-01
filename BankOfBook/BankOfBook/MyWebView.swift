//
//  MyWebView.swift
//  BankOfBook
//
//  Created by xdf_yanqing on 3/29/21.
//

import WebKit

class MyWebView: WKWebView {

    override init(frame: CGRect, configuration: WKWebViewConfiguration) {

        super.init(frame: frame, configuration: configuration)
        self.insetsLayoutMarginsFromSafeArea = false
        self.backgroundColor = UIColor.white
        self.scrollView.contentInsetAdjustmentBehavior = .never
        self.scrollView.showsVerticalScrollIndicator = false
//        self.scrollView.bounces = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
}
