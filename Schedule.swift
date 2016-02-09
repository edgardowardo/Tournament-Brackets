//
//  Schedule.swift
//  TournamentBrackets
//
//  Created by EDGARDO AGNO on 09/02/2016.
//  Copyright © 2016 EDGARDO AGNO. All rights reserved.
//

enum Schedule : Int16 {
    case RoundRobinPair, RoundRobin, SingleElimination, DoubleElimination
    
    func minimumTeams() -> Int {
        switch self {
        case .RoundRobinPair :
            return 4
        case .RoundRobin :
            fallthrough
        case .SingleElimination :
            fallthrough
        case .DoubleElimination :
            return 2
        }
    }
}