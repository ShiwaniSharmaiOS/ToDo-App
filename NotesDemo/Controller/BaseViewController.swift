//
//  BaseViewController.swift
//  NotesDemo
//
//  Created by Shiwani sharma on 01/02/24.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showAlertWithTitle(title: String, completion: @escaping () -> Void, showCancel: Bool = false) {
            let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
            completion()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alertController.addAction(okAction)
        if showCancel{
            alertController.addAction(cancelAction)
        }
            present(alertController, animated: true, completion: nil)
        }

}
