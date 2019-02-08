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
        
        if let coredinate = game.find(Coordinate: randomNumberToCheck) {
            XCTAssertTrue(game.puzzle[coredinate.0][coredinate.1] == randomNumberToCheck)
        }
    }
    
    func testDirectionDoesntChangeLogic() {
        game.startNewGame(changePuzzle: false)
        
        XCTAssertEqual(Logic.Directions.left, game.getDirection(to: game.find(Coordinate: 15)))
        
        XCTAssert(game.puzzle == game.toWinPuzzle)
    }
    // MARK: - DirectonTests
    func testDirectonReturnCorectVaule() {
        game.startNewGame(changePuzzle: false)
        
        XCTAssertNil(game.getDirection(to: game.find(Coordinate: 1)))
        XCTAssertNil(game.getDirection(to: game.find(Coordinate: 5)))
        XCTAssertNil(game.getDirection(to: game.find(Coordinate: 14)))
        XCTAssertNil(game.getDirection(to: game.find(Coordinate: 1000)))
        
        
        XCTAssertEqual(Logic.Directions.down, game.getDirection(to: game.find(Coordinate: 12)))
        XCTAssertEqual(Logic.Directions.left, game.getDirection(to: game.find(Coordinate: 15)))
    }
    
    func testMoveInChangePuzzle() {
        game.startNewGame(changePuzzle: false)
  
    }
    
    
}
