//
//  SignupViewController.swift
//  NotesDemo
//
//  Created by Shiwani sharma on 31/01/24.
//

import UIKit

class SignupViewController: BaseViewController {

    //MARK: IBOutlets
    @IBOutlet weak var signupTitle: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    var userData: UserModel = UserModel()
    var usersList: [UserModel] = [UserModel]()
    
    let context = appDelegate.persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserData()
    }
    
    private func fetchUserData(){
       usersList = UserCoreDataHelper().fetchUsers(fromManagedObjectContext: context)
        print("listing", usersList)
    }
    
    @IBAction func signupTapped(_ sender: UIButton) {
        if checkForValidations(){
            setUserData()
            let user = usersList.filter({$0.phoneNumber == userData.phoneNumber})
            if user.count > 0{
                showAlertWithTitle(title: "A User already exist with thhis phone number.", completion: {})
            } else{
                UserCoreDataHelper().saveUser(data: userData, intoManagedObjectContext: context, completion: { result, msg in
                    if result{
                        showAlertWithTitle(title: "User registered sucessfully!", completion: {
                            UserDefaults.standard.set(true, forKey: "isUserLogin")
                            self.addRedirection()
                        })
                        
                    } else{
                        showAlertWithTitle(title: "\(msg)", completion: {})
                    }
                })
            }
        }
        else {
            showAlertWithTitle(title: "Please enter required detaills.", completion: {})
        }
    }
    private func addRedirection(){
        let detailVC:DetailViewController = UIStoryboard(storyboard: .Main).initVC()
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    private func setUserData(){
        userData.phoneNumber = Int(phoneTextField.text ?? "0")
        userData.password = passwordTextField.text
    }
    
    private func checkForValidations() -> Bool{
        if phoneTextField.text == nil || phoneTextField.text == ""{
            return false
        }
        if (passwordTextField.text == nil) || passwordTextField.text == ""{
            return false
        }
        return true
    }

}
