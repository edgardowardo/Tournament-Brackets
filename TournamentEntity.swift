//
//  TournamentEntity.swift
//  TournamentBrackets
//
//  Created by EDGARDO AGNO on 07/02/2016.
//  Copyright © 2016 EDGARDO AGNO. All rights reserved.
//

import Foundation
import CoreData

class TournamentEntity: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

    class func create(name : String? = nil) -> TournamentEntity {
        let t = TournamentEntity.MR_createEntity()! as TournamentEntity
        if let n = name {
            t.name = n
        } else {
            t.name = "Tournament \(TournamentEntity.MR_countOfEntities() + 1)"
        }
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
        return t
    }
}
