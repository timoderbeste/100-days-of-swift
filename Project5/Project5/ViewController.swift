//
//  ViewController.swift
//  Project5
//
//  Created by Timo Wang on 5/2/21.
//

import UIKit

class ViewController: UITableViewController {
    var allWords = [String]()
    var usedWords = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startGame))
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                self.allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if self.allWords.isEmpty {
            self.allWords = ["silkworm"]
        }
        
        self.startGame()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }

    @objc func startGame() {
        self.title = allWords.randomElement()
        self.usedWords.removeAll()
        self.tableView.reloadData()
    }
    
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField(configurationHandler: nil)
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        ac.addAction(submitAction)
        present(ac, animated: true, completion: nil)
    }
    
    func submit(_ answer: String) {
        print("Submitting answer: \(answer)")
        let lowerAnswer = answer.lowercased()
        
        let errorTitle: String
        let errorMessage: String
        
        if self.isPossible(word: lowerAnswer) {
            if self.isOriginal(word: lowerAnswer) {
                if self.isReal(word: lowerAnswer) {
                    self.usedWords.insert(answer, at: 0)
                    
                    let indexPath = IndexPath(row: 0, section: 0)
                    self.tableView.insertRows(at: [indexPath], with: .automatic)
                    
                    return
                }
                else {
                    errorTitle = "Word not recognized"
                    errorMessage = "You can't just make them up, you know"
                }
            }
            else {
                errorTitle = "Word already used"
                errorMessage = "Be more original!"
            }
        }
        else {
            errorTitle = "Word not possible"
            errorMessage = "You can't spell that word from \(self.title!.lowercased())"
        }
        
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Try again", style: .default, handler: nil))
        present(ac, animated: true, completion: nil)
    }
    
    func isPossible(word: String) -> Bool {
        guard var tmpWord = self.title?.lowercased() else {
            return false
        }
        
        for c in word {
            if let pos = tmpWord.firstIndex(of: c) {
                tmpWord.remove(at: pos)
            }
            else {
                return false
            }
        }
        return true
    }
    
    func isOriginal(word: String) -> Bool {
        return !self.usedWords.contains(word)
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
}

