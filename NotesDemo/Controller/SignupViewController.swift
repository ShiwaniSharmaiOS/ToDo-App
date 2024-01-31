//
//  SignupViewController.swift
//  NotesDemo
//
//  Created by Shiwani sharma on 31/01/24.
//

import UIKit

class SignupViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var signupTitle: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    let context = appDelegate.persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   
    
    @IBAction func signupTapped(_ sender: UIButton) {
       // saveUser(phoneNumber: phoneTextField.text!, password: passwordTextField.text!)
    }
    

}
