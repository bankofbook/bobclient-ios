//
//  BFBSafariViewController.swift
//  BankOfBook
//
//  Created by xdf_yanqing on 3/29/21.
//
import SafariServices
import UIKit

class BFBSafariViewController: SFSafariViewController , SFSafariViewControllerDelegate {
    
  
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        debugPrint(controller)
    }
    
    func safariViewController(_ controller: SFSafariViewController, initialLoadDidRedirectTo URL: URL) {
        debugPrint(URL)
    }
}
