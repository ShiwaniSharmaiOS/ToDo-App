//
//  Navigation.swift
//  NotesDemo
//
//  Created by Shiwani sharma on 01/02/24.
//

import Foundation
import UIKit

extension AppDelegate{
    func setNavigationToRoot(viewContoller: UIViewController, animated: Bool = false) {
        //Setting Login to Root Controller
        let navController = UINavigationController()
        //App Theming
        NavigTO.navigateTo?.navigation  =  navController
        navController.pushViewController(viewContoller, animated: animated)
        navController.setNavigationBarHidden(true, animated: false)
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
    }
}

class NavigTO {
    var navigation:UINavigationController?
    class var  navigateTo:NavigTO? {
        struct Static {
            static let instance :NavigTO = NavigTO()
        }
        return Static.instance
    }
}
