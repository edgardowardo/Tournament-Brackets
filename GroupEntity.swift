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
            self.deleteTeams()
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
    var teams : [TeamEntity]? {
        get {
            return self.teamsRelation?.allObjects as? [TeamEntity]
        }
    }
    var games : [GameEntity]? {
        get {
            return self.gamesRelation?.allObjects as? [GameEntity]
        }
    }
    
    // MARK: - Functions -
    
    func deleteTeams() {
        let teams = self.mutableSetValueForKey("teamsRelation")
        for t in teams {
            t.MR_deleteEntity()
        }
        teams.removeAllObjects()
    }
    
    func deleteGames() {
        let games = self.mutableSetValueForKey("gamesRelation")
        for g in games {
            g.MR_deleteEntity()
        }
        games.removeAllObjects()
    }
    
    func shuffleTeams() {
        let teamsSet = self.mutableSetValueForKey("teamsRelation")
        let teams = teamsSet.allObjects.shuffle() as! [TeamEntity]
        for i in 0...teams.count-1 {
            teams[i].seeding = Int16(i)
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
        g.scheduleType = Int16(Schedule.RoundRobinPair.hashValue)
        return g
    }
    
    internal override var description: String {
        get {
            let sched = Schedule(rawValue: self.scheduleType)!
            var gamesCount = 0
            if let g = self.gamesRelation {
                gamesCount = g.count
            }
            var teamsCount = 0
            if let t = self.teamsRelation {
                teamsCount = t.count
            }
            let t = teams?.sort({$0.0.seeding < $0.1.seeding}).map({$0.name!}).joinWithSeparator(", ")
            let g = games?.sort({$0.0.index < $0.1.index }).map({$0.info!}).joinWithSeparator(", ")
            return "[\(self.name!)] \(sched.desc), isHandicap(\(isHandicap)) \n\(teamsCount) teams[\(t!)] \n\(gamesCount) games[\(g!)], "
        }
    }
}
