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
    
    public let size: Int
    
    init(_ size: Int) {
        self.size = size
    }
    
    typealias Map = [[Int]]
    typealias Coordinate = (Int, Int)
    typealias CellTag = Int
    
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
    
    public func preapearForNewGame()  {
        emptyCell = (size - 1, size - 1)
        moves = 0
        puzzle = puzzleSet(size: size)
        toWinPuzzle = puzzleSet(size: size)
    }
    
    public func getDataForMixUp() -> (Directions?,CellTag,Coordinate)?  {
        let directions = [(-1, 0), (0, -1), (1, 0), (0, 1)]
        var posibolMoves = [Coordinate]()
        
        for direction in directions {
            let xN = emptyCell.0 + direction.0
            let yN = emptyCell.1 + direction.1
            
            if (xN < 0 || xN == size || yN < 0 || yN == size) {
                continue
            }
        
            posibolMoves.append((xN,yN))
        }
        
        if posibolMoves.isEmpty {
            return nil
        } else {
            let moveTo = Int.random(in: 0 ..< posibolMoves.count)
            let coordinate = posibolMoves[moveTo]
            let direction = getDirection(to: posibolMoves[moveTo])
            let cellTag = puzzle[coordinate.0][coordinate.1]
            return (direction,cellTag,coordinate)
        }
    }
    
    public func gameEnd(Move Array:Map) -> Bool {
        return Array == toWinPuzzle
    }
    
    // MARK: - Check Direction and move
    
    public func find(Coordinate number:CellTag) -> Coordinate? {
        for x in 0 ..< size {
            for y in 0 ..< size {
                if puzzle[x][y] == number {
                    let xy = (x, y)
                    return xy
                }
            }
        }
        return nil
    }
    
    
    public func getDirection(to cell:Coordinate?) -> Directions? {
        guard let _ = cell, cell!.0 < size && cell!.1 < size else {
            return nil
        }
        
        
        let directions = [(-1, 0), (0, -1), (1, 0), (0, 1)]
        
        for direction in directions {
            let xN = cell!.0 + direction.0
            let yN = cell!.1 + direction.1
            
            if (xN < 0 || xN == size || yN < 0 || yN == size) {
                continue
            }
            
            if puzzle[xN][yN] == puzzle[emptyCell.0][emptyCell.1] {
                switch direction {
                case (-1, 0) :
                    return Directions.up
                case (0, -1):
                    return Directions.right
                case (1, 0):
                    return Directions.down
                case (0, 1):
                    return Directions.left
                default:
                    return nil
                }
            }
        }
        return nil
    }
    
    
    private func change(to cell:Coordinate) {
        let secondCoordinate = cell
        let empty = puzzle[emptyCell.0][emptyCell.1]
        
        puzzle[emptyCell.0][emptyCell.1] = puzzle[secondCoordinate.0][secondCoordinate.1]
        puzzle[secondCoordinate.0][secondCoordinate.1] = empty
        
        emptyCell = cell
    }
    
    public func move(cell:Coordinate?, to direction: Directions?)  {
        guard let _ = cell,
            let _ = direction else {
                return
        }
        change(to: cell!)
        moves += 1
    }
    
    
}
