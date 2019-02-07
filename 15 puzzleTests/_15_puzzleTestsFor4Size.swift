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
    }
    
    
    func  testStarNewGame() {
        game.startNewGame(changePuzzle: true)
        XCTAssertTrue(game.puzzle[game.size - 1][game.size - 1] == 16)
        XCTAssertTrue(game.puzzle != game.toWinPuzzle)
    }
    
    func testCorectCoredineteRetorn() {
        game.startNewGame(changePuzzle: true)
        let randomNumberToCheck = Int.random(in: 1 ..< game.size * game.size)
        let coredinate = game.find(Coordinate: randomNumberToCheck)
        
        XCTAssertTrue(game.puzzle[coredinate.0][coredinate.1] == randomNumberToCheck)
    }
    
    func testDirectionDoesntChangeLogic() {
        game.startNewGame(changePuzzle: false)
        
        XCTAssertEqual(Logic.Directions.left, game.checkDirection(emptyCell: game.emptyCell, to: game.find(Coordinate: 15), changeLogic: false))
        
        XCTAssert(game.puzzle == game.toWinPuzzle)
    }
    
}
