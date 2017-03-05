import CoreData

extension Book {
    class func fetchRequestOrderedByName() -> NSFetchRequest<BookCoreData> {
        let fetchRequest: NSFetchRequest<BookCoreData> = BookCoreData.fetchRequest()
        fetchRequest.fetchBatchSize = 100
        
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: false)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        return fetchRequest
    }
    
    class func fetchRequestOrderedByNameFrom(tag: TagCoreData) -> NSFetchRequest<BookCoreData> {
        let fetchRequest: NSFetchRequest<BookCoreData> = BookCoreData.fetchRequest()
        fetchRequest.fetchBatchSize = 100
        
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchRequest.predicate = NSPredicate(format: "tagBook == %@", tag)
        
        return fetchRequest
    }
    
    class func fetchRequestOrderedByName(predicate: String) -> NSFetchRequest<BookCoreData> {
        let fetchRequest: NSFetchRequest<BookCoreData> = BookCoreData.fetchRequest()
        fetchRequest.fetchBatchSize = 100
        
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchRequest.predicate = NSPredicate(format: "%@", predicate)
        
        return fetchRequest
    }
    
}
