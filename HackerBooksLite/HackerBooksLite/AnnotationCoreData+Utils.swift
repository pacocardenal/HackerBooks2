import CoreData

extension AnnotationCoreData {
    class func fetchRequestOrderedByName() -> NSFetchRequest<AnnotationCoreData> {
        let fetchRequest: NSFetchRequest<AnnotationCoreData> = AnnotationCoreData.fetchRequest()
        fetchRequest.fetchBatchSize = 100
        let sortDescriptor = NSSortDescriptor(key: "text", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        return fetchRequest
    }
}
