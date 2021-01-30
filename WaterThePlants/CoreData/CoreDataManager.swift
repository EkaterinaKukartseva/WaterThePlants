//
//  CoreDataManager.swift
//  WaterThePlants
//
//  Created by EKATERINA  KUKARTSEVA on 27.01.2021.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static public var shared = CoreDataManager()
    
    var context: NSManagedObjectContext {
        get {
            return persistentContainer.viewContext
        }
    }
    
    // MARK: - Core Data stack
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WaterThePlants")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchPlants() -> [Plant] {
        
        var plants: [Plant] = []
        
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<Plant> = Plant.fetchRequest()
        
        do {
            plants = try context.fetch(fetchRequest)
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return plants
    }
    
    func deletePlant(this plant: Plant) {
        context.delete(plant)
        saveContext()
    }
    
}
