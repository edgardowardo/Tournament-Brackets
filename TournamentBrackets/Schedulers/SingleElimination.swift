//
//  SingleElimination.swift
//  TournamentBrackets
//
//  Created by EDGARDO AGNO on 09/02/2016.
//  Copyright © 2016 EDGARDO AGNO. All rights reserved.
//

import Foundation

class SingleElimination : Scheduler  {
    
    var delegate : SchedulerDelegate?
    
    init() {
    }
    
    convenience init(delegate : SchedulerDelegate) {
        self.init()
        self.delegate = delegate
    }
    
    func rainbowPair(round : Int, var row : [TeamEntity], isHandicap : Bool) {
        guard let games = delegate?.games where round < row.count else { return }
        
        // Adjust the number of teams necessary to construct the brackets which are 2, 4, 8, 16, 32 and 64
        for i in 1...8 {
            let minimum = 2^^i
            if row.count < minimum {
                let diff = minimum - row.count
                for _ in 1...diff {
                    let t = TeamEntity.create(Int16(row.count + 1), name: "Bye", isBye: true)
                    t.key = "\(t.seeding)"
                    row.append(t)
                }
                break
            } else if row.count == minimum {
                break
            }
        }
        
        // process all the teams and create the games       
        var roundOfGames = [GameEntity]()
        var index = games.count
        let endIndex = row.count - 1
        for var i = row.count / 2 - 1; i >= 0 ; i-- {
            
            let home = row[i]
            let away = row[endIndex - i]
            let g = GameEntity.create(++index, round: round)
            
            g.homeScore = 0
            g.awayScore = 0
            if isHandicap {
                g.calculateHandicaps(betweenHome: home, andAway: away)
            }
            g.isBye = home.isBye || away.isBye
            if home.isBye {
                g.winnerRelation = away
            } else if away.isBye {
                g.winnerRelation = home
            }
            g.homeName = "\(home.name!)"
            g.awayName = "\(away.name!)"
            g.homeKey = "\(home.key!)"
            g.awayKey = "\(away.key!)"
            g.info = "R\(g.round).\(g.index)) \(g.homeName!) vs \(g.awayName!)"
            
            delegate?.addGame(g)
            roundOfGames.append(g)
        }
        
        // apply rainbow pairing for the new game winners instead of teams
        self.rainbowPair(round + 1, row: roundOfGames, isHandicap: isHandicap, index : index)
    }
    
    func rainbowPair(round : Int, row : [GameEntity], isHandicap : Bool, var index : Int) {
        guard row.count > 1 else { return }
        
        // process all the game winners to create new games for the round
        var roundOfGames = [GameEntity]()
        let endIndex = row.count - 1
        for var i = row.count / 2 - 1; i >= 0 ; i-- {
            
            var homeWinner : TeamEntity?
            let home = row[i]
            let away = row[endIndex - i]
            var awayWinner : TeamEntity?
            let g = GameEntity.create(++index, round: round)
            
            g.homeScore = 0
            g.awayScore = 0
            g.isBye = home.isBye || away.isBye
            if home.isBye {
                homeWinner = home.winnerRelation
            } else if away.isBye {
                awayWinner = away.winnerRelation
            }
            
            var homeName = "Winner \(home.index)"
            if let h = homeWinner {
                g.homeName = h.name!
                g.homeKey = h.key!
                homeName = g.homeName!
            }
            var awayName = "Winner \(away.index)"
            if let a = awayWinner {
                g.awayName = a.name!
                g.awayKey = a.key!
                awayName = g.awayName!
            }
            
            g.info = "R\(g.round).\(g.index)) \(homeName) vs \(awayName)"
            delegate?.addGame(g)
            roundOfGames.append(g)
        }

        // apply rainbow pairing for the new game winners until the base case happens
        rainbowPair(round + 1, row: roundOfGames, isHandicap: isHandicap, index : index)
    }
}