//
//  DataStore.swift
//  SlapChat
//
//  Created by Ian Rahman on 7/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import CoreData

class DataStore {
    
    static let sharedInstance = DataStore()
    
    private init() {}
    
    var messages: [Message] = []
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "SlapChat")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            
            do {
                
                try context.save()
                
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchData() {
        
        let managedContext = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Message>(entityName: "Message")
        
        // let fetchRequest = NSFetchRequest<Message> = Message.fetchRequest()
        
        do {
            
            let unSortedMessages = try managedContext.fetch(fetchRequest)
            
            
            self.messages = unSortedMessages.sorted(by: { (message1, message2) -> Bool in
//                return message1.createdAt?.compare(message2.createdAt as Date!) == ComparisonResult.orderedAscending
                
             let dateA = message1.createdAt as! Date
             let dateB = message2.createdAt as! Date
            
            return dateA > dateB

            })

            
        } catch {
            
            print("error")
        }
            
        
    }
    
    func generateTestData() {

        print("4. we are creating crap number 1")
        let message1 = NSEntityDescription.insertNewObject(forEntityName: "Message", into: self.persistentContainer.viewContext) as! Message
        message1.content = "We are so cool"
        message1.createdAt = NSDate()
        
        print("4. we are creating crap number 2")
        let message2 = NSEntityDescription.insertNewObject(forEntityName: "Message", into: self.persistentContainer.viewContext) as! Message
        message2.content = "We are so cool too"
        message2.createdAt = NSDate()
        
        let message3 = NSEntityDescription.insertNewObject(forEntityName: "Message", into: self.persistentContainer.viewContext) as! Message
        message3.content = "We are super super coooooooool"
        message3.createdAt = NSDate()
        
        let message4 = Message(context: persistentContainer.viewContext)
        message4.content = "What!!??!?! This is soooooo coooooool!"
        message4.createdAt = NSDate()
        
        
        saveContext()
        fetchData()
        
    }
    
    
}
