//
//  TeamEntity.swift
//  TournamentBrackets
//
//  Created by EDGARDO AGNO on 07/02/2016.
//  Copyright © 2016 EDGARDO AGNO. All rights reserved.
//

import Foundation
import CoreData

class TeamEntity: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

    class func create(name : String? = nil) -> TeamEntity {
        let t = TeamEntity.MR_createEntity()! as TeamEntity
        if let n = name {
            t.name = n
        } else {
            t.name = "Team \(TeamEntity.MR_countOfEntities() + 1)"
        }
        return t
    }
}
