//
//  Swiftris.swift
//  Swiftris
//
//  Created by Elber Carneiro on 9/24/15.
//  Copyright © 2015 Elber Carneiro. All rights reserved.
//

// size of the game board
let NumColumns = 10
let NumRows = 20

// where each new piece starts
let StartingColumn = 4
let StartingRow = 0

// where the preview pieces go
let PreviewColumn = 12
let PreviewRow = 1

// scoring constants
let PointsPerLine = 10
let LevelThreshold = 1000

// protocol for communication with ViewController
protocol SwiftrisDelegate {
    func gameDidEnd(swiftris: Swiftris)
    func gameDidBegin(swiftris: Swiftris)
    func gameShapeDidLand(swiftris: Swiftris)
    func gameShapeDidMove(swiftris: Swiftris)
    func gameShapeDidDrop(swiftris: Swiftris)
    func gameDidLevelUp(swiftris: Swiftris)
}

class Swiftris {
    var blockArray: Array2D<Block>
    var nextShape: Shape?
    var fallingShape: Shape?
    var delegate: SwiftrisDelegate?
    
    var score: Int
    var level: Int
    
    init() {
        score = 0
        level = 1
        
        // doesn't get a value til newShape() is called
        fallingShape = nil
        // doesn't get a value til beginGame() is called
        nextShape = nil
        blockArray = Array2D<Block>(columns: NumColumns, rows: NumRows)
    }
    
    func beginGame() {
        if nextShape == nil {
            // create a random nextShape
            nextShape = Shape.random(PreviewColumn, startingRow: PreviewRow)
        }
        delegate?.gameDidBegin(self)
    }
    
    func newShape() -> (fallingShape: Shape?, nextShape: Shape?) {
        // graduate nextShape to fallingShape
        fallingShape = nextShape
        
        // get a new nextShape
        nextShape = Shape.random(PreviewColumn, startingRow: PreviewRow)
        
        // position fallingShape at the starting position
        fallingShape?.moveTo(StartingColumn, row: StartingRow)
        
        // if a new shape at the starting position collides with existing blocks
        // the player is out of room and the game is over.
        if detectIllegalPlacement() {
            nextShape = fallingShape
            nextShape!.moveTo(PreviewColumn, row: PreviewRow)
            endGame()
            return (nil, nil)
        }
        
        return (fallingShape, nextShape)
    }
    
    func detectIllegalPlacement() -> Bool {
        if let shape = fallingShape {
            for block in shape.blocks {
                // Is the block position outside the legal boundaries?
                if block.column < 0 || block.column >= NumColumns || block.row < 0 || block.row >= NumRows {
                    return true
                // does the block ovelap an existing block?
                } else if blockArray[block.column, block.row] != nil {
                    return true
                }
            }
        }
        return false
    }
    
    func settleShape() {
        if let shape = fallingShape {
            // add our shape blocks to the blocks array
            for block in shape.blocks {
                blockArray[block.column, block.row] = block
            }
            // nullify fallingShape
            fallingShape = nil
            delegate?.gameShapeDidLand(self)
        }
    }
    
    // detects when bottom blocks touch other blocks or the bottom of the game board
    func detectTouch() -> Bool {
        if let shape = fallingShape {
            for bottomBlock in shape.bottomBlocks {
                if bottomBlock.row == NumRows - 1 || blockArray[bottomBlock.column, bottomBlock.row + 1] != nil {
                    return true
                }
            }
        }
        return false
    }
    
    func endGame() {
        score = 0
        level = 1
        delegate?.gameDidEnd(self)
    }
    
    func removeCompletedLines() -> (linesRemoved: Array<Array<Block>>, fallenBlocks: Array<Array<Block>>) {
        var removedLines = Array<Array<Block>>()
        for var row = NumRows - 1; row > 0; row-- {
            var rowOfBlocks = Array<Block>()
            
            for column in 0..<NumColumns {
                if let block = blockArray[column, row] {
                    rowOfBlocks.append(block)
                }
            }
            
            // if the row is completely full
            if rowOfBlocks.count == NumColumns {
                // transfer this row to removed lines
                removedLines.append(rowOfBlocks)
                // make row of blocks empty again
                for block in rowOfBlocks {
                    blockArray[block.column, block.row] = nil
                }
            }
        }
        
        // if we did not have any removed lines, return an empty array immediately
        if removedLines.count == 0 {
            return ([], [])
        }
        
        // otherwise, let's go ahead and figure out the points
        let pointsEarned = removedLines.count * PointsPerLine * level
        score += pointsEarned
        if score >= level * LevelThreshold {
            ++level
            delegate?.gameDidLevelUp(self)
        }
        
        // lower all the blocks that were a above the removed lines, as much 
        // as possible
        var fallenBlocks = Array<Array<Block>>()
        for column in 0 ..< NumColumns {
            var fallenBlocksArray = Array<Block>()
            
            for var row = removedLines[0][0].row - 1; row > 0; row-- {
                if let block = blockArray[column, row] {
                    var newRow = row
                    while (newRow < NumRows - 1 && blockArray[column, newRow + 1] == nil) {
                        ++newRow
                    }
                    block.row = newRow
                    blockArray[column, row] = nil
                    blockArray[column, newRow] = block
                    fallenBlocksArray.append(block)
                }
            }
            if fallenBlocksArray.count > 0 {
                fallenBlocks.append(fallenBlocksArray)
            }
        }
        return (removedLines, fallenBlocks)
    }
    
    // makes blocks in all positions on the board nil, emptying the board of blocks
    func removeAllBlocks() -> Array<Array<Block>> {
        var allBlocks = Array<Array<Block>>()
        for row in 0..<NumRows {
            var rowOfBlocks = Array<Block>()
            for column in 0..<NumColumns {
                if let block = blockArray[column, row] {
                    rowOfBlocks.append(block)
                    blockArray[column, row] = nil
                }
            }
            allBlocks.append(rowOfBlocks)
        }
        return allBlocks
    }
    
    func dropShape() {
        
        /* Note: "if let" is used for conditional assignment. Basically, do something
            if this new constant has a value, otherwise if it's nil do something else.
            An alternate, if more exotic way to accomplish something similar, with 
            the emphasis on the nil case is the "guard" statement. It might be useful
            if the first block of an "if let" is really long and you have to scroll a 
            ways before you can find the else nil condition block. "guard" reverses things
            putting the nil condition up front, in a block, and the code to execute
            otherwise is then everything further down outside the block (outside the 
            scope of the guard statement... so weird). See documentation */
        
        if let shape = fallingShape {
            while detectIllegalPlacement() == false {
                shape.lowerShapeByOneRow()
            }
            shape.raiseShapeByOneRow()
            delegate?.gameShapeDidDrop(self)
        }
    }
    
    func letShapeFall() {
        if let shape = fallingShape {
            shape.lowerShapeByOneRow()
            if detectIllegalPlacement() {
                shape.raiseShapeByOneRow()
                if detectIllegalPlacement() {
                    endGame()
                } else {
                    settleShape()
                }
            } else {
                delegate?.gameShapeDidMove(self)
                if detectTouch() {
                    settleShape()
                }
            }
        }
    }
    
    func rotateShape() {
        if let shape = fallingShape {
            shape.rotateClockwise()
            if detectIllegalPlacement() {
                shape.rotateCounterClockwise()
            } else {
                delegate?.gameShapeDidMove(self)
            }
        }
    }
    
    func moveShapeLeft() {
        if let shape = fallingShape {
            shape.shiftLeftByOneColumn()
            if detectIllegalPlacement() {
                shape.shiftRightByOneColumn()
                return
            }
            delegate?.gameShapeDidMove(self)
        }
    }
    
    func moveShapeRight() {
        if let shape = fallingShape {
            shape.shiftRightByOneColumn()
            if detectIllegalPlacement() {
                shape.shiftLeftByOneColumn()
                return
            }
            delegate?.gameShapeDidMove(self)
        }
    }

}