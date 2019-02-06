//
//  Logic.swift
//  15 puzzle
//
//  Created by Andrew Yakovenko on 12/4/18.
//  Copyright © 2018 Andrew Yakovenko. All rights reserved.
//

import Foundation

class Logic: NSObject {
    
    public enum Directions {
        case up, down, right, left
    }
    
    public let size :Int
    
    init(_ size:Int) {
        self.size = size
    }
    
    typealias Map = [[Int]]
    typealias Coordinate = (Int, Int)
    typealias CellNumber = Int
    
    var emptyCell = (0, 0)
    var moves = 0
    
    // MARK: - Star Game logic
    
    var puzzle = Map()
    var toWinPuzzle = Map()
    
    private func puzzleSet(size:Int) -> Map {
        var puzzleNumbers = 1
        var puzzle = Array(repeating: Array(repeating: 0, count: size), count: size)
        for x in 0 ..< size {
            for y in 0 ..< size {
                puzzle[x][y] = puzzleNumbers
                puzzleNumbers += 1
            }
        }
        return puzzle
    }
    
    public func startNewGame()  {
        emptyCell = (size - 1, size - 1)
        moves = 0
        puzzle = puzzleSet(size: size)
        toWinPuzzle = puzzleSet(size: size)
        
        for _ in 0 ..< 1000 {
            let firstCell = CellNumber.random(in: 1 ..< size * size)
            let secondCell = CellNumber.random(in: 1 ..< size * size)
            
            firstCell == secondCell ? reRollRandom(firstCell: firstCell) : change(firstCell: firstCell, secondCell: secondCell)
        }
    }
    
    private func reRollRandom(firstCell:CellNumber) {
        var secondCell = firstCell
        
        while firstCell != secondCell {
            secondCell = CellNumber.random(in: 0 ..< size * size)
        }
        
        change(firstCell: firstCell, secondCell: secondCell)
    }
    
    private func change(firstCell:CellNumber , secondCell:CellNumber) {
        let firstXY = find(Cordinate: firstCell)
        let secondXY = find(Cordinate: secondCell)
        
        let second = puzzle[firstXY.0][firstXY.1]
        puzzle[firstXY.0][firstXY.1] = puzzle[secondXY.0][secondXY.1]
        puzzle[secondXY.0][secondXY.1] = second
        
    }
    
    public func gameEnd(Move Array:Map) -> Bool {
        return Array == toWinPuzzle
    }
    
    // MARK: - Check Direction
    
   public func find(Cordinate number:CellNumber) -> Coordinate {
        for x in 0 ..< size {
            for y in 0 ..< size {
                if puzzle[x][y] == number {
                    let xy = (x, y)
                    return xy
                }
            }
        }
        preconditionFailure()
    }
    

    private func checkDirection(emptyCell emptyCordinate:Coordinate , to cell:Coordinate) -> Directions? {
        guard cell.0 < size && cell.1 < size else {
            return nil
        }
        
        let directions = [(-1, 0), (0, -1), (1, 0), (0, 1)]
        
        for direction in directions {
            let xN = emptyCordinate.0 + direction.0
            let yN = emptyCordinate.1 + direction.1
            
            if (xN < 0 || xN == size || yN < 0 || yN == size) {
                continue
            }
            
            if puzzle[xN][yN] == puzzle[cell.0][cell.1] {
                switch direction {
                case (-1, 0) :
                    return Directions.left
                case (0, -1):
                    return Directions.up
                case (1, 0):
                    return Directions.right
                case (0, 1):
                    return Directions.down
                default:
                    return nil
                }
                
            }
        }
        return nil
    }
    
}
