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
        
        XCTAssertTrue(game.puzzle[3][3] == 16)
        XCTAssertTrue(game.puzzle != game.puzzleSet(size: 4))
        
    }
    
    
    func testEditPuzzle() {
        let game = Logic()
        game.startNewGame()
        
        game.editPuzzle(cellEmpty: game.emptyCell)
        
        XCTAssertTrue(game.puzzle[3][3] != 16)
        XCTAssertTrue(game.puzzle[2][3] == 16)
        XCTAssertTrue(game.puzzle[game.emptyCell.0][game.emptyCell.1] == 16)
        
        
    }

}
