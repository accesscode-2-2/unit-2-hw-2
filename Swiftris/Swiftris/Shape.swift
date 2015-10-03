//
//  Shape.swift
//  Swiftris
//
//  Created by Elber Carneiro on 9/24/15.
//  Copyright © 2015 Elber Carneiro. All rights reserved.
//

import SpriteKit

// MARK: Constants

let NumOrientations: UInt32 = 4

enum Orientation: Int, CustomStringConvertible {
    case Zero = 0, Ninety, OneEighty, TwoSeventy
    
    var description: String {
        switch self {
        case .Zero:
            return "0"
        case .Ninety:
            return "90"
        case .OneEighty:
            return "180"
        case .TwoSeventy:
            return "270"
        }
    }
    
    static func random() -> Orientation {
        return Orientation(rawValue: Int(arc4random_uniform(NumOrientations)))!
    }
    
    // returns the next orientation depending on whether the block is traveling 
    // clockwise or counter-clockwise
    static func rotate(orientation: Orientation, clockwise: Bool) -> Orientation {
        var rotated = orientation.rawValue + (clockwise ? 1 : -1)
        
        // if rotated is greater than 270, it should be converted to 0
        if rotated > Orientation.TwoSeventy.rawValue {
            rotated = Orientation.Zero.rawValue
        }
        
        return Orientation(rawValue: rotated)!
    }
}

let NumShapeTypes: UInt32 = 7

// shape indexes
let FirstBlockIdx: Int = 0
let SecondBlockIdx: Int = 1
let ThirdBlockIdx: Int = 2
let FourthBlockIdx: Int = 3

// MARK: Class definition

class Shape: Hashable, CustomStringConvertible {
    // we want all shapes to have the same color across all their blocks
    let color: BlockColor
    
    var blocks = Array<Block>()
    var orientation: Orientation
    var column, row: Int
    
    // MARK: Properties to override
    
    // subclasses must override this Dictionary computed property. The values in this
    // dictionary are of type Array of type tuples
    var blockRowColumnPositions: [Orientation: Array<(columnDiff: Int, rowDiff: Int)>] {
        return [:]
    }
    
    // subclasses must override this as well
    var bottomBlocksForOrientations: [Orientation: Array<Block>] {
        return [:]
    }
    
    // this and the above property are going to be used to define shape behavior
    // when the bottom blocks come into contact with other schtuff
    var bottomBlocks: Array<Block> {
        if let bottomBlocks = bottomBlocksForOrientations[orientation] {
            return bottomBlocks
        }
        return []
    }
    
    // MARK: Hashable implementation
    
    var hashValue: Int {
        // iterates through the blocks array to take into consideration each
        // block and then return a unique hash value for the whole shape
        return blocks.reduce(0) { $0.hashValue ^ $1.hashValue }
    }
    
    // MARK: CustomStringConvertible implementation
    
    var description: String {
        return "\(color) block facing \(orientation): \(blocks[FirstBlockIdx]), \(blocks[SecondBlockIdx]), \(blocks[ThirdBlockIdx]), \(blocks[FourthBlockIdx])"
    }
    
    // MARK: Constructors
    
    init (column: Int, row: Int, color: BlockColor, orientation:Orientation) {
        self.color = color
        self.column = column
        self.row = row
        self.orientation = orientation
        initializeBlocks()
    }
    
    convenience init (column: Int, row: Int) {
        self.init(column: column, row: row, color:BlockColor.random(), orientation:Orientation.random())
    }
    
    // the keyword final means this function cannot be overriden by subclasses of Shape
    final func initializeBlocks() {
        if let blockRowColumnTranslations = blockRowColumnPositions[orientation] {
            for i in 0 ..< blockRowColumnTranslations.count {
                let blockRow = row + blockRowColumnTranslations[i].rowDiff
                let blockColumn = column + blockRowColumnTranslations[i].columnDiff
                let newBlock = Block(column: blockColumn, row: blockRow, color: color)
                blocks.append(newBlock)
            }
        }
    }
    
    // MARK: Movement methods
    
    final func rotateBlocks(orientation: Orientation) {
        
        // use the blockRowColumnPositions of the shape to start our translation
        if let blockRowColumnTranslation: Array<(columnDiff: Int, rowDiff: Int)> = blockRowColumnPositions[orientation] {
            
            // the enumerate() method allows us to easily iterate through blockRowColumnTranslation
            // it returns indexes and values
            for (idx, diff) in blockRowColumnTranslation.enumerate() {
                
                // add our translation numbers to the original block positions
                blocks[idx].column = column + diff.columnDiff
                blocks[idx].row = row + diff.rowDiff
            }
        }
    }
    
    final func rotateClockwise() {
        let newOrientation = Orientation.rotate(orientation, clockwise: true)
        rotateBlocks(newOrientation)
        orientation = newOrientation
    }
    
    final func rotateCounterClockwise() {
        let newOrientation = Orientation.rotate(orientation, clockwise: false)
        rotateBlocks(newOrientation)
        orientation = newOrientation
    }
    
    final func lowerShapeByOneRow() {
        shiftBy(0, rows: 1)
    }
    
    final func raiseShapeByOneRow() {
        shiftBy(0, rows: -1)
    }
    
    final func shiftRightByOneColumn() {
        shiftBy(1, rows: 0)
    }
    
    final func shiftLeftByOneColumn() {
        shiftBy(-1, rows: 0)
    }
    
    // shifts the position of the blocks
    final func shiftBy(columns: Int, rows: Int) {
        self.column += columns
        self.row += rows
        for block in blocks {
            block.column += columns
            block.row += rows
        }
    }
    
    // overrides the position of the blocks completely
    final func moveTo(column: Int, row: Int) {
        self.column = column
        self.row = row
        rotateBlocks(orientation)
    }
    
    // MARK: Method to return random shape
    
    final class func random(startingColumn: Int, startingRow: Int) -> Shape {
        switch Int(arc4random_uniform(NumShapeTypes)) {
        case 0:
            return SquareShape(column: startingColumn, row: startingRow)
        case 1:
            return LineShape(column: startingColumn, row: startingRow)
        case 2:
            return TShape(column: startingColumn, row: startingRow)
        case 3:
            return LShape(column: startingColumn, row: startingRow)
        case 4:
            return JShape(column: startingColumn, row: startingRow)
        case 5:
            return SShape(column: startingColumn, row: startingRow)
        default:
            return ZShape(column: startingColumn, row: startingRow)
        }
    }
}

// MARK: Equatable implementation

func ==(lhs: Shape, rhs: Shape) -> Bool {
    return lhs.row == rhs.row && lhs.column == rhs.column
}