//
//  ViewController.swift
//  Project2
//
//  Created by Timo Wang on 4/22/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var scoreText: UITextField!
    
    var countries: Array<String> = Array<String>()
    var score: Int = 0
    var correctAnswer: Int = 0
    var numAttempts: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.countries += [
            "estonia",
            "france",
            "germany",
            "ireland",
            "italy",
            "monaco",
            "nigeria",
            "poland",
            "russia",
            "spain",
            "uk",
            "us",
        ]
        
        self.button1.layer.borderWidth = 1
        self.button2.layer.borderWidth = 1
        self.button3.layer.borderWidth = 1
        self.button1.layer.borderColor = UIColor.lightGray.cgColor
        self.button2.layer.borderColor = UIColor.lightGray.cgColor
        self.button3.layer.borderColor = UIColor.lightGray.cgColor
        
        self.scoreText.text = "Your score: \(self.score)"
        
        self.askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        self.countries.shuffle()
        self.correctAnswer = Int.random(in: 0...2)
        
        self.button1.setImage(UIImage(named: self.countries[0]), for: .normal)
        self.button2.setImage(UIImage(named: self.countries[1]), for: .normal)
        self.button3.setImage(UIImage(named: self.countries[2]), for: .normal)
        
        self.title = "Question \(self.numAttempts + 1) \(self.countries[self.correctAnswer].uppercased())"
        self.scoreText.text = "Your score: \(self.score)"
    }

    
    @IBAction func buttonTapped(_ sender: UIButton) {
        print("Button \(sender.tag) is clicked")
        self.numAttempts += 1
        var correct: Bool = false
        if sender.tag == self.correctAnswer {
//            self.title = "Correct"
            self.score += 1
            correct = true
        }
        else {
//            self.title = "Wrong"
            self.score -= 1
            correct = false
        }
        self.scoreText.text = "Your score: \(self.score)"
        let message = """
Result: \(correct ? "Correct" : "False")\n
Answer: \(self.countries[self.correctAnswer].uppercased())\n
Score: \(self.score)/\(self.numAttempts)\n
"""
        
        if self.numAttempts == 5 {
            let ac = UIAlertController(title: self.title,
                                       message: message,
                                       preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Restart", style: .default, handler: self.askQuestion))
            self.numAttempts = 0
            self.score = 0
            present(ac, animated: true)
        }
        else {
            
            let ac = UIAlertController(title: self.title,
                                       message: message,
                                       preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: self.askQuestion))
            present(ac, animated: true)
        }
    }
    

}

