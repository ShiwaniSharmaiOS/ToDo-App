//
//  MainLandingViewController.swift
//  NotesDemo
//
//  Created by Shiwani sharma on 01/02/24.
//

import UIKit

class MainLandingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        let loginVC:LoginViewController = UIStoryboard(storyboard: .Login).initVC()
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @IBAction func signupTapped(_ sender: Any) {
        let signupVC:SignupViewController = UIStoryboard(storyboard: .Login).initVC()
        self.navigationController?.pushViewController(signupVC, animated: true)
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
