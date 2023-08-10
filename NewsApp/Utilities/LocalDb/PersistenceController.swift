//
//  PersistenceController.swift
//  NewsApp
//
//  Created by Kavindu Dissanayake on 2023-08-11.
//

import Foundation
import CoreData

let PC = PersistenceController.self

class PersistenceController {
    
    static let shared = PersistenceController()
    private init() {}
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentCloudKitContainer(name: "NewsApp")
        container.loadPersistentStores(completionHandler: { _, error in
            _ = error.map { fatalError("Unresolved error \($0)") }
        })
        return container
    }()
    
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func backgroundContext() -> NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
    
    var loggedIn: Bool? {
        return UserDefaults.standard.bool(forKey: "loggedIn")
    }
    
    func logoutUser() {
        UserDefaults.standard.set(false, forKey: "loggedIn")
        UserDefaults.standard.removeObject(forKey: "loggedIn")
    }
    
    func saveUserLogin(){
        UserDefaults.standard.set(true, forKey: "loggedIn")
    }
}


extension PersistenceController {
    
    func registerUser(name: String,email: String, password: String, completionHandler: @escaping CompletionHandler) {
        let context = mainContext
        
        // Check if user with the provided email already exists
        let fetchRequest: NSFetchRequest<Users> = Users.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email = %@", email)
        
        context.perform {
            if let existingUsers = try? context.fetch(fetchRequest), existingUsers.count > 0 {
                completionHandler(false, "Email already exists.")
                return
            }
            
            let newUser = Users(context: context)
            newUser.name = name
            newUser.email = email
            newUser.password = password // Note: This should be hashed in a real app
            
            do {
                try context.save()
                completionHandler(true, "Registered successfully!")
               
            } catch {
                completionHandler(false, "Failed to save user: \(error.localizedDescription)")
            }
        }
    }
    
    func loginUser(email: String, password: String, completionHandler: @escaping CompletionHandler) {
        let context = mainContext
        
        let fetchRequest: NSFetchRequest<Users> = Users.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email = %@ AND password = %@", email, password)
        
        context.perform {
            if let matchingUsers = try? context.fetch(fetchRequest), matchingUsers.count == 1 {
                completionHandler(true, "Logged in successfully!")
                
                //save user login
                self.saveUserLogin()
                
                
            } else {
                completionHandler(false, "Incorrect email or password.")
            }
        }
    }
}
