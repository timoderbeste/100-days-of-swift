//
//  ViewController.swift
//  Project4
//
//  Created by Timo Wang on 4/26/21.
//

import UIKit
import WebKit


class ViewController:
    UIViewController,
    WKNavigationDelegate {
    var webView: WKWebView!
    
    override func loadView() {
        self.webView = WKWebView()
        self.webView.navigationDelegate = self
        self.view = self.webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationItem.rightBarButtonItem =
            UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        
        let url = URL(string: "https://www.google.com")!
        self.webView.load(URLRequest(url: url))
        self.webView.allowsBackForwardNavigationGestures = true
    }
    
    
    @objc func openTapped() {
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "apple.com", style: .default, handler: self.openPage))
        ac.addAction(UIAlertAction(title: "google.com", style: .default, handler: self.openPage))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    func openPage(action: UIAlertAction) {
        guard let actionTitle = action.title else {
            return
        }

        let url = URL(string: "https://" + actionTitle)!
        self.webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.title = webView.title
    }
}

