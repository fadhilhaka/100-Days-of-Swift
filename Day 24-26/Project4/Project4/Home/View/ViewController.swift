//
//  ViewController.swift
//  Project4
//
//  Created by Fadhil Hanri on 02/04/21.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    var webView: WKWebView?
    var progressView: UIProgressView!
    var websiteList: [WebsiteDetail] = []
    
    /// Override default implementation, which is to load the layout from the storyboard.
    override func loadView() {
        webView = WKWebView()
        webView?.navigationDelegate = self
        webView?.allowsBackForwardNavigationGestures = true
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupView()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?)
    {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView?.estimatedProgress ?? 0.0)
        }
    }
    
    func setupData() {
        websiteList = Website.allCases.compactMap { WebsiteDetail(path: $0.rawValue, type: $0, title: "\($0)") }
    }
    
    func setupView() {
        setupProgressView()
        setupToolbar()
        setupNavigation()
        setupWebview()
    }
    
    func setupNavigation() {
        navigationController?.isToolbarHidden = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
    }
    
    func setupProgressView() {
        progressView = UIProgressView(progressViewStyle: .bar)
        progressView.sizeToFit()
    }
    
    func setupToolbar() {
        let progressButton = UIBarButtonItem(customView: progressView)
        let spacer  = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView?.reload))
        toolbarItems = [progressButton, spacer, refresh]
    }
    
    func setupWebview() {
        guard let url = URL(string: "https://" + Website.hundredDaysOfSwift.rawValue) else { return }
        webView?.load(URLRequest(url: url))
        webView?.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    func openPage(action: UIAlertAction) {
        guard let page = websiteList.filter({ $0.title == action.title }).first,
              let url = URL(string: "https://" + page.path)
        else { return }
        progressView.isHidden = false
        webView?.load(URLRequest(url: url))
    }

    @objc
    func openTapped() {
        let ac = UIAlertController(title: "Open page…", message: nil, preferredStyle: .actionSheet)
        
        websiteList.forEach { website in
            ac.addAction(UIAlertAction(title: website.title, style: .default, handler: openPage))
        }
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true, completion: nil)
    }
}

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
        progressView.isHidden = true
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let path = url?.absoluteString {
            for website in websiteList {
                if path.contains(website.path) {
                    decisionHandler(.allow)
                    return
                }
            }
        }
        
//        if let host = url?.host {
//            for website in websiteList {
//                if host.contains(website.path) {
//                    decisionHandler(.allow)
//                    return
//                }
//            }
//        }
        
        decisionHandler(.cancel)
    }
}
