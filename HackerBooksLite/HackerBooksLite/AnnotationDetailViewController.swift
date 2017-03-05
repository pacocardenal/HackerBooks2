//
//  AnnotationDetailViewController.swift
//  HackerBooksLite
//
//  Created by TalentoMobile on 5/3/17.
//  Copyright © 2017 KeepCoding. All rights reserved.
//

import UIKit

class AnnotationDetailViewController: UIViewController {

    var bookCoreData: BookCoreData
    
    @IBOutlet weak var annotationTextView: UITextView!
    init(book: BookCoreData) {
        self.bookCoreData = book
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveAnnotation(_ sender: Any) {
        let annotationCoreData = AnnotationCoreData(context: bookCoreData.managedObjectContext!)
        annotationCoreData.text = self.annotationTextView.text
        annotationCoreData.book = bookCoreData
        saveContext(context: bookCoreData.managedObjectContext!)
        self.navigationController?.popViewController(animated: true)
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
