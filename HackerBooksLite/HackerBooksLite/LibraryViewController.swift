import UIKit
import CoreData

class LibraryViewController: UITableViewController, UISearchResultsUpdating {

    private
    //let _model : Library
    
    var tagCoreData: TagCoreData!
    
    let searchController = UISearchController(searchResultsController: nil)
    var filteredData: [BookCoreData]? = nil
    var searchPredicate: NSPredicate!
    
    var delegate : LibraryViewControllerDelegate?
    var context: NSManagedObjectContext?
    var _fetchedResultsController: NSFetchedResultsController<BookCoreData>? = nil
    var _fetchedResultsFilterController: NSFetchedResultsController<BookCoreData>? = nil
    var _fetchedResultsControllerTags: NSFetchedResultsController<TagCoreData>? = nil
    var _fetchedResultsControllerBookTags: NSFetchedResultsController<BookTagCoreData>? = nil
    
    //MARK: - Init & Lifecycle
    init(style : UITableViewStyle = .plain, context: NSManagedObjectContext) {
        //_model = model
        self.context = context
        super.init(nibName: nil, bundle: nil)   // default options
        title = "HackerBooks"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        self.tableView.tableHeaderView = searchController.searchBar
        
        registerNib()
    }
    
    func updateSearchResults(for searchController: UISearchController) {

        let searchText = searchController.searchBar.text
        if searchText != nil {
            searchPredicate = NSPredicate(format: "title contains[c] %@", searchText!)
            filteredData = fetchedResultsController.fetchedObjects!.filter() {
                return self.searchPredicate.evaluate(with: $0)
                }
            self.tableView.reloadData()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNotifications()
    }
    
    deinit {
        tearDownNotifications()
    }
    

    // Hack: this shouldn't be necessary
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Cell registration
    private func registerNib(){
        
        let nib = UINib(nibName: "BookTableViewCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: BookTableViewCell.cellID)
    }
    
    //MARK: - Data Source
//    override
//    func numberOfSections(in tableView: UITableView) -> Int {
//        //return _model.tags.count
//        return self.fetchedResultsController.sections?.count ?? 0
//    }
    
//    override
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        
//        return _model.tags[section]._name
//    }
    
//    override
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        let tagName = _model.tags[section]._name
////        
////        guard let books = _model.books(forTagName: tagName) else {
////            fatalError("No books for tag: \(tagName)")
////        }
////        
////        return books.count
//        let sectionInfo = self.fetchedResultsController.sections![section]
//        return sectionInfo.numberOfObjects
//    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        
//        
//        // Find the book
//        let tag = _model.tags[indexPath.section]
//        let book = _model.book(forTagName: tag._name, at: indexPath.row)!
//        let book = 
//        
//        
//        // Create the cell
//        let cell = tableView.dequeueReusableCell(withIdentifier: BookTableViewCell.cellID, for: indexPath) as! BookTableViewCell
//        
//        
//        // Sync model (book) -> View (cell)
//        cell.startObserving(book: book)
//        
//        
//        return cell
//        
//    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return BookTableViewCell.cellHeight
    }
    
    
    //MARK: - Delegate
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        // Get the book
//        let tag = _model.tags[indexPath.section]
//        let book = _model.book(forTagName: tag._name, at: indexPath.row)!
//        
//        // Create the VC
//        let bookVC = BookViewController(model: book)
//        
//        // Load it
//        navigationController?.pushViewController(bookVC, animated: true)
//        
//        
//        
//    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // The cell was just hidden: stop observing
        let cell = tableView.cellForRow(at: indexPath) as! BookTableViewCell
        cell.stopObserving()
    }
    
    //MARK: - Notifications
    // Observes the notifications that come from Book,
    // and reloads the table
    var bookObserver : NSObjectProtocol?
    
    func setupNotifications() {
        
        let nc = NotificationCenter.default
        bookObserver = nc.addObserver(forName: BookDidChange, object: nil, queue: nil)
        { (n: Notification) in
            self.tableView.reloadData()
        }
    }
    
    func tearDownNotifications(){
        guard let observer = bookObserver else{
            return
        }
        let nc = NotificationCenter.default
        nc.removeObserver(observer)
    }

}



//MARK: - Delegate protocol
protocol LibraryViewControllerDelegate {
    func libraryViewController(_ sender: LibraryViewController, didSelect selectedBook:Book)
}


