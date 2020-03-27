//
//  CreationViewController.swift
//  Flashcards-NEW
//
//  Created by Sebastian Olmos on 3/6/20.
//  Copyright © 2020 Sebastian Olmos. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {
    
    @IBOutlet weak var questionTextField: UITextField!
    
    @IBOutlet weak var answerTextField: UITextField!
    
    @IBOutlet weak var answerTextField2: UITextField!
    
    @IBOutlet weak var answerTextField3: UITextField!
        
    
    var initialQuestion: String?
    var initialAnswer: String?
  
    var flashcardsController: ViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer
        
    }
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)

    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        let questionText = questionTextField.text
        
        let answerText = answerTextField.text
        
        let answerTextTwo = answerTextField2.text
        
        let answerTextThree = answerTextField3.text
        
        //check if text boxes are empty
        if questionText == nil || answerText == nil || questionText!.isEmpty || answerText!.isEmpty
        {
            //creation of alert
            let alert = UIAlertController(title: "Missing Text", message: "You need to enter both a question and an answer", preferredStyle: .alert)
            present(alert, animated: true)
            //to dismiss alert
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
            
        }
        else
        {
            var isExisting = false
              if initialQuestion != nil
              {
              isExisting = true
              }
              
            //updates flashcards normally
            flashcardsController.updateFlashcard(question: questionText!, answer: answerText!, isExisting: isExisting,  extraAnswerOne: answerTextTwo!, extraAnswerTwo: answerTextThree!)
            
            
                   dismiss(animated: true)
        }
        
        
        
       
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
