//
//  SplashViewController.swift
//  NotesDemo
//
//  Created by Shiwani sharma on 01/02/24.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        redirectUser()
    }
    

    private func redirectUser(){
        if UserDefaults.standard.bool(forKey: "isUserLogin"){
            addRedirectionForHomePage()
        } else{
            addRedirectionForLoginPage()
        }
    }
    
    private func addRedirectionForHomePage(){
        let detailVC:DetailViewController = UIStoryboard(storyboard: .Main).initVC()
        appDelegate.setNavigationToRoot(viewContoller: detailVC, animated: true)
    }
    
    private func addRedirectionForLoginPage(){
        let signupVC:MainLandingViewController = UIStoryboard(storyboard: .Login).initVC()
        appDelegate.setNavigationToRoot(viewContoller: signupVC, animated: true)
    }
}


