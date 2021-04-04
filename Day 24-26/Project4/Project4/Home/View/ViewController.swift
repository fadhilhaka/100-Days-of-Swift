//
//  ViewController.swift
//  Project4
//
//  Created by Fadhil Hanri on 02/04/21.
//

import UIKit
import WebKit
import ContactsUI
import MessageUI

class ViewController: UIViewController {
    
    var router: HomeRoutingLogic?
    var webView: WKWebView?
    var progressView: UIProgressView!
    var currentWebsite: WebsiteDetail?
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
        setupConfig()
        setupData()
        setupView()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?)
    {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView?.estimatedProgress ?? 0.0)
        }
    }
    
    func setupConfig() {
        router = HomeRouter()
        router?.parentController = self
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openWebsiteList))
    }
    
    func setupProgressView() {
        progressView = UIProgressView(progressViewStyle: .bar)
        view.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0.0).isActive = true
        progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0).isActive = true
        progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0).isActive = true
        progressView.heightAnchor.constraint(equalToConstant: 2.0).isActive = true
    }
    
    func setupToolbar() {
        let back    = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: webView, action: #selector(webView?.goBack))
        let forward = UIBarButtonItem(image: UIImage(systemName: "chevron.forward"), style: .plain, target: webView, action: #selector(webView?.goForward))
        let share   = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareWebsite(_:)))
        let send    = UIBarButtonItem(image: UIImage(systemName: "paperplane"), style: .plain, target: self, action: #selector(openContactList(_:)))
        let spacer  = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView?.reload))
        toolbarItems = [back, spacer, forward, spacer, share, spacer, send, spacer, refresh]
    }
    
    func setupWebview() {
        guard let url = URL(string: "https://" + Website.hundredDaysOfSwift.rawValue) else { return }
        webView?.load(URLRequest(url: url))
        webView?.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }

    func sendLink(to recipients: [String]) {
        router?.sendLink(of: currentWebsite, to: recipients)
    }
    
    @objc
    func openContactList(_ sender: UIBarButtonItem) {
        router?.openContactList()
    }
    
    @objc
    func openWebsiteList() {
        router?.openWebsiteList(websiteList)
    }
    
    @objc
    func shareWebsite(_ sender: UIBarButtonItem) {
        router?.shareWebsite(currentWebsite, from: sender)
    }
}

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
        progressView.progress = 1.0
        
        /// Wait until progressView is full before hiding it.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.progressView.isHidden = true
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let path = url?.absoluteString {
            for website in websiteList {
                if path.contains(website.path) {
                    currentWebsite = website
                    decisionHandler(.allow)
                    return
                }
            }
        }
        
        decisionHandler(.cancel)
    }
}

extension ViewController: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ViewController: CNContactPickerDelegate {
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
        let recipients = contacts.compactMap { $0.phoneNumbers.first?.value.stringValue }
        
        /// Wait until contactPicker is fully dismissed before sending link to recipients.
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.sendLink(to: recipients)
        }
    }
}
