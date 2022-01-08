//
//  WebViewController.swift
//  yaaulyanenkovPW5
//
//  Created by Ярослав Ульяненков on 06.01.2022.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    
    var url: URL?
    var webView: WKWebView?
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView?.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        if let url = url {
        let myRequest = URLRequest(url: url)
        webView?.load(myRequest)
        }
    }
}
