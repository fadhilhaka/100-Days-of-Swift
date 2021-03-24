//
//  DetailViewController.swift
//  Project1
//
//  Created by Fadhil Hanri on 22/03/21.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var selectedImage: String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.hidesBarsOnTap = true
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let imageName = selectedImage {
            imageView.image = UIImage(named: imageName)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        navigationController?.hidesBarsOnTap = false
    }
    
}
