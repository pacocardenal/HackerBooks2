import UIKit

extension LibraryViewController { //: UITableViewDelegate, UITableViewDataSource {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // return self.fetchedResultsController.sections?.count ?? 0
        return self.fetchedResultsControllerTags.sections?.count ?? 0
    }
    
    override
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*• Para el segundo, obtenemos el tag que corresponda (su índice dentro del array nos lo da el
         parámetro section) y obtenemos el count del NSSet books (la propiedad que enlaza ese Tag con todos los libros que lo tienen).*/
        
//        let sectionInfo = self.fetchedResultsControllerTags.fetchedObjects?[section]
//        return (sectionInfo?.bookTag?.count)!
        
        
        
        //let sectionInfo = self.fetchedResultsControllerTags.sections![section]
        let elements = self.fetchedResultsControllerTags.fetchedObjects![section].bookTag?.count
        //return (self.fetchedResultsControllerTags.fetchedObjects![section].bookTag?.count)!
        
        let numberOfItems = self.fetchedResultsControllerBookTag.sections![section].numberOfObjects
        if numberOfItems > 1 {
            print("Items \(numberOfItems) - Section \(section)")
        }
        
        return self.fetchedResultsControllerBookTag.sections![section].numberOfObjects
        

        //return sectionInfo.numberOfObjects
    }
    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NotebookCell", for: indexPath) as! NotebookCell
//
//        cell.notebook = self.fetchedResultsController.object(at: indexPath)
//        
//        return cell
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BookTableViewCell.cellID, for: indexPath) as! BookTableViewCell
        
        cell.bookTagCoreData = self.fetchedResultsControllerBookTag.object(at: indexPath)
        print(indexPath.section, indexPath.row)
        //cell.textLabel?.text = self.fetchedResultsControllerBookTag.object(at: indexPath).book?.title

        //let book = self.fetchedResultsControllerBookTag.object(at: indexPath).book
        //cell.startObserving(book: book!)
       
        return cell
        
    }
    
    override
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return self.fetchedResultsControllerTags.fetchedObjects?[section].name
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Get the book
//        let tag = _model.tags[indexPath.section]
//        let book = _model.book(forTagName: tag._name, at: indexPath.row)!
        
        let book = self.fetchedResultsControllerBookTag.object(at: indexPath).book
        print(book?.title)
        
        let bookVC = BookCoreDataViewController(model: book!)
        
        // Create the VC
//        let bookVC = BookViewController(model: book)
//        
//        // Load it
        navigationController?.pushViewController(bookVC, animated: true)
        
        
        
    }
    
}
