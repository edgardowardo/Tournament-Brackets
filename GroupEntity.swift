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
    
    // MARK: - Manual properties -
    
    var teamCount: Int16? {
        set {
            self.willChangeValueForKey("teamCount")
            self.setPrimitiveValue(NSNumber(short: newValue!), forKey: "teamCount")
            self.didChangeValueForKey("teamCount")
            
            // auto create team relationship when count is set
            for var i : Int16 = 0; i < newValue!; i++ {
                let t = TeamEntity.create(i + 1, name: "Team \(i + 1)")
                self.addTeam(t)
            }
        }
        get {
            self.willAccessValueForKey("teamCount")
            let n = self.primitiveValueForKey("teamCount") as! NSNumber
            self.didAccessValueForKey("teamCount")
            return Int16(n.integerValue)
        }
    }
    
    // MARK: - Functions -
    
    func deleteGames() {
        let games = self.mutableSetValueForKey("gamesRelation")
        for g in games {
            g.MR_deleteEntity()
        }
    }
    
    func shuffleTeams() {
        let teamsSet = self.mutableSetValueForKey("teamsRelation")
        let teams = teamsSet.allObjects.shuffle() as! [TeamEntity]
        for i in 0...teams.count-1 {
            teams[i].seeding = Int16(i)
        }
    }
    
    func teams() -> [TeamEntity] {
        return self.teamsRelation!.allObjects as! [TeamEntity]
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
        g.scheduleType = Int16(Schedule.RoundRobinPair.hashValue)
        return g
    }
}
