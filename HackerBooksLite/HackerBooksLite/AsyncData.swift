//
//  AsyncData.swift
//  HackerBooksLite
//
//  Created by Fernando Rodríguez Romero on 7/12/16.
//  Copyright © 2016 KeepCoding. All rights reserved.
//

import Foundation

//MARK: - Errors
enum AsyncDataErrors{
    case urlDoesntPointToFile(NSURL)
}

struct AsyncData{
    
    private let url     : URL
    private var data    : Data
    
    init(url: URL, defaultData : Data){
        self.url = url
        self.data = defaultData
        //MARK: -
        let fm = FileManager.default
        let local = localURL(forRemoteURL: url)
        if fm.fileExists(atPath: local.path!){
            data = try! Data(contentsOf: local as URL)
        }else{
            //dispatch asinc!
        }
    }
    
    //MARK: - Utils
    private func sandboxSubfolderURL() -> URL{
        
        
        let fm = FileManager.default
        let urls = fm.urlsForDirectory(.cachesDirectory, inDomains:.userDomainMask)
        let url = try! urls.last?.appendingPathComponent("\(self.dynamicType)")
        
        return url!
 
    }
    
    private func localURL(forRemoteURL remoteURL: URL)  -> URL{
        
        let fileName = remoteURL.lastPathComponent
        return try! sandboxSubfolderURL().appendingPathComponent(fileName!)
        
    }
    
    
    //MARK: - Integrity Check
    
    
    
    
}










