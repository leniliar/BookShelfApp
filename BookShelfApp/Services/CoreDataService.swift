import Foundation
 
import CoreData

final class CoreDataService {
    
    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    static private var persistentContainer: NSPersistentContainer = {
        let container =  NSPersistentContainer(name: "BookShelfApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            
        }
    })
    return container
}()
    static func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do{
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

