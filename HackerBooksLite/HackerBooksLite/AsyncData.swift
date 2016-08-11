//
//
//  AsyncData.swift
//  HackerBooksLite
//
//  Created by Fernando Rodríguez Romero on 7/12/16.
//  Copyright © 2016 KeepCoding. All rights reserved.
//

import Foundation
import UIKit



public
class  AsyncData {
    
    private let url     : URL
    private var data    : Data
    private var delegate: AsyncDataDelegate?

    
    init(url: URL, defaultData : Data){
        self.url = url
        self.data = defaultData
    }
    
    //MARK: - Data Fetching
    public
    func load(){
     
        if delegate?.asyncData(self, shouldStartLoadingFrom: url) == true {
            DispatchQueue.global(qos: .default).async {
                self.delegate?.asyncData(self, willStartLoadingFrom: self.url)
                
                let tmpData = try! Data(contentsOf: self.url)
                
                DispatchQueue.main.async {
                    self.data = tmpData
                    
                    self.delegate?.asyncData(self, didEndLoadingFrom: self.url)
                    self.sendNotification()
                }
            }

        }
        
    }
    //MARK: - Utils
    private
    func sandboxSubfolderURL() -> URL{
        
        
        let fm = FileManager.default
        let urls = fm.urls(for: .cachesDirectory, in: .userDomainMask)
        let url = urls.last?.appendingPathComponent("\(self.dynamicType)")
        
        return url!
        
    }
    
    private
    func localURL(forRemoteURL remoteURL: URL)  -> URL{
        
        let fileName = remoteURL.lastPathComponent
        return sandboxSubfolderURL().appendingPathComponent(fileName)
        
    }
    
 
}

//MARK: - Delegate
public
protocol AsyncDataDelegate {

    func asyncData(_ sender: AsyncData, shouldStartLoadingFrom url: URL )->Bool
    func asyncData(_ sender: AsyncData, willStartLoadingFrom url: URL)
    func asyncData(_ sender: AsyncData, didEndLoadingFrom url: URL)

}
// Default implemntation for infrequently used methods
extension AsyncDataDelegate{
    func asyncData(_ sender: AsyncData, shouldStartLoadingFrom url: URL )->Bool{
        return true
    }
    
    func asyncData(_ sender: AsyncData, willStartLoadingFrom url: URL){}
}


//MARK: - Notifications
let AsyncDataDidEndLoading = Notification.Name(rawValue: "io.keepCoding.AsyncDataDidEndLoading")

extension AsyncData{
    private
    func sendNotification(){
    
        let n = Notification(name: AsyncDataDidEndLoading,
                             object: self, userInfo: ["url" : url, "data" : data])
        
        let nc = NotificationCenter.default
        
        nc.post(n)
        
        
    }
}


//MARK: - AsyncImage
public
class AsyncImage : AsyncData{
    
    var image : UIImage{
        get{
            return UIImage(data: data)!
        }set{
            data = UIImagePNGRepresentation(newValue)!
        }
    }
    
    init(url: URL, defaultImage: UIImage) {
        super.init(url: url, defaultData: UIImagePNGRepresentation(defaultImage)!)
    }
    
}
