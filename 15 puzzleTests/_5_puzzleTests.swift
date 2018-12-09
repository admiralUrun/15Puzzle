//
//  _5_puzzleTests.swift
//  15 puzzleTests
//
//  Created by Andrew Yakovenko on 11/30/18.
//  Copyright © 2018 Andrew Yakovenko. All rights reserved.
//

import XCTest
@testable import _5_puzzle

class _5_puzzleTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    
    func  testStarNewGame() {
        let game = Logic()
        
        game.startNewGame()
        
        XCTAssertTrue(game.puzzle[game.size - 1][game.size - 1] == 16)
        XCTAssertTrue(game.puzzle != game.toWinPuzzle)
        
    }
    
    func testCorectCoredineteRetorn() {
        let game = Logic()
        
        game.startNewGame()
        
        let randomNumberToCheck = Int.random(in: 1 ..< game.size * game.size)
        
        let coredinate = game.findCordinate(Cell: randomNumberToCheck)
        
        XCTAssertTrue(game.puzzle[coredinate.0][coredinate.1] == randomNumberToCheck)
        
    }
    
    
    func testEditPuzzle() {
        let game = Logic()
        game.startNewGame()
        
        
        XCTAssertFalse(game.cantPlayerMoveIt(first: game.emptyCell, second: (0, 0)))
        XCTAssertFalse(game.cantPlayerMoveIt(first: (3,2), second: (1,1)))
        XCTAssertTrue(game.cantPlayerMoveIt(first: game.emptyCell, second: (game.emptyCell.0, game.emptyCell.1 - 1)))
    }

}
