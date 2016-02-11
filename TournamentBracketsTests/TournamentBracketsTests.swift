//
//  TournamentBracketsTests.swift
//  TournamentBracketsTests
//
//  Created by EDGARDO AGNO on 11/02/2016.
//  Copyright © 2016 EDGARDO AGNO. All rights reserved.
//

import XCTest
import MagicalRecord
import Nimble

class TournamentBracketsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        TournamentEntity.MR_truncateAll()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testRoundRobinPair() {
        DataManager.sharedInstance.newTournament()
        if let g = DataManager.sharedInstance.currentTournament?.currentGroupRelation {
            g.scheduleType = Int16(Schedule.RoundRobinPair.hashValue)
            
            g.teamCount = 4
            g.createGames()
            NSManagedObject.commit()
            expect(g.teamsRelation?.count) == 4
            expect(g.gamesRelation?.count) == 3
            
            g.teamCount = 5
            g.createGames()
            NSManagedObject.commit()
            expect(g.teamsRelation?.count) == 5
            expect(g.gamesRelation?.count) == 5

            g.teamCount = 6
            g.createGames()
            NSManagedObject.commit()
            expect(g.teamsRelation?.count) == 6
            expect(g.gamesRelation?.count) == 5
            
            g.teamCount = 7
            g.createGames()
            NSManagedObject.commit()
            expect(g.teamsRelation?.count) == 7
            expect(g.gamesRelation?.count) == 7
            
            g.teamCount = 8
            g.createGames()
            NSManagedObject.commit()
            expect(g.teamsRelation?.count) == 8
            expect(g.gamesRelation?.count) == 14
            
            g.teamCount = 9
            g.createGames()
            NSManagedObject.commit()
            expect(g.teamsRelation?.count) == 9
            expect(g.gamesRelation?.count) == 18
            
            g.teamCount = 10
            g.createGames()
            NSManagedObject.commit()
            expect(g.teamsRelation?.count) == 10
            expect(g.gamesRelation?.count) == 18

            g.teamCount = 11
            g.createGames()
            NSManagedObject.commit()
            expect(g.teamsRelation?.count) == 11
            expect(g.gamesRelation?.count) == 22

            g.teamCount = 12
            g.createGames()
            NSManagedObject.commit()
            expect(g.teamsRelation?.count) == 12
            expect(g.gamesRelation?.count) == 33
            
            g.teamCount = 13
            g.createGames()
            NSManagedObject.commit()
            expect(g.teamsRelation?.count) == 13
            expect(g.gamesRelation?.count) == 39

            g.teamCount = 14
            g.createGames()
            NSManagedObject.commit()
            expect(g.teamsRelation?.count) == 14
            expect(g.gamesRelation?.count) == 39

            g.teamCount = 15
            g.createGames()
            NSManagedObject.commit()
            expect(g.teamsRelation?.count) == 15
            expect(g.gamesRelation?.count) == 45
            
            g.teamCount = 16
            g.createGames()
            NSManagedObject.commit()
            expect(g.teamsRelation?.count) == 16
            expect(g.gamesRelation?.count) == 60
        }
    }
    
    
    func testRoundRobin() {
        DataManager.sharedInstance.newTournament()
        if let g = DataManager.sharedInstance.currentTournament?.currentGroupRelation {
            g.scheduleType = Int16(Schedule.RoundRobin.hashValue)
            
            g.teamCount = 2
            g.createGames()
            NSManagedObject.commit()
            expect(g.teamsRelation?.count) == 2
            expect(g.gamesRelation?.count) == 1
            
            g.teamCount = 3
            g.createGames()
            NSManagedObject.commit()
            expect(g.teamsRelation?.count) == 3
            expect(g.gamesRelation?.count) == 6
            
            g.teamCount = 4
            g.createGames()
            NSManagedObject.commit()
            expect(g.teamsRelation?.count) == 4
            expect(g.gamesRelation?.count) == 6
            
            g.teamCount = 5
            g.createGames()
            NSManagedObject.commit()
            expect(g.teamsRelation?.count) == 5
            expect(g.gamesRelation?.count) == 15
            
            g.teamCount = 6
            g.createGames()
            NSManagedObject.commit()
            expect(g.teamsRelation?.count) == 6
            expect(g.gamesRelation?.count) == 15
            
            g.teamCount = 7
            g.createGames()
            NSManagedObject.commit()
            expect(g.teamsRelation?.count) == 7
            expect(g.gamesRelation?.count) == 28
            
            g.teamCount = 8
            g.createGames()
            NSManagedObject.commit()
            expect(g.teamsRelation?.count) == 8
            expect(g.gamesRelation?.count) == 28
        }
    }
    
    func testSingleElimination() {
        DataManager.sharedInstance.newTournament()
        if let g = DataManager.sharedInstance.currentTournament?.currentGroupRelation {
            g.scheduleType = Int16(Schedule.SingleElimination.hashValue)

            g.teamCount = 2
            g.createGames()
            NSManagedObject.commit()
            expect(g.teamsRelation?.count) == 2
            expect(g.gamesRelation?.count) == 1

            g.teamCount = 3
            g.createGames()
            NSManagedObject.commit()
            expect(g.teamsRelation?.count) == 3
            expect(g.gamesRelation?.count) == 3
            
            g.teamCount = 4
            g.createGames()
            NSManagedObject.commit()
            expect(g.teamsRelation?.count) == 4
            expect(g.gamesRelation?.count) == 3

            g.teamCount = 5
            g.createGames()
            NSManagedObject.commit()
            expect(g.teamsRelation?.count) == 5
            expect(g.gamesRelation?.count) == 7
            
            g.teamCount = 6
            g.createGames()
            NSManagedObject.commit()
            expect(g.teamsRelation?.count) == 6
            expect(g.gamesRelation?.count) == 7
            
            g.teamCount = 7
            g.createGames()
            NSManagedObject.commit()
            expect(g.teamsRelation?.count) == 7
            expect(g.gamesRelation?.count) == 7
            
            g.teamCount = 8
            g.createGames()
            NSManagedObject.commit()
            expect(g.teamsRelation?.count) == 8
            expect(g.gamesRelation?.count) == 7
            
            g.teamCount = 9
            g.createGames()
            NSManagedObject.commit()
            expect(g.teamsRelation?.count) == 9
            expect(g.gamesRelation?.count) == 15
            
            g.teamCount = 10
            g.createGames()
            NSManagedObject.commit()
            expect(g.teamsRelation?.count) == 10
            expect(g.gamesRelation?.count) == 15
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
