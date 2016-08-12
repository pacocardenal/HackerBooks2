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
typealias PDF = Data

class Book{
    let authors : Authors
    let title   : Title
    let tags    : Tags
    

}
