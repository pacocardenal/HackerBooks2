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
typealias PDF = AsyncData
typealias Image = AsyncData


class Book{
    private let _authors : Authors
    private let _title   : Title
    private var _tags    : Tags
    private let _pdf     : PDF
    private let _image   : Image

    weak var delegate    : BookDelegate?
    

    
    init(title: Title, authors: Authors,
         tags: Tags, pdf: PDF, image: Image) {
        
        (_title, _authors, _tags, _pdf, _image) = (title, authors, tags, pdf, image)
        
    }
    
    func formattedListOfAuthors() -> String{
        
        return _authors.sorted().joined(separator: ", ").capitalized
        
    }
    
    func formattedListOfTags() -> String{
        return _tags.sorted().map{$0._name}.joined(separator: ", ").capitalized
    }
    
    
}


//MARK: - Favorites
extension Book{
    
    private func hasFavoriteTag()->Bool{
        return _tags.contains(Tag.favoriteTag())
    }
    
    
    private func addFavoriteTag(){
        _tags.insert(Tag.favoriteTag())
    }
    
    private func removeFavoriteTag() {
        _tags.remove(Tag.favoriteTag())
    }
    
    
    var isFavorite : Bool{
        
        get{
            return hasFavoriteTag()
        }
        
        set{
            if newValue == true{
                addFavoriteTag()
            }else{
                removeFavoriteTag()
            }
        }
        
    }
    
}
//MARK: - Protocols
extension Book: Hashable{
    
    private var proxyForHashing : String{
        get{
            return "\(_title)\(_authors)\(_tags)"
        }
    }
    var hashValue: Int {
        return proxyForHashing.hashValue
    }
}

extension Book : Equatable{
    private var proxyForComparison : String{
        return "\(_title)\(formattedListOfAuthors())"
    }
    
    static func ==(lhs: Book, rhs: Book) -> Bool{
        return lhs.proxyForComparison == rhs.proxyForComparison
    }
}

extension Book : Comparable{
    static func <(lhs: Book, rhs: Book) -> Bool{
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}


//MARK: - Communication
protocol BookDelegate: class{
    func bookDidChange(sender:Book)
    
}

let BookDidChange = Notification.Name(rawValue: "io.keepCoding.BookDidChange")

extension Book{
    private
    func sendNotification(){
        
        let n = Notification(name: BookDidChange, object: self, userInfo: [:])
        let nc = NotificationCenter.default
        nc.post(n)
        
    }
}




