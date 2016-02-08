//
//  GroupEntity.swift
//  TournamentBrackets
//
//  Created by EDGARDO AGNO on 07/02/2016.
//  Copyright © 2016 EDGARDO AGNO. All rights reserved.
//

import Foundation
import CoreData

class GroupEntity: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

    class func create(name : String? = nil) -> GroupEntity {
        let t = GroupEntity.MR_createEntity()! as GroupEntity
        if let n = name {
            t.name = n
        } else {
            t.name = "Group \(GroupEntity.MR_countOfEntities() + 1)"
        }
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
        return t
    }
    
}
