//
//  ViewController.swift
//  Project2
//
//  Created by Fadhil Hanri on 26/03/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var flag1: UIButton!
    @IBOutlet weak var flag2: UIButton!
    @IBOutlet weak var flag3: UIButton!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var flagStackViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var flagStackViewHeightConstraint: NSLayoutConstraint!
    
    private let titleLabel: UILabel = {
        let label = UILabel()
            label.font = .systemFont(ofSize: 16, weight: .semibold)
            label.textAlignment = .center
        return label
    }()
    
//    private let totalQuestionLabel : UILabel = {
//        let label = UILabel()
//            label.font = .systemFont(ofSize: 14, weight: .light)
//            label.textAlignment = .center
//        return label
//    }()
    
    private var titleStackView: UIStackView {
        get {
            let stackView = UIStackView(arrangedSubviews: [titleLabel] )
                stackView.axis = .vertical
            return stackView
        }
        set {}
    }

    private let finalQuestion: Int = 10
    private var countries: [String] = []
    private var correctAnswer: Int = Int.random(in: 0...2)
    private var score: Int = 0
    private var question: Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        resetData()
        askQuestion(nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupView()
        askQuestion(nil)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            flagStackViewWidthConstraint.constant = 660.0
            flagStackViewHeightConstraint.constant = 100.0
        } else {
            flagStackViewWidthConstraint.constant = 200.0
            flagStackViewHeightConstraint.constant = 390.0
        }
    }
    
    private func setupData() {
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
    }
    
    private func setupView() {
        navigationItem.titleView = titleStackView
        flag1.layer.borderWidth = 2
        flag2.layer.borderWidth = 2
        flag3.layer.borderWidth = 2
        infoLabel.text = question > 1 ? "Questions answered: \(question)" : "Question answered: \(question)"
        scoreLabel.text = "\(score)"
    }
    
    private func setupTitle() {
        infoLabel.text = "Question answered: \(question)"
        scoreLabel.text = "\(score)"
        titleLabel.text = countries[correctAnswer].uppercased()
//        totalQuestionLabel.text = "Question(s) Answered: \(question) | Score: \(score)"
    }
    
    private func askQuestion(_ action: UIAlertAction! = nil) {
        guard question < finalQuestion else {
            let vc = FinalScoreViewController()
                vc.finalScore = "\(score)"
            navigationController?.pushViewController(vc, animated: true)
            return
        }
        
        let currentCountry = countries[correctAnswer]
        
        while currentCountry == countries[correctAnswer] {
            correctAnswer = Int.random(in: 0...2)
            countries.shuffle()
            flag1.setImage(UIImage(named: countries[0]), for: .normal)
            flag2.setImage(UIImage(named: countries[1]), for: .normal)
            flag3.setImage(UIImage(named: countries[2]), for: .normal)
        }
        
        setupTitle()
    }
    
    private func resetData() {
        question = 0
        score = 0
    }
    
    @IBAction func flagTapped(_ sender: UIButton) {
        question += 1
        score    += correctAnswer == sender.tag ? 1 : -1
        
        let title   = correctAnswer == sender.tag ? "Correct" : "Wrong"
        let message = correctAnswer == sender.tag ? "Your score is \(score)." : "The correct answer is \(countries[correctAnswer]), your score is \(score)."
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
    }
}

