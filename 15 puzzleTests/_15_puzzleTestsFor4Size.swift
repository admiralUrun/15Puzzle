//
//  _15_puzzleTests.swift
//  15 puzzleTests
//
//  Created by Andrew Yakovenko on 11/30/18.
//  Copyright © 2018 Andrew Yakovenko. All rights reserved.
//

import XCTest
@testable import _5_puzzle

class _15_puzzleTestsFor4Size: XCTestCase {

    var game: Logic!

    
    override func setUp() {
        game = Logic(4)
        game.startNewGame()
    }
    
    
    func  testStarNewGame() {

        XCTAssertTrue(game.puzzle[game.size - 1][game.size - 1] == 16)
        XCTAssertTrue(game.puzzle != game.toWinPuzzle)
    }
    
    func testCorectCoredineteRetorn() {
 
        let randomNumberToCheck = Int.random(in: 1 ..< game.size * game.size)
        let coredinate = game.find(Cordinate: randomNumberToCheck)
        
        XCTAssertTrue(game.puzzle[coredinate.0][coredinate.1] == randomNumberToCheck)
    }
    
    
    func testEditPuzzle() {

        XCTAssertFalse(game.cantPlayerMoveIt(from: game.emptyCell, to: (0, 0)))
        XCTAssertFalse(game.cantPlayerMoveIt(from: (3,2), to: (1,1)))
        XCTAssertTrue(game.cantPlayerMoveIt(from: game.emptyCell, to: (game.emptyCell.0, game.emptyCell.1 - 1)))
        
    }
    
    func testLogicCantPlayerMoveItDontCrash() {
        
        XCTAssertFalse(game.cantPlayerMoveIt(from: game.emptyCell, to: (11, 4)))
        XCTAssertFalse(game.cantPlayerMoveIt(from: game.emptyCell, to: (5, 4)))
        XCTAssertFalse(game.cantPlayerMoveIt(from: game.emptyCell, to: (8, 4)))
        
    }
    

}
