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
        
        XCTAssertTrue(game.Puzzle[3][3] == 16)
        XCTAssertTrue(game.Puzzle != game.puzzleSet(size: 4))
        
    }
    
    
    func testEditPuzzle() {
        let game = Logic()
        game.startNewGame()
        
        game.editPuzzle(cellEmpty: game.emptyCell)
        
        XCTAssertTrue(game.Puzzle[3][3] != 16)
        XCTAssertTrue(game.Puzzle[2][3] == 16)
        XCTAssertTrue(game.Puzzle[game.emptyCell.0][game.emptyCell.1] == 16)
        
        
    }

}
