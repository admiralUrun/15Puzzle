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
        let c = Logic.Coordinate.init(row: gameSize - 2, col: gameSize - 1)
        XCTAssertEqual(game.moves, 0)
        game.move(cell: c)
        XCTAssertFalse(game.puzzle == game.toWinPuzzle)
        XCTAssertEqual(game.moves, 1)
        
        game.move(cell: c)
        XCTAssertEqual(game.moves, 2)
    }
    
    func testGameEnd() {
        XCTAssertTrue(game.gameEnd())
        let c = Logic.Coordinate.init(row: gameSize - 2, col: gameSize - 1)
        game.move(cell: c)
        XCTAssertFalse(game.gameEnd())
    }
    
    func testGetCoordinate() {
        let c = Logic.Coordinate.init(row: gameSize - 2, col: gameSize - 1)
        game.move(cell: c)
        
        XCTAssertFalse(theSame(f: game.getCoordinateBy(tag: 12), s: game.getCoordinateBy(tag: 16)))
        XCTAssertTrue(theSame(f: game.getCoordinateBy(tag: 12), s: game.getCoordinateBy(tag: 12)))
        
    }
    
    func testSwapTwo() {
        XCTAssertTrue(game.gameEnd())
        
        game.swapTwo(firstCell: game.getCoordinateBy(tag: 11),
                     secondCell: game.getCoordinateBy(tag: 12))
        XCTAssertFalse(game.gameEnd(), "Swap didn't work")
        
        game.swapTwo(firstCell: game.getCoordinateBy(tag: 12),
                     secondCell: game.getCoordinateBy(tag: 11))
        XCTAssertTrue(game.gameEnd(), "Swap didn't work")
    }
    
    func testGetDirection() {
        let firstDirection = game.getDirection(to: game.getCoordinateBy(tag: 15))
        var secondDirection = game.getDirection(to: game.getCoordinateBy(tag: 15))
        XCTAssertEqual(firstDirection, secondDirection)
        
        secondDirection = game.getDirection(to: game.getCoordinateBy(tag: 12))
        XCTAssertFalse(firstDirection == secondDirection, "getDirection isn't work correctly")
    }
    
    func testGetDirectionForShuffling() {

        let randomTag = Int.random(in: 0 ..< game.size * game.size)
        let coordinate = game.getCoordinateBy(tag: randomTag)
        
        XCTAssertTrue(checkShuffleingDirection(s: game.getDirectionToShuffling(coordinate: coordinate )))
    }
 
    private func checkShuffleingDirection(s: Logic.ShuffelingSwap) -> Bool {
        switch s.frist {
        case .up:
            return s.second == .down && s.firstTag != s.secondTag ? true : false
        case .down:
            return s.second == .up && s.firstTag != s.secondTag ? true : false
        case .right:
            return s.second == .left && s.firstTag != s.secondTag ? true : false
        case .left:
            return s.second == .right && s.firstTag != s.secondTag ? true : false
        }
    }
    
    private func theSame(f: Logic.Coordinate, s: Logic.Coordinate) -> Bool {
        return f.row == s.row && f.col == s.col ? true : false
    }
    
}
