//
//  GroupEntity+SchedulerDelegate.swift
//  TournamentBrackets
//
//  Created by EDGARDO AGNO on 09/02/2016.
//  Copyright © 2016 EDGARDO AGNO. All rights reserved.
//

import Foundation

extension GroupEntity : SchedulerDelegate {
    
    func deleteGames() {
        let games = self.mutableSetValueForKey("gamesRelation")
        for g in games {
            g.MR_deleteEntity()
        }
    }
    
    func teams() -> [TeamEntity] {
        return self.teamsRelation!.allObjects as! [TeamEntity]
    }
    
    func addGame(game:GameEntity) {
        let games = self.mutableSetValueForKey("gamesRelation")
        games.addObject(game)
    }
    
    func games() -> [GameEntity] {
        return self.gamesRelation!.allObjects as! [GameEntity]
    }
    
    func createGames() {
        let schedule = Schedule(rawValue: self.scheduleType)!
        switch schedule {
        case .RoundRobinPair :
            let scheduler = RoundRobinPair()
            scheduler.delegate = self
            scheduler.createGames(self.isHandicap)
        default :
            assertionFailure("unknown schedule!")
        }
    }
}