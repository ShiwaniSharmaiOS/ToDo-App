//
//  Storyboard+Extension.swift
//  NotesDemo
//
//  Created by Shiwani sharma on 01/02/24.
//

import Foundation
import UIKit

extension UIStoryboard {
    enum Storyboard:String {
        case Main
        case Login

        var filename:String{
            switch self {
            default: return rawValue
            }
        }
    }

    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.filename, bundle: bundle)
    }


    func initVC<T: UIViewController>() -> T {
        guard let vc = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
        }
        return vc
    }
}


protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}
extension UIViewController : StoryboardIdentifiable { }
