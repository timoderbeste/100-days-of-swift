//
//  ViewController.swift
//  Project4
//
//  Created by Timo Wang on 4/26/21.
//

import UIKit
import WebKit


class BrowsingViewController:
    UIViewController,
    WKNavigationDelegate {
    var webView: WKWebView!
    var progressView: UIProgressView!
    var websites = allowedWebsites
    var initialWebsite: String!
    
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
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        self.progressView = UIProgressView(progressViewStyle: .default)
        self.progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(webView.goBack))
        let forwardButton = UIBarButtonItem(title: "Forward", style: .plain, target: self, action: #selector(webView.goForward))
        
        self.toolbarItems = [backButton,forwardButton, spacer, progressButton, spacer, refresh]
        self.navigationController?.isToolbarHidden = false
        self.webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        print("self.initialWebsite: \(self.initialWebsite!)")
        let url = URL(string: "https://" + self.initialWebsite)!
        self.webView.load(URLRequest(url: url))
        self.webView.allowsBackForwardNavigationGestures = true
    }
    
    
    @objc func openTapped() {
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        for website in self.websites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: self.openPage))
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
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
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            self.progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url?.host {
            for website in self.websites {
                if host.contains(website) {
                    decisionHandler(.allow)
                    return
                }
            }
            let ac = UIAlertController(title: "This website is not authorized", message: host, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Cancel", style: .default, handler: .none))
            present(ac, animated: true)
            decisionHandler(.cancel)
            return
        }
        decisionHandler(.cancel)
        return
    }
}

