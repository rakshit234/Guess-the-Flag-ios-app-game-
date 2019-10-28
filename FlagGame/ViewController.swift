//
//  ViewController.swift
//  FlagGame
//
//  Created by rs on 28/10/19.
//  Copyright © 2019 rs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score: \(score)", style: .plain, target: self, action: nil)
        if count == 10 {
            result()
        } else {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
            
            button1.setImage(UIImage(named: countries[0]), for: .normal)
            button2.setImage(UIImage(named: countries[1]), for: .normal)
            button3.setImage(UIImage(named: countries[2]), for: .normal)
            
            title = "\(countries[correctAnswer].uppercased()) ?"
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "\(count+1)/10", style: .plain, target: self, action: nil)
        }
        
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct Answer"
            score += 1
        }
        else {
            title = "Wrong Answer"
            if score > 0 {
                score -= 1
            }
        }
        count += 1
        let ac = UIAlertController(title: title, message: "This flag is  \(countries[sender.tag].uppercased())", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
    }
    
    func result() {
        var ac: UIAlertController
        if score > 6 {
            ac = UIAlertController(title: "You Won!!", message: "Congratulations\n Final Score:\(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Restart", style: .default, handler: askQuestion))
        } else {
            ac = UIAlertController(title: "You Lost!!", message: "Better luck next time\n Final Score:\(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Restart", style: .default, handler: askQuestion))
        }
        present(ac, animated: true)
        count = 0
        score = 0
    }
    
}
