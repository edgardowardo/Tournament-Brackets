//
//  GroupEntity+SchedulerDelegate.swift
//  TournamentBrackets
//
//  Created by EDGARDO AGNO on 09/02/2016.
//  Copyright © 2016 EDGARDO AGNO. All rights reserved.
//

import Foundation

extension GroupEntity : SchedulerDelegate {
        
    func addGame(game:GameEntity) {
        let games = self.mutableSetValueForKey("gamesRelation")
        games.addObject(game)
    }
    
    func createGames() {
        let schedule = Schedule(rawValue: self.scheduleType)!
        guard var teams = self.teams where teams.count >= schedule.minimumTeams else { return }
        
        // sort teams by seeding
        teams.sortInPlace({ $0.0.seeding < $0.1.seeding })
        
        // if even add a bye
        if teams.count % 2 != 0 {
            teams.append(TeamEntity.create(Int16(teams.count + 1), name: "Bye", isBye: true))
        }
        
        self.deleteGames()
        
        var s : Scheduler?
        switch schedule {
        case .RoundRobinPair :
            s = RoundRobinPair(delegate: self)
        case .RoundRobin :
            s = RoundRobin(delegate: self)
        case .SingleElimination :
            s = SingleElimination(delegate: self)
        default :
            assertionFailure("unknown schedule!")
        }
        
        if let scheduler = s {
            scheduler.rainbowPair(1, row: teams, isHandicap: self.isHandicap)
        }
    }
}