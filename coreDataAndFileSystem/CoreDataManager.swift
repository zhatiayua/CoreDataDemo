//
//  CoreDataManager.swift
//  CoreDataNewTry
//
//  Created by Tianyuan Zhang on 2018/5/11.
//  Copyright © 2018年 qwe. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject{
    
    static let coreDataManager = CoreDataManager()
    lazy var context: NSManagedObjectContext = {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        return context
    }()
    
    let fileSystemManager: FileSystemManager = FileSystemManager.fileSystemManager
    
    func retrieveData(name: String)->(Person){
        let fetchRequest: NSFetchRequest = Person.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        do{
            let results: [Person] = try context.fetch(fetchRequest)
            return results[0]
        }
        catch{
            fatalError("Retrieve failed")
        }
    }
    
    func saveData(name: String, age: String){
        let person = NSEntityDescription.insertNewObject(forEntityName: "Person", into: context)as! Person
        person.name = name
        person.age = age
        
        fileSystemManager.saveImage(person: person, image: UIImage(contentsOfFile: "/Users/TianyuanZhang/Desktop/imageDemo.jpg")!, quality: 1.0, nameWithExtension: "\(person.name!).jpg")
        
        fileSystemManager.saveVideo(person: person, videoFromURLString: "/Users/TianyuanZhang/Downloads/Wildlife.mp4", nameWithExtension: "\(person.name!).mp4")
        do{
            try context.save()
            print("Data Saved!")
        }
        catch{
            fatalError()
        }
    }
    
    func getAllPerson() -> [Person] {
        let fetchRequest: NSFetchRequest = Person.fetchRequest()
        do {
            let result = try context.fetch(fetchRequest)
            return result
        } catch {
            fatalError();
        }
    }
    
    func deleteAllPerson(){
        for person in getAllPerson(){
            let photoURLString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String + "/" + person.photo!
            print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String + "/" + person.photo!)
            context.delete(person)
            fileSystemManager.deletImage(URLString: photoURLString)
        }
        do{
            try context.save()
        }
        catch {
            fatalError()
        }
    }
}
