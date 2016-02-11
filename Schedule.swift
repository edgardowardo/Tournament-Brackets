//
//  Schedule.swift
//  TournamentBrackets
//
//  Created by EDGARDO AGNO on 09/02/2016.
//  Copyright © 2016 EDGARDO AGNO. All rights reserved.
//

enum Schedule : Int16 {
    case RoundRobinPair, RoundRobin, SingleElimination, DoubleElimination
    
    var desc : String {
        get {
            switch self {
            case .RoundRobinPair :
                return "Round Robin Pair"
            case .RoundRobin :
                return "Round Robin"
            case .SingleElimination :
                return "Single Elimination"
            case .DoubleElimination :
                return "Double Elimination"
            }
        }
    }
    
    var minimumTeams : Int {
        get {
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
}