//
//  AnnotationViewController.swift
//  HackerBooksLite
//
//  Created by TalentoMobile on 5/3/17.
//  Copyright © 2017 KeepCoding. All rights reserved.
//

import UIKit
import CoreData

class AnnotationViewController: UIViewController {

    var bookCoreData: BookCoreData
    var _fetchedResultsController: NSFetchedResultsController<AnnotationCoreData>? = nil
    var context: NSManagedObjectContext?
    
    @IBOutlet weak var tableView: UITableView!
    init(book: BookCoreData, context: NSManagedObjectContext) {
        bookCoreData = book
        self.context = context
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "AnnotationCell")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addAnnotationClicked(_ sender: Any) {
        let vc = AnnotationDetailViewController(book: self.bookCoreData)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AnnotationViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnnotationCell")
        cell?.textLabel?.text = self.fetchedResultsController.object(at: indexPath).text
        return cell!
    }
    
}
