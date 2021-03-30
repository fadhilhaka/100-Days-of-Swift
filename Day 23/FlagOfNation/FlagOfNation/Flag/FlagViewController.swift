//
//  FlagViewController.swift
//  FlagOfNation
//
//  Created by Fadhil Hanri on 30/03/21.
//

import UIKit

class FlagViewController: UIViewController {
    
    @IBOutlet weak var flagImageView: UIImageView!
    
    var selectedNation: String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.hidesBarsOnTap = true
        navigationItem.largeTitleDisplayMode = .never
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        if let imageName = selectedNation {
            flagImageView.image = UIImage(named: imageName)
        }
    }
    
    @objc
    func shareTapped() {
        guard let image = flagImageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        
        let items: [Any] = [title ?? "Flag", image]
        let vc = UIActivityViewController(activityItems: items, applicationActivities: [])
            vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
}
