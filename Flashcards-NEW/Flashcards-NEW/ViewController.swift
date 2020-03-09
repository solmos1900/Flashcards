//
//  ViewController.swift
//  Flashcards-NEW
//
//  Created by Sebastian Olmos on 2/29/20.
//  Copyright © 2020 Sebastian Olmos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var backLabel: UILabel!
    
    @IBOutlet weak var frontLabel: UILabel!
    
    var flashcardsController: ViewController!

    
    @IBOutlet weak var FALSE: UILabel!


    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var button1: UIButton!
    
    @IBOutlet weak var button2: UIButton!
    
    @IBOutlet weak var button3: UIButton!
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcardsController = self
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        frontLabel.isHidden = false
        backLabel.isHidden = true
        FALSE.isHidden = true
        
        frontLabel.layer.cornerRadius = 20.0
        backLabel.layer.cornerRadius = 20.0
        card.layer.cornerRadius = 20
        button1.layer.cornerRadius = 15
        button2.layer.cornerRadius = 15
        button3.layer.cornerRadius = 15

        button1.layer.borderWidth = 3
        button1.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        button2.layer.borderWidth = 3
        button2.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        button3.layer.borderWidth = 3
        button3.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)

        frontLabel.clipsToBounds = true
        backLabel.clipsToBounds = true

        
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 1

        
    }

    
    @IBAction func didTap(_ sender: Any) {
        if(frontLabel.isHidden)
              {
                  frontLabel.isHidden = false
                  backLabel.isHidden = true
              }
              else
              {
                  frontLabel.isHidden = true
                  backLabel.isHidden = false
                  
              }
    }

    func updateFlashcard(question: String, answer: String) {
        frontLabel.text = question
        backLabel.text = answer



    }
    
    @IBAction func didTapButton1(_ sender: Any) {
        FALSE.isHidden = false
        frontLabel.isHidden = true
        backLabel.isHidden = true


    }
    
    @IBAction func didTapButton2(_ sender: Any) {
        
        frontLabel.isHidden = true
        backLabel.isHidden = false
        FALSE.isHidden = true


    }
    
    @IBAction func didTapButton3(_ sender: Any) {
        FALSE.isHidden = false
        frontLabel.isHidden = true
        backLabel.isHidden = true



    }

}
    

