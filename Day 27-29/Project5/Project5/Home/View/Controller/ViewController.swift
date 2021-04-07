//
//  ViewController.swift
//  Project5
//
//  Created by Fadhil Hanri on 07/04/21.
//

import UIKit

class ViewController: UITableViewController {
    
    @ContentList
    private var allWords   = [String]()
    private var usedWords  = [String]()
    private var randomWord = ""
    
    private let identifier = "Word"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupTabelView()
        startGame()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        autoreleasepool { usedWords.count }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
            cell.textLabel?.text = usedWords[indexPath.row]
            cell.selectionStyle  = .none
        return cell
    }
    
    @objc
    func promptForAnswer() {
        let alert = UIAlertController(title: "Enter your answer:", message: nil, preferredStyle: .alert)
            alert.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak alert] action in
            guard let answer = alert?.textFields?.first?.text?.lowercased() else { return }
            self?.submit(answer)
        }
        
        alert.addAction(submitAction)
        present(alert, animated: true)
    }
    
    @objc
    func startGame() {
        randomWord = allWords.randomElement()?.lowercased() ?? ""
        title      = "Find anagram: \(randomWord)"
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
}

extension ViewController {
    func setupNavigation() {
        let leftItem = UIBarButtonItem(title: "New Game", style: .plain, target: self, action: #selector(startGame))
            leftItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .light)], for: .normal)
        navigationItem.leftBarButtonItem  = leftItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func setupTabelView() {
        tableView.tableFooterView = UIView()
        tableView.contentInset = UIEdgeInsets(top: 8.0, left: 0.0, bottom: 0.0, right: 8.0)
    }
    
    func submit(_ answer: String) {
        let errorMessage: String
        
        if isPossible(word: answer) {
            if isOriginal(word: answer) {
                if isReal(word: answer) {
                    let indexPath = IndexPath(row: 0, section: 0)
                    usedWords.insert(answer, at: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                } else {
                    errorMessage = "Your answer is not a real english word."
                    showErrorMessage(errorMessage)
                }
                
            } else {
                errorMessage = "Your answer is already entered."
                showErrorMessage(errorMessage)
            }
            
        } else {
            errorMessage = "Your answer is using invalid letter."
            showErrorMessage(errorMessage)
        }
    }
    
    func showErrorMessage(_ errorMessage: String) {
        let alert = UIAlertController(title: "Answer is not valid!", message: errorMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Try Again", style: .default))
        present(alert, animated: true)
    }
    
    func isPossible(word: String) -> Bool {
        guard !randomWord.isEmpty else { return false }
        var tempWord = randomWord
        
        for letter in word {
            if let index = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: index)
            } else {
                return false
            }
        }
        
        return true
    }

    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }

    func isReal(word: String) -> Bool {
        guard word.utf16.count > 2 else { return false }
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
}
