//
//  CoreDataHandler.swift
//  ZHDemoApp
//
//  Created by Ramesh P on 29/06/18.
//  Copyright © 2018 Ramesh P. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHandler: NSObject {
    private class func getContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    
    func insertValue(dictValue: Dictionary<String, Any>) {
        let context =  CoreDataHandler.getContext()
        var homeTimeline : Timeline
        if #available(iOS 10.0, *) {
            homeTimeline = Timeline(context: context)
        } else {
            homeTimeline = NSEntityDescription.insertNewObject(forEntityName: "Timeline", into:context ) as! Timeline
        }
        
        homeTimeline.text = dictValue["text"] as? String
        homeTimeline.retweetcount = (dictValue["retweet_count"] as? Int64)!
        homeTimeline.favoritescount = (dictValue["favorite_count"] as? Int64)!
        
        let dictuser = dictValue["user"] as? NSDictionary
        homeTimeline.username = dictuser!["name"] as? String
        homeTimeline.screenname = dictuser!["screen_name"] as? String
        homeTimeline.tweetid = dictuser!["id_str"] as? String
        
        
        let profileUrlString = dictuser!["profile_image_url"] as? String as NSString?
        if let profileUrlString = profileUrlString {
            homeTimeline.profileurl =  profileUrlString as String
        }
        let timestampString = dictValue["created_at"] as? String
        if let timestampString = timestampString {
            let formatter = DateFormatter()
            //  formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            homeTimeline.timestamp = formatter.date(from: timestampString as String) as Date?
        }
        
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }

        
    }
    
    func insertTimelineContent(arraylist: Array<Any>)  {
       
        
        print(arraylist)
        
        for dictValue in arraylist as [AnyObject]{
                insertValue(dictValue: dictValue as! Dictionary<String, Any>)
                }
            
            
             //}
       //  }
        // Save the context.
//        do {
//            try context.save()
//        } catch {
//            // Replace this implementation with code to handle the error appropriately.
//            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            let nserror = error as NSError
//            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//        }

    }
    class func retrieveHomeTimeline()  -> Array<Any>
    {
        //        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //        let context = appDelegate.persistentContainer.viewContext
        let context = getContext()
        
        let request: NSFetchRequest<Timeline> = Timeline.fetchRequest()
        do {
            let result = try context.fetch(request as! NSFetchRequest<NSFetchRequestResult>) as! [Timeline]
             for managedObject in result {
                print("%@",managedObject.tweetid ?? "Empty")
            }
            return result
        } catch {
            //            let fetchError = error as NSError
            //            print(fetchError)
        }
        var myArr1 = [AnyObject]()
        return myArr1
        
    }
    
    
}



