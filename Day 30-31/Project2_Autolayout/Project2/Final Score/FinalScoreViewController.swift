//
//  FinalScoreViewController.swift
//  Project2
//
//  Created by Fadhil Hanri on 26/03/21.
//

import UIKit

class FinalScoreViewController: UIViewController {

    @IBOutlet weak var finalScoreLabel: UILabel!
    
    var finalScore = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        finalScoreLabel.text = finalScore
    }

}
