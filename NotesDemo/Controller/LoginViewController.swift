//
//  LoginViewController.swift
//  NotesDemo
//
//  Created by Shiwani sharma on 01/02/24.
//

import UIKit

class LoginViewController: BaseViewController {

    var usersList: [UserModel] = [UserModel]()
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    
    let context = appDelegate.persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserData()
    }
    
    private func fetchUserData(){
       usersList = UserCoreDataHelper().fetchUsers(fromManagedObjectContext: context)
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        
        let user = usersList.filter({$0.phoneNumber == Int(phoneTextField.text ?? "" ) && $0.password == passwordTextField.text})
        if user.count > 0{
            showAlertWithTitle(title: "User logged In sucessfully! ", completion: {
                self.addRedirection()
            })
        }
        
    }
    
    private func addRedirection(){
        let detailVC:DetailViewController = UIStoryboard(storyboard: .Main).initVC()
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
