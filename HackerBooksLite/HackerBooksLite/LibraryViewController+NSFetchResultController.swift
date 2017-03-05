import CoreData

extension LibraryViewController: NSFetchedResultsControllerDelegate {
    var fetchedResultsController: NSFetchedResultsController<BookCoreData> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        _fetchedResultsController = NSFetchedResultsController(fetchRequest: Book.fetchRequestOrderedByName(), managedObjectContext: self.context!, sectionNameKeyPath: nil, cacheName: self.title?.hashValue.description)
        _fetchedResultsController?.delegate = self
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return _fetchedResultsController!
    }
    
    var fetchedResultsFilterController: NSFetchedResultsController<BookCoreData> {
        if _fetchedResultsFilterController != nil {
            return _fetchedResultsFilterController!
        }
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        _fetchedResultsFilterController = NSFetchedResultsController(fetchRequest: Book.fetchRequestOrderedByName(predicate: "title CONTAINS[cd] $text"), managedObjectContext: self.context!, sectionNameKeyPath: nil, cacheName: self.title?.hashValue.description)
        _fetchedResultsFilterController?.delegate = self
        
        do {
            try _fetchedResultsFilterController!.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return _fetchedResultsFilterController!
    }
    
    
    var fetchedResultsControllerTags: NSFetchedResultsController<TagCoreData> {
        if _fetchedResultsControllerTags != nil {
            return _fetchedResultsControllerTags!
        }
        
        _fetchedResultsControllerTags = NSFetchedResultsController(fetchRequest: TagCoreData.fetchRequestOrderedByName(), managedObjectContext: self.context!, sectionNameKeyPath: "name", cacheName: "Tags")
        _fetchedResultsControllerTags?.delegate = self
        
        do {
            try _fetchedResultsControllerTags!.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return _fetchedResultsControllerTags!
    }
    
    var fetchedResultsControllerBookTag: NSFetchedResultsController<BookTagCoreData> {
        if _fetchedResultsControllerBookTags != nil {
            return _fetchedResultsControllerBookTags!
        }
        
        _fetchedResultsControllerBookTags = NSFetchedResultsController(fetchRequest: BookTagCoreData.fetchRequestOrderedByName(), managedObjectContext: self.context!, sectionNameKeyPath: "tag", cacheName: "BookTags")
        _fetchedResultsControllerBookTags?.delegate = self
        
        do {
            try _fetchedResultsControllerBookTags!.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        print (_fetchedResultsControllerBookTags?.fetchedObjects?.count)
        return _fetchedResultsControllerBookTags!
    }
    
    // MARK: - NSFetchedResultController delegate
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            self.tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            self.tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        default:
            return
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        default:
            return
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
    }
    
    
}
