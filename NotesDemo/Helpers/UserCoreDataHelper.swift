//
//  UserCoreDataHelper.swift
//  NotesDemo
//
//  Created by Shiwani sharma on 31/01/24.
//

import Foundation
import CoreData

struct UserModel{
    var phoneNumber: Int
    var password: String
}

class UserCoreDataHelper {
    
    func saveUser(data: UserModel, intoManagedObjectContext: NSManagedObjectContext) {
        let userEntity = NSEntityDescription.entity(
            forEntityName: "User", in: intoManagedObjectContext)!
        
        let newUser = NSManagedObject(entity: userEntity, insertInto: intoManagedObjectContext)
        
        newUser.setValue(data.phoneNumber, forKey: "number")
        newUser.setValue(data.password, forKey: "password")
        
        do {
            try intoManagedObjectContext.save()
        } catch let error as NSError {
            // TODO error handling
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    
    func fetchUsers(fromManagedObjectContext: NSManagedObjectContext) -> [UserModel] {
        var returnedNotes = [UserModel]()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = nil
        
        do {
            let fetchedNotesFromCoreData = try fromManagedObjectContext.fetch(fetchRequest)
            fetchedNotesFromCoreData.forEach { (fetchRequestResult) in
                let noteManagedObjectRead = fetchRequestResult as! NSManagedObject
                returnedNotes.append(UserModel.init(phoneNumber: Int(noteManagedObjectRead.value(forKey: "number") as! Int64), password: noteManagedObjectRead.value(forKey: "password") as! String))
            }
        } catch let error as NSError {
            // TODO error handling
            print("Could not read. \(error), \(error.userInfo)")
        }
        return returnedNotes
    }
}
