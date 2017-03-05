import CoreData

extension BookTagCoreData {
    class func fetchRequestOrderedByName() -> NSFetchRequest<BookTagCoreData> {
        let fetchRequest: NSFetchRequest<BookTagCoreData> = BookTagCoreData.fetchRequest()
        fetchRequest.fetchBatchSize = 100
        let sortDescriptor = NSSortDescriptor(key: "tag.name", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        return fetchRequest
    }
    
    class func fetchRequestOrderedByName(tag: TagCoreData) -> NSFetchRequest<BookTagCoreData> {
        let fetchRequest: NSFetchRequest<BookTagCoreData> = BookTagCoreData.fetchRequest()
        fetchRequest.fetchBatchSize = 100
        let sortDescriptor = NSSortDescriptor(key: "tag.name", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let predicate = NSPredicate(format: "tag = %@", tag.objectID)
        fetchRequest.predicate = predicate
        
        return fetchRequest
    }
}
