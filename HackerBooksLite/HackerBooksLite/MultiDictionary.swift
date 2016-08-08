//
//  MultiDictionary.swift
//  HackerBooksLite
//
//  Created by Fernando Rodríguez Romero on 7/28/16.
//  Copyright © 2016 KeepCoding. All rights reserved.
//

import Foundation

//A [Multimap](https://en.wikipedia.org/wiki/Multimap) implementation for Swift.
//A MultiDictionary is a generalization of the Dictionary data type, where more
//than one object can be associated with a single key.
//
//public is used as this class might very well end in a separate framework


public
struct MultiDictionary<Key : Hashable, Value : Hashable>{
    
    //MARK: - Types
    public
    typealias Bucket = Set<Value>
    
    
    //MARK: - Properties
    private
    var _dict : [Key : Bucket]
    
    
    //MARK: - Lifecycle
    
    // Creates an empty multiDictionary
    public
    init(){
        _dict = Dictionary()
    }
    
    
    //MARK: - Accessors
    
    public
    var isEmpty: Bool {
        
        return _dict.isEmpty
    }
    
    // Takes a key and returns an optional Bucket. If the key is not present,
    // returns .None.
    // The setter takes a Bucket and adds its contents to the existing Bucket
    // if any.
    public
    subscript(key: Key) ->Bucket?{
        get{
            return _dict[key]
        }
        
//        set(maybeNewBucket){
//            guard let newBucket = maybeNewBucket else{
//                return
//            }
//        
//            
//        }
    }
    
}






