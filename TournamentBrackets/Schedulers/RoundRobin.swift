//
//  RoundRobin.swift
//  TournamentBrackets
//
//  Created by EDGARDO AGNO on 09/02/2016.
//  Copyright © 2016 EDGARDO AGNO. All rights reserved.
//

import Foundation

class RoundRobin : Scheduler {
    
    var delegate : SchedulerDelegate?
    
    init() {
    }
    
    convenience init(delegate : SchedulerDelegate) {
        self.init()
        self.delegate = delegate
    }
    
    func rainbowPair(round : Int, row : [TeamEntity], isHandicap : Bool) {
        guard let games = delegate?.games where round < row.count else { return }

        var index = games.count
        let endIndex = row.count - 1
        for var i = row.count / 2 - 1; i >= 0 ; i-- {

            let home = row[i]
            let away = row[endIndex - i]
            let g = GameEntity.create(index++, round: round)
            
            g.homeScore = 0
            g.awayScore = 0
            if isHandicap {
                g.calculateHandicaps(betweenHome: home, andAway: away)
            }
            g.isBye = home.isBye || away.isBye
            g.homeName = "\(home.name!)"
            g.awayName = "\(away.name!)"
            g.homeKey = "\(home.key!)"
            g.awayKey = "\(away.key!)"
            g.info = "\(g.round). \(g.homeName!) vs \(g.awayName!) (\(g.index))"
            
            delegate?.addGame(g)
        }
        
        // shift the elements to process as the next row. the first element is fixed hence insert to position one.
        var nextrow = row
        let displaced = nextrow.removeAtIndex(row.count - 1)
        nextrow.insert(displaced, atIndex: 1)
        rainbowPair(round + 1, row: nextrow, isHandicap: isHandicap)
    }
}