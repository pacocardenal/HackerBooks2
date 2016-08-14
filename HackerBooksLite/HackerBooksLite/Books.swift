//
//  Books.swift
//  HackerBooksLite
//
//  Created by Fernando Rodríguez Romero on 8/11/16.
//  Copyright © 2016 KeepCoding. All rights reserved.
//

import UIKit

// Use typealias early. It provides extra information to the reader.
// If you later need to expand one of them into fullblown
// class or structure, it won't break your code!
typealias Author = String
typealias Authors = [Author]
typealias Title = String
typealias Tag = String
typealias Tags = [Tag]
typealias PDF = AsyncData
typealias Image = AsyncData

class Book{
    let _authors : Authors
    let _title   : Title
    let _tags    : Tags
    let _pdf     : PDF
    let _image   : Image

    init(title: Title, authors: Authors,
         tags: Tags, pdf: PDF, image: Image) {
        
        (_title, _authors, _tags, _pdf, _image) = (title, authors, tags, pdf, image)
        
    }
    
    func formattedListOfAuthors() -> String{
        
        return _authors.sorted().joined(separator: ", ").capitalized
        
    }
    
    func formattedListOfTags() -> String{
        return _tags.sorted().joined(separator: ", ").capitalized
    }
    
    
}
