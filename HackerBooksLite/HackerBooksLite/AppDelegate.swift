import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {
    
    var window: UIWindow?
    var model : Library?
    var context: NSManagedObjectContext?
    
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Clean up all local caches
        AsyncData.removeAllLocalFiles()
        
        // Create the window
        window = UIWindow.init(frame: UIScreen.main.bounds)
        
        // Inject the context
        let container = persistentContainer(dbName: "LibraryCoreDataModel") { (error: NSError) in
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
        
        self.context = container.viewContext
        injectContextToFirstViewController()
        
        // Create the model
        do{
            guard let context = context else { return false }
            guard let url = Bundle.main.url(forResource: "books_readable", withExtension: "json") else{
                fatalError("Unable to read json file!")
            }
            
            let data = try Data(contentsOf: url)
            let jsonDicts = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? JSONArray
            
            let books = try decode(books: jsonDicts)
            saveCoreDataModel(books: books, context: context)
            model = Library(books: books, context: context)
            
        }catch {
            fatalError("Error while loading model")
        }
        
        
        // Create the rootVC
        //let rootVC = LibraryViewController(model: model!, style: .plain, context: self.context!)
        let rootVC = LibraryViewController(style: .plain, context: self.context!)
        window?.rootViewController = rootVC.wrappedInNavigationController()
        
        // Display
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func saveCoreDataModel(books: [Book], context: NSManagedObjectContext?) {
        
        guard let context = context else { return }
        
        context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        
        for book in books {
//            let bookCoreData = BookCoreData(context: context)
//            bookCoreData.title = book.title
            
            let bookCoreData = uniqueObjectWithValue(entity: "BookCoreData", value: book.title, key: "title", context: context) as! BookCoreData
            bookCoreData.title = book.title
            
            let pdfCoreData = PdfCoreData(context: context)
            pdfCoreData.url = book._pdf.url.absoluteString
            pdfCoreData.data = book._pdf.data as NSData?
            pdfCoreData.book = bookCoreData
            
            let bookCoverPhoto = BookCoverPhotoCoreData(context: context)
            bookCoverPhoto.remoteUrlString = book._image.url.absoluteString
            bookCoverPhoto.data = book._image.data as NSData?
            bookCoverPhoto.book = bookCoreData
            
            for tag in book.tags {
                //let tagCoreData = TagCoreData(context: context)
                let tagCoreData = uniqueObjectWithValue(entity: "TagCoreData", value: tag._name, key: "name", context: context) as! TagCoreData
                tagCoreData.name = tag._name
                //let bookTag = BookTagCoreData(context: context)
                let bookTag = uniqueObjectWithValues(entity: "BookTagCoreData", value1: bookCoreData, key1: "book", value2: tagCoreData, key2: "tag", context: context) as! BookTagCoreData
                bookTag.book = bookCoreData
                bookTag.tag = tagCoreData
                bookTag.name = tag._name
                
                //tagCoreData.addto
            }
            
            for author in book._authors {
                //let authorCoreData = AuthorCoreData(context: context)
                let authorCoreData = uniqueObjectWithValue(entity: "AuthorCoreData", value: author, key: "fullName", context: context) as! AuthorCoreData
                authorCoreData.fullName = author
                authorCoreData.addToBooks(bookCoreData)
            }
            
        }
        
        saveContext(context: context)
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func injectContextToFirstViewController() {
        if let navController = window?.rootViewController as? UINavigationController,
            let initialViewController = navController.topViewController as? LibraryViewController
        {
            initialViewController.context = self.context
        }
    }
    
    func uniqueObjectWithValue(entity: String, value: Any, key: String, context: NSManagedObjectContext) -> Any {
        
        let req = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        req.predicate = NSPredicate(format: key + " = %@", value as! CVarArg)
        req.fetchLimit = 1;
        
        do {
            let objs = try context.fetch(req)
            
            if let obj = objs.last {
                let obj2 = obj
                return obj2
            } else {
                let otro = NSEntityDescription.insertNewObject(forEntityName: entity, into: context)
                otro.setValue(value, forKey: key)
                return otro
            }
        } catch {
            fatalError(error as! String)
        }
        
    }
    
    func uniqueObjectWithValues(entity: String, value1: Any, key1: String, value2: Any, key2: String, context: NSManagedObjectContext) -> Any {
        
        let req = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        req.predicate = NSPredicate(format: "(" + key1 + " = %@) AND (" + key2 + " = %@)", value1 as! CVarArg, value2 as! CVarArg)
        req.fetchLimit = 1;
        
        do {
            let objs = try context.fetch(req)
            
            if let obj = objs.last {
                let obj2 = obj
                return obj2
            } else {
                let otro = NSEntityDescription.insertNewObject(forEntityName: entity, into: context)
                otro.setValue(value1, forKey: key1)
                otro.setValue(value2, forKey: key2)
                return otro
            }
        } catch {
            fatalError(error as! String)
        }
        
    }
    
}

