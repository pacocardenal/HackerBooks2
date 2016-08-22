//
//  LibraryViewController.swift
//  HackerBooksLite
//
//  Created by Fernando Rodríguez Romero on 8/17/16.
//  Copyright © 2016 KeepCoding. All rights reserved.
//

import UIKit

class LibraryViewController: UITableViewController {

    private
    let _model : Library
    
    private
    let cellId = "BookCell"
    
    var delegate : LibraryViewControllerDelegate?
    
    
    //MARK: - Init & Lifecycle
    init(model: Library, style : UITableViewStyle = .plain) {
        _model = model
        super.init(nibName: nil, bundle: nil)   // default options
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startObservingBooks()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopObservingBooks()
    }
    

    // Hack: this shouldn't be necessary
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Data Source
    override
    func numberOfSections(in tableView: UITableView) -> Int {
        return _model.tags.count
    }
    
    override
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return _model.tags[section]._name
    }
    
    override
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let tagName = _model.tags[section]._name
        
        guard let books = _model.books(forTagName: tagName) else {
            fatalError("No books for tag: \(tagName)")
        }
        
        return books.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        // Find the book
        let tag = _model.tags[indexPath.section]
        let book = _model.book(forTagName: tag._name, at: indexPath.row)!
        
        
        // Create the cell
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if case .none = cell{
            // The optional was empty: must create the cell from scratch
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }
        
        // Sync model (book) -> View (cell)
        let image = UIImage(data: book._image.data)
        cell?.imageView?.image = image
        cell?.textLabel?.text = book.title
        cell?.detailTextLabel?.text = book.formattedListOfAuthors()
        
        return cell!
        
    }
    
    //MARK: - Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Get the book
        let tag = _model.tags[indexPath.section]
        let book = _model.book(forTagName: tag._name, at: indexPath.row)!
        
        delegate?.libraryViewController(self, didSelect: book)
        
    }
    //MARK: - Notifications
    // Observes the notifications that come from Book,
    // and reloads the table
    var bookObserver : NSObjectProtocol?
    
    func startObservingBooks(){
        
        let nc = NotificationCenter.default
        bookObserver = nc.addObserver(forName: BookDidChange, object: nil, queue: nil)
        { (n: Notification) in
            self.tableView.reloadData()
        }
    }
    
    func stopObservingBooks(){
        
        let nc = NotificationCenter.default
        nc.removeObserver(self.bookObserver)
    }

}



//MARK: - Delegate protocol
protocol LibraryViewControllerDelegate {
    func libraryViewController(_ sender: LibraryViewController, didSelect selectedBook:Book)
}


