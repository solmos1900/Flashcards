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
    var answer2: String
    var answer3: String
   
}

class ViewController: UIViewController {
    
    @IBOutlet weak var backLabel: UILabel!
    
    @IBOutlet weak var frontLabel: UILabel!
    
    //array to hold our flashcards
    var flashcards = [Flashcard]()
    var currentIndex = 0
    
    var flashcardsController: ViewController!

    
    
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
        
        if segue.identifier == "EditSegue"
        {
            creationController.initialQuestion = frontLabel.text
            creationController.initialAnswer = backLabel.text
            
        }


        
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        frontLabel.isHidden = false
        backLabel.isHidden = true
        
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
            updateFlashcard(question: " ", answer: " ", isExisting: false, extraAnswerOne: " ", extraAnswerTwo: " ")        }
        else{
            updateLabels()
            updateNextPrevButtons()
        }
        
        
    }

    @IBAction func didTapOnDelete(_ sender: Any) {
        //delete alert
        let alert = UIAlertController(title: "Delete flashcard", message: "Are you sure you would like to delete it?", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
            self.deleteCurrentFlashcard()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    func deleteCurrentFlashcard() {
        
            flashcards.remove(at: currentIndex)
                   
            //special case for if in the last index so the app does not crash
            if currentIndex > flashcards.count - 1
            {
                currentIndex = flashcards.count - 1
            }
        
       
        
        updateNextPrevButtons()
        
        updateLabels()
        
        saveAllFlashCardsToDisk()
    }
    
    @IBAction func didTap(_ sender: Any) {
        flipFlashcard()
        
    }
    func flipFlashcard(){
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
        //animates flashcard flip
        UIView.transition(with: card, duration: 0.5, options: .transitionFlipFromRight, animations: {
            self.frontLabel.isHidden = true
        })
        
    }
    func animateCardOutReverse() {
    UIView.animate(withDuration: 0.3, animations: {
        self.card.transform = CGAffineTransform.identity.translatedBy(x: 300, y: 0.0)
    }, completion: { finished in
        
        //update labels
          self.updateLabels()
         
        //run other animation
        self.animateCardInReverse()
        
    })
    }
        
    
    func animateCardInReverse() {
        //start on right side (not animated)
        card.transform = CGAffineTransform.identity.translatedBy(x: -300, y: 0)
               
        //animate card going back to original position
        UIView.animate(withDuration: 0.3) {
            self.card.transform = CGAffineTransform.identity
        }
    }
    
    func animateCardOut() {
        UIView.animate(withDuration: 0.3, animations: {
            self.card.transform = CGAffineTransform.identity.translatedBy(x: -300, y: 0.0)
        }, completion: { finished in
            
            //update labels
              self.updateLabels()
             
            //run other animation
            self.animateCardIn()
            
        })
    }
    
    func animateCardIn() {
        //start on right side (not animated)
        card.transform = CGAffineTransform.identity.translatedBy(x: 300, y: 0)
        
        //animate card going back to original position
        UIView.animate(withDuration: 0.3) {
            self.card.transform = CGAffineTransform.identity
        }
    }
    
   

    func updateFlashcard(question: String, answer: String, isExisting: Bool, extraAnswerOne: String, extraAnswerTwo: String) {
       
        
        let flashcard = Flashcard(question: question, answer: answer, answer2: extraAnswerOne, answer3: extraAnswerTwo)
            frontLabel.text = flashcard.question
            backLabel.text = flashcard.answer
        
        if isExisting {
                   //replace existing flashcard
                   flashcards[currentIndex] = flashcard
                   
        }else{
            flashcards.append(flashcard)
        }
        //adding flashcard in the flashcards array
        flashcards.append(flashcard)
            print("ADDED NEW FLASHCARD")
        currentIndex = flashcards.count - 1
            print("our current index is \(currentIndex)")
        
        
        
        //update answer fields
        
        //set title for extra buttons
        button1.setTitle(answer, for: .normal)
        button2.setTitle(extraAnswerOne, for: .normal)
        button3.setTitle(extraAnswerTwo, for: .normal)

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
        
        let dictionaryArray = flashcards.map {
            (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer, "extra":card.answer2, "extra #2":card.answer3]
        }
        
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        print("FLASHCARDS SAVED TO USERDEFAULTS")
        
    }
    
    func readSavedFlashcards(){
        
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String:String]]{
            let savedCards = dictionaryArray.map
            {
                dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!, answer2: dictionary["extra"]!, answer3: dictionary["extra #2"]!)
            }
            flashcards.append(contentsOf:savedCards)
        }
      
        }
    
    
    @IBAction func didTapButton1(_ sender: Any) {
        
        frontLabel.isHidden = true
        backLabel.isHidden = false
            


    }
    
    @IBAction func didTapButton2(_ sender: Any) {
        
     frontLabel.isHidden = false
     backLabel.isHidden = true
     button2.isHidden = true

    }
    
    @IBAction func didTapButton3(_ sender: Any) {
        frontLabel.isHidden = false
        backLabel.isHidden = true
        button3.isHidden = true
       


    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        
        //increase current index
        currentIndex = currentIndex  + 1
        
 
        //update buttons
        updateNextPrevButtons()
        
        animateCardOut()
                
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        //increase current index
        currentIndex = currentIndex  - 1
        
        
        //update buttons
        updateNextPrevButtons()
        
        animateCardOutReverse()
        
        
    }
    
    
    
}
    

