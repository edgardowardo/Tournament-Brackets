//
//  RoundRobin.swift
//  TournamentBrackets
//
//  Created by EDGARDO AGNO on 09/02/2016.
//  Copyright © 2016 EDGARDO AGNO. All rights reserved.
//

import Foundation

class RoundRobin {
    
    var delegate : SchedulerDelegate?
    
    func rainbowPair(round : Int, row : [TeamEntity], isHandicap : Bool) {
        guard let games = delegate?.games() where round < row.count else { return }
        
        let endIndex = row.count - 1
        for var i = row.count / 2 - 1; i > 0 ; i-- {

            let home = row[i]
            let away = row[endIndex - i]
            
            let index = games.count
            let g = GameEntity.create(index, round: round)
            
            g.homeScore = 0
            g.awayScore = 0
            if isHandicap {
                let homeHandicap = home.handicap
                let awayHandicap = away.handicap
                let difference = abs(homeHandicap - awayHandicap)
                if homeHandicap > awayHandicap {
                    g.homeScore = Int64(difference / 2)
                    g.awayScore = -(g.homeScore)
                } else if homeHandicap < awayHandicap {
                    g.awayScore = Int64(difference / 2)
                    g.homeScore = -(g.homeScore)
                }
            }
            
            g.isBye = home.isBye || away.isBye
            g.homeName = "\(home.name!)"
            g.awayName = "\(away.name!)"
            g.homeKey = "\(home.key!)"
            g.awayKey = "\(away.key!)"
            g.info = "\(g.homeName!) vs \(g.awayName!)"
            
            delegate?.addGame(g)
        }
        
        // shift the elements to process as the next row. the first element is fixed hence insert to position one.
        var nextrow = row
        let displaced = nextrow.removeAtIndex(row.count - 1)
        nextrow.insert(displaced, atIndex: 1)
        rainbowPair(round + 1, row: nextrow, isHandicap: isHandicap)
    }
}