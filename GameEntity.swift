//
//  GameEntity.swift
//  TournamentBrackets
//
//  Created by EDGARDO AGNO on 07/02/2016.
//  Copyright © 2016 EDGARDO AGNO. All rights reserved.
//

import Foundation
import CoreData

class GameEntity: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    
    class func create(index: Int, round : Int, info : String? = nil) -> GameEntity {
        let g = GameEntity.MR_createEntity()! as GameEntity
        if let n = info {
            g.info = n
        } else {
            g.info = "Game \(GroupEntity.MR_countOfEntities() + 1)"
        }
        g.index = Int16(index)
        g.round = Int16(round)
        g.homeIncident = Int16(Incident.None.hashValue)
        g.awayIncident = Int16(Incident.None.hashValue)
        return g
    }
    
    func calculateHandicaps(betweenHome home : TeamEntity, andAway away : TeamEntity) {
        let homeHandicap = home.handicap
        let awayHandicap = away.handicap
        let difference = abs(homeHandicap - awayHandicap)
        if homeHandicap > awayHandicap {
            self.homeScore = Int64(difference / 2)
            self.awayScore = -(self.homeScore)
        } else if homeHandicap < awayHandicap {
            self.awayScore = Int64(difference / 2)
            self.homeScore = -(self.homeScore)
        }
    }
}
