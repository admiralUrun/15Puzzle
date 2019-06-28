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
    let gameSize = 4
    
    override func setUp() {
        game = Logic(gameSize)
        game.preapearForNewGame()
    }
    
    func testPrepearForGame() {
        XCTAssertEqual(game.moves, 0)
        XCTAssertEqual(game.puzzle, game.toWinPuzzle)
        
        XCTAssertEqual(game.emptyCell.row, gameSize - 1)
        XCTAssertEqual(game.emptyCell.col, gameSize - 1)
    }
    
    func testMove() {
        game.preapearForNewGame()
        let c = Logic.Coordinate.init(row: gameSize - 2, col: gameSize - 1)
        XCTAssertEqual(game.moves, 0)
        game.move(cell: c)
        XCTAssertFalse(game.puzzle == game.toWinPuzzle)
        XCTAssertEqual(game.moves, 1)
        
        game.move(cell: c)
        XCTAssertEqual(game.moves, 2)
    }
    
    func testGameEnd() {
        game.preapearForNewGame()
        XCTAssertTrue(game.gameEnd())
        let c = Logic.Coordinate.init(row: gameSize - 2, col: gameSize - 1)
        game.move(cell: c)
        XCTAssertFalse(game.gameEnd())
    }
    
    func testGetCoordinate() {
        game.preapearForNewGame()
        let c = Logic.Coordinate.init(row: gameSize - 2, col: gameSize - 1)
        game.move(cell: c)
        
        XCTAssertFalse(theSame(f: game.getCoordinateBy(tag: 12), s: game.getCoordinateBy(tag: 16)))
        XCTAssertTrue(theSame(f: game.getCoordinateBy(tag: 12), s: game.getCoordinateBy(tag: 12)))
        
    }
    // TODO: testFor getDirection and getDirectionForShuffling
 
    private func theSame(f: Logic.Coordinate, s: Logic.Coordinate) -> Bool {
        return f.row == s.row && f.col == s.col ? true : false
    }
    
}
