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
        game.preapearForNewGame()
    }
    
    func testpreparationForGame() {

        XCTAssertTrue(game.puzzle == game.toWinPuzzle, "Someing wrong with puzzleSet()")
        
        XCTAssertTrue(game.moves == 0, "Moves must be equal to 0")
        
        XCTAssertTrue(game.emptyCell == (game.size - 1, game.size - 1), "emptyCell not last in puzzle, it does't set corect ")
    }
    
    func testGetDataForMixUpReturnCorectVaules() {
        let data = game.getDataForMixUp()
        XCTAssertTrue(data != nil, "Data return nil!!!")
       // let direction = data!.0
        let cellTag = data!.1
        let cooredinate = data!.2
        
        XCTAssertEqual(cellTag, game.puzzle[cooredinate.0][cooredinate.1], "\(cellTag) or \(cooredinate) return wrong vaule")
        
    }
    
    func testGameEnd() {
        XCTAssertTrue(game.gameEnd(), "if testpreparationForGame is success gameEnd return wrong Bool")
        
        game.move(cell: (3,2), to: game.getDirection(to: (3,2)))
        XCTAssertFalse(game.gameEnd(), "move does't work or gameEnd Return wrong Bool")
    }
    
    func testGetCoordinateByTag() {
        let noCellAtThisCoordinate = 205
        XCTAssertNil(game.getCoordinateBy(tag: noCellAtThisCoordinate), "There aren't any cell with \(noCellAtThisCoordinate) tag, for 4Size squad")
        
        let firstTagAfterGameBegiane = 1
        
        XCTAssertTrue(getBoolForCoordinate(CoordinateOne: (0, 0), CoordinateCanBeNil:game.getCoordinateBy(tag: firstTagAfterGameBegiane)), "")
    }
    
    func testGetDirectionForBegining() {
        let firstMove = game.getCoordinateBy(tag: 12)
        let secondMove = game.getCoordinateBy(tag: 15)
        XCTAssertEqual(Logic.Directions.down, game.getDirection(to: firstMove), "")
        XCTAssertEqual(Logic.Directions.left, game.getDirection(to: secondMove), "")
        
    }
    
    
    func testMoves() {
        game.move(cell: (3, 2), to: nil)
        XCTAssertTrue(game.gameEnd(), "")
    }
    
    
    func getBoolForCoordinate(CoordinateOne:(Int, Int), CoordinateCanBeNil:(Int, Int)?) -> Bool {
        guard let _ = CoordinateCanBeNil else {
            return false
        }
        return CoordinateOne == CoordinateCanBeNil!
    }
}
