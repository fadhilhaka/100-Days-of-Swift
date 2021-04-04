//
//  HomeRouter.swift
//  Project4
//
//  Created by Fadhil Hanri on 04/04/21.
//

import UIKit
import ContactsUI
import MessageUI

protocol HomeRoutingLogic: AnyObject {
    var parentController: ViewController? { get set }
    var navController: UINavigationController? { get }
    
    func openContactList()
    func openWebsiteList(_ websiteList: [WebsiteDetail])
    func sendLink(of currentWebsite: WebsiteDetail?, to recipients: [String])
    func shareWebsite(_ currentWebsite: WebsiteDetail?, from sender: UIBarButtonItem)
}

class HomeRouter: HomeRoutingLogic {
    
    var parentController: ViewController?
    var navController: UINavigationController? { parentController?.navigationController }
    
    func openContactList() {
        let contactVC = CNContactPickerViewController()
            contactVC.delegate = parentController
            contactVC.displayedPropertyKeys = [CNContactGivenNameKey, CNContactPhoneNumbersKey]
            contactVC.predicateForEnablingContact = NSPredicate(format: "phoneNumbers.@count > 0")
        navController?.present(contactVC, animated: true, completion: nil)
    }
    
    func openWebsiteList(_ websiteList: [WebsiteDetail]) {
        let alert = UIAlertController(title: "Open page…", message: nil, preferredStyle: .actionSheet)
        
        websiteList.forEach { website in
            alert.addAction(UIAlertAction(title: website.title, style: .default, handler: { action in
                guard let page = websiteList.filter({ $0.title == action.title }).first,
                      let url = URL(string: "https://" + page.path)
                else { return }
                self.parentController?.progressView.isHidden = false
                self.parentController?.webView?.load(URLRequest(url: url))
            }))
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.popoverPresentationController?.barButtonItem = navController?.navigationItem.rightBarButtonItem
        
        navController?.present(alert, animated: true, completion: nil)
    }
    
    func sendLink(of currentWebsite: WebsiteDetail?, to recipients: [String]) {
        /// Checking whether we can send the message. Testing only work in real device
        if (MFMessageComposeViewController.canSendText()) {
            let vc = MFMessageComposeViewController()
                vc.body = "Hi! Checkout this\((currentWebsite?.title ?? "")) website, on this link:\n\("https://" + (currentWebsite?.path ?? ""))"
                vc.recipients = recipients
                vc.messageComposeDelegate = parentController
            navController?.present(vc, animated: true, completion: nil)
        } else{
            /// We cannot send the message from simulator.
            print("Cannot send the message")
        }
    }
    
    func shareWebsite(_ currentWebsite: WebsiteDetail?, from sender: UIBarButtonItem) {
        guard let link: URL = URL(string: "https://" + (currentWebsite?.path ?? "")) else { return }
        let items: [Any] = [currentWebsite?.title ?? "Website Link", link]
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: [])
            activityVC.popoverPresentationController?.barButtonItem = sender
        navController?.present(activityVC, animated: true)
    }
}
