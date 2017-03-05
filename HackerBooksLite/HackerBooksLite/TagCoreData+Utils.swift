import CoreData

extension TagCoreData {
    class func fetchRequestOrderedByName() -> NSFetchRequest<TagCoreData> {
        let fetchRequest: NSFetchRequest<TagCoreData> = TagCoreData.fetchRequest()
        fetchRequest.fetchBatchSize = 100
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        return fetchRequest
    }
}
