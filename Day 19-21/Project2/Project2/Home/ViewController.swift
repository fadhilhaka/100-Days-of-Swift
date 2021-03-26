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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
            label.font = .systemFont(ofSize: 16, weight: .semibold)
            label.textAlignment = .center
        return label
    }()
    
    private let totalQuestionLabel : UILabel = {
        let label = UILabel()
            label.font = .systemFont(ofSize: 14, weight: .light)
            label.textAlignment = .center
        return label
    }()
    
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
    
    private func setupData() {
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
    }
    
    private func setupView() {
        let titleStackView = UIStackView(arrangedSubviews: [titleLabel, totalQuestionLabel])
            titleStackView.axis = .vertical
        navigationItem.titleView = titleStackView
        
        flag1.layer.borderWidth = 2
        flag2.layer.borderWidth = 2
        flag3.layer.borderWidth = 2
    }
    
    private func setupTitle() {
        titleLabel.text = countries[correctAnswer].uppercased()
        totalQuestionLabel.text = "Question(s) Answered: \(question) | Score: \(score)"
    }
    
    private func askQuestion(_ action: UIAlertAction! = nil) {
        guard question < finalQuestion else {
            let vc = FinalScoreViewController()
                vc.finalScore = "\(score)"
            navigationController?.pushViewController(vc, animated: true)
            return
        }
        
        countries.shuffle()
        flag1.setImage(UIImage(named: countries[0]), for: .normal)
        flag2.setImage(UIImage(named: countries[1]), for: .normal)
        flag3.setImage(UIImage(named: countries[2]), for: .normal)
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

