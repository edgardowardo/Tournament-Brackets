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
            t.name = "Tournament \(TournamentEntity.MR_countOfEntities())"
        }
        let g = GroupEntity.create("Group 1")
        t.addGroup(g)
        return t
    }
    
    func addGroup(group:GroupEntity) {
        let groups = self.mutableSetValueForKey("groupsRelation")
        groups.addObject(group)
        self.currentGroupRelation = group
    }
    
    internal override var description: String {
        get {
            var groupCount = 0
            var currentGroupName = ""
            if let g = self.groupsRelation {
                groupCount = g.count
            }
            if let g = self.currentGroupRelation, n = g.name {
                currentGroupName = n
            }
            return "[\(self.name!)] - \(groupCount) groups,  [\(currentGroupName)] current group"
        }
    }
}
