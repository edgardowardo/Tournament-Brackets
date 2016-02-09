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

    func deleteGames() {
        let games = self.mutableSetValueForKey("gamesRelation")
        for g in games {
            g.MR_deleteEntity()
        }
    }
    
    func addGame(game:GameEntity) {
        let games = self.mutableSetValueForKey("gamesRelation")
        games.addObject(game)
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
        g.teamCount = 7
        return g
    }
    
    // Round Robin Pairs
    func createGames() {
        guard teamCount >= 4 else { return }
        
        deleteGames()
        
        // sort teams by seeding
        var teams = self.teamsRelation!.allObjects as! [TeamEntity]
        teams = teams.sort({ $0.0.seeding < $0.1.seeding })
        
        // Odd number of teams make it even
        var metaTeamCount = teams.count
        if metaTeamCount % 2 != 0 {
            metaTeamCount++
            teams.append(TeamEntity.create(Int16(metaTeamCount), name: "Bye", isBye: true))
        }
        
        rainbowPair(1, row: teams)
    }
    
    func rainbowPair(round : Int, row : [TeamEntity]) {
        guard round < row.count else { return }
        
        let endIndex = row.count - 1
        for var i = row.count / 2 - 1; i > 0 ; i-=2 {
            // home
            let home1 = row[i]
            let home2 = row[endIndex - i]
            
            // away
            let away1 = row[i - 1]
            let away2 = row[endIndex - (i - 1)]
            
            if home1.isBye || home2.isBye || away1.isBye || away2.isBye {
                continue
            }
            
            let games = self.mutableSetValueForKey("gamesRelation")
            let index = games.count
            let g = GameEntity.create(index, round: round)
            
            if self.isHandicap {
                g.homeScore = Int64(home1.handicap) + Int64(home2.handicap)
                g.awayScore = Int64(away1.handicap) + Int64(away2.handicap)
            } else {
                g.homeScore = 0
                g.awayScore = 0
            }
            g.isBye = home1.isBye || home2.isBye || away1.isBye || away2.isBye
            g.homeName = "\(home1.name!)/\(home2.name!)"
            g.awayName = "\(away1.name!)/\(away2.name!)"
            g.homeKey = "\(home1.key!),\(home2.key!)"
            g.awayKey = "\(away1.key!),\(away2.key!)"
            g.info = "\(g.homeName!) vs \(g.awayName!)"
            
            addGame(g)
        }
        
        
        // shift the elements to process as the next row
        var nextrow = row
        let displaced = nextrow.removeAtIndex(row.count - 2)
        nextrow.insert(displaced, atIndex: 0)
        rainbowPair(round + 1, row: nextrow)
    }
}
