//
//  _15_puzzleTestsFor6size.swift
//  15 puzzleTests
//
//  Created by Andrew Yakovenko on 2/3/19.
//  Copyright © 2019 Andrew Yakovenko. All rights reserved.
//

import XCTest

class _15_puzzleTestsFor6size: XCTestCase {
    
    var game: Logic!
    
    
    override func setUp() {
        game = Logic(6)
        game.startNewGame()
    }
    
    func  testStarNewGame() {
        
        XCTAssertTrue(game.puzzle[game.size - 1][game.size - 1] == 36)
        XCTAssertTrue(game.puzzle != game.toWinPuzzle)
    }
    
    func testCorectCoredineteRetorn() {
        
        let randomNumberToCheck = Int.random(in: 1 ..< game.size * game.size)
        let coredinate = game.find(Cordinate: randomNumberToCheck)
        
        XCTAssertTrue(game.puzzle[coredinate.0][coredinate.1] == randomNumberToCheck)
    }
    
    
    func testLogicCantPlayerMoveItDontCrash() {
        
        XCTAssertFalse(game.cantPlayerMoveIt(first: game.emptyCell, second: (6915, 4121)))
        XCTAssertFalse(game.cantPlayerMoveIt(first: game.emptyCell, second: (15, 51513)))
        XCTAssertFalse(game.cantPlayerMoveIt(first: game.emptyCell, second: (7, 666)))
        
    }
    
//    func testLogicCorectCoredineteRetornDontCrash() {
//        
//        let randomNumberToCheck = Int.random(in: 1 ..< game.size + 1000 * game.size)
//        let coredinate = game.findCordinate(Cell: randomNumberToCheck)
//        XCTAssertFalse(game.puzzle[coredinate.0][coredinate.1] == randomNumberToCheck)
//        
//    }
    
    
}
