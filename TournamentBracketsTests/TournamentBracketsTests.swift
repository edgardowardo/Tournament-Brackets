//
//  TournamentBracketsTests.swift
//  TournamentBracketsTests
//
//  Created by EDGARDO AGNO on 11/02/2016.
//  Copyright © 2016 EDGARDO AGNO. All rights reserved.
//

import XCTest
import MagicalRecord

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
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        DataManager.sharedInstance.newTournament()
        if let g = DataManager.sharedInstance.currentTournament?.currentGroupRelation {
            g.teamCount = 5
            g.scheduleType = Int16(Schedule.SingleElimination.hashValue)
            NSManagedObject.commit()
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
