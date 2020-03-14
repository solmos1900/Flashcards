//
//  ViewController.swift
//  Flashcards-NEW
//
//  Created by Sebastian Olmos on 2/29/20.
//  Copyright © 2020 Sebastian Olmos. All rights reserved.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
    
}

class ViewController: UIViewController {
    
    @IBOutlet weak var backLabel: UILabel!
    
    @IBOutlet weak var frontLabel: UILabel!
    
    //array to hold our flashcards
    var flashcards = [Flashcard]()
    var currentIndex = 0
    
    var flashcardsController: ViewController!

    
    @IBOutlet weak var FALSE: UILabel!


    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var button1: UIButton!
    
    @IBOutlet weak var button2: UIButton!
    
    @IBOutlet weak var button3: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var prevButton: UIButton!
    
    
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
        
        readSavedFlashcards()
        
        if flashcards.count == 0{
            updateFlashcard(question: "10/2", answer: "5")

        }
        else{
            updateLabels()
            updateNextPrevButtons()
        }
        
        
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
        let flashcard = Flashcard(question: question, answer: answer)
        
        //adding flashcard in the flashcards array
        flashcards.append(flashcard)
            print("ADDED NEW FLASHCARD")
        currentIndex = flashcards.count - 1
            print("our current index is \(currentIndex)")
        
        frontLabel.text = flashcard.question
        backLabel.text = flashcard.answer
        
        
        
        //update buttons
        updateNextPrevButtons()
        //update labels
        updateLabels()
        
        //saves all flashcards to disk
        saveAllFlashCardsToDisk()
        
        
    }
    func updateLabels() {
        let currentFlashcard = flashcards[currentIndex]
        
        //update labels
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
    }
    func updateNextPrevButtons() {
        //disable next button if at the end
        if currentIndex == flashcards.count - 1
        {
            nextButton.isEnabled = false
        }
        else
        {
            nextButton.isEnabled = true
        }
        
        if currentIndex == 0 {
            prevButton.isEnabled = false
        }
        else{
            prevButton.isEnabled = true
        }
    }
    func saveAllFlashCardsToDisk() {
        
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer]
        }
        
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        print("FLASHCARDS SAVED TO USERDEFAULTS")
        
    }
    
    func readSavedFlashcards(){
        
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String:String]]{
            let savedCards = dictionaryArray.map
            {
                dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
            }
            flashcards.append(contentsOf:savedCards)
        }
      
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
    
    @IBAction func didTapOnNext(_ sender: Any) {
        
        //increase current index
        currentIndex = currentIndex  + 1
        
        //update labels
        updateLabels()
        
        //update buttons
        updateNextPrevButtons()
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        //increase current index
        currentIndex = currentIndex  - 1
        
        //update labels
        updateLabels()
        
        //update buttons
        updateNextPrevButtons()
        
        
    }
    
    
    
}
    

