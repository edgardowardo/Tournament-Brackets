//
//  RoundRobinPair.swift
//  TournamentBrackets
//
//  Created by EDGARDO AGNO on 09/02/2016.
//  Copyright © 2016 EDGARDO AGNO. All rights reserved.
//

import Foundation

protocol SchedulerDelegate {
    func deleteGames()
    func teams() -> [TeamEntity]
    func addGame(game:GameEntity)
    func games() -> [GameEntity]
}

class RoundRobinPair {
 
    var delegate : SchedulerDelegate?
    
    // Round Robin Pairs
    func createGames(isHandicap : Bool) {
        guard var teams = delegate?.teams() where teams.count >= 4 else { return }
        
        delegate?.deleteGames()
        
        // sort teams by seeding
        teams.sortInPlace({ $0.0.seeding < $0.1.seeding })
        
        // Odd number of teams make it even
        var metaTeamCount = teams.count
        if metaTeamCount % 2 != 0 {
            metaTeamCount++
            teams.append(TeamEntity.create(Int16(metaTeamCount), name: "Bye", isBye: true))
        }
        
        rainbowPair(1, row: teams, isHandicap: isHandicap)
    }
    
    func rainbowPair(round : Int, row : [TeamEntity], isHandicap : Bool) {
        guard let games = delegate?.games() where round < row.count else { return }
        
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
            
            let index = games.count
            let g = GameEntity.create(index, round: round)
            
            g.homeScore = 0
            g.awayScore = 0
            if isHandicap {
                let homeHandicap = home1.handicap + home2.handicap
                let awayHandicap = away1.handicap + away2.handicap
                let difference = abs(homeHandicap - awayHandicap)
                if homeHandicap > awayHandicap {
                    g.homeScore = Int64(difference / 2)
                    g.awayScore = -(g.homeScore)
                } else if homeHandicap < awayHandicap {
                    g.awayScore = Int64(difference / 2)
                    g.homeScore = -(g.homeScore)
                }
            }
            
            g.isBye = home1.isBye || home2.isBye || away1.isBye || away2.isBye
            g.homeName = "\(home1.name!)/\(home2.name!)"
            g.awayName = "\(away1.name!)/\(away2.name!)"
            g.homeKey = "\(home1.key!),\(home2.key!)"
            g.awayKey = "\(away1.key!),\(away2.key!)"
            g.info = "\(g.homeName!) vs \(g.awayName!)"
            
            delegate?.addGame(g)
        }
        
        // shift the elements to process as the next row
        var nextrow = row
        let displaced = nextrow.removeAtIndex(row.count - 2)
        nextrow.insert(displaced, atIndex: 0)
        rainbowPair(round + 1, row: nextrow, isHandicap: isHandicap)
    }
}