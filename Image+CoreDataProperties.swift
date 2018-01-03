//
//  Image+CoreDataProperties.swift
//  
//
//  Created by Vlad Sys on 12/30/17.
//
//

import Foundation
import CoreData


extension Image {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: "Image")
    }

    @NSManaged public var date: String?
    @NSManaged public var image: NSData?

}
