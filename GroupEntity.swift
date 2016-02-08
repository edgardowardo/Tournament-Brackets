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
    
    var teamCount: Int16? {
        set {
            self.willChangeValueForKey("teamCount")
            self.setPrimitiveValue(NSNumber(short: newValue!), forKey: "teamCount")
            self.didChangeValueForKey("teamCount")
            
            // auto create team relationship when count is set
            for var i : Int16 = 0; i < newValue!; i++ {
                self.addTeam(TeamEntity.create("Team \(i + 1)"))
            }
        }
        get {
            self.willAccessValueForKey("teamCount")
            let n = self.primitiveValueForKey("teamCount") as! NSNumber
            self.didAccessValueForKey("teamCount")
            return Int16(n.integerValue)
        }
    }

    func addTeam(team:TeamEntity) {
        let teams = self.mutableSetValueForKey("teamsRelation")
        teams.addObject(team)
    }
    
    class func create(name : String? = nil) -> GroupEntity {
        let g = GroupEntity.MR_createEntity()! as GroupEntity
        if let n = name {
            g.name = n
        } else {
            g.name = "Group \(GroupEntity.MR_countOfEntities() + 1)"
        }
        g.teamCount = 4
        return g
    }
    
    // Round Robin Pairs
    func createGames() {
        var metaTeamCount = self.teamCount!
        // Odd number of teams make it even
        if metaTeamCount % 2 != 0 {
            metaTeamCount++
        }
        

        self.teamsRelation?.allObjects
        
        
    }
}
