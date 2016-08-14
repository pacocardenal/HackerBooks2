//
//  Tags.swift
//  HackerBooksLite
//
//  Created by Fernando Rodríguez Romero on 8/14/16.
//  Copyright © 2016 KeepCoding. All rights reserved.
//

import Foundation

typealias Tags = [Tag]


struct TagConstants{
    static let favoriteTag = "Favorite"
}

struct Tag {
    
    let _name : String
    
    init(name: String) {
        _name = name.capitalized
    }
    
    static func favoriteTag()->Tag{
        return self.init(name: TagConstants.favoriteTag)
    }
    
}
