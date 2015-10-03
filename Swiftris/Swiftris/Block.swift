//
//  Block.swift
//  Swiftris
//
//  Created by Elber Carneiro on 9/24/15.
//  Copyright © 2015 Elber Carneiro. All rights reserved.
//

import SpriteKit

// MARK: Random color generation

// constant. Although the Swift docs recommend using Int even for unsigned
// integers, we use UInt32 here for some reason :)
let NumberOfColors: UInt32 = 6

// CustomStringConvertible is the protocol you have to implement to make
// something "printable"
enum BlockColor: Int, CustomStringConvertible {
    
    // define the enumerable options starting at index 0
    case Blue = 0, Orange, Purple, Red, Teal, Yellow
    
    // this is a "computed property": a code block must run first before
    // it returns a value
    var spriteName: String {
        switch self {
        case .Blue:
            return "blue"
        case .Orange:
            return "orange"
        case .Purple:
            return "purple"
        case .Red:
            return "red"
        case .Teal:
            return "teal"
        case .Yellow:
            return "yellow"
        }
    }
    
    // this is another computed property. This is the one we must write to implement
    // CustomStringConvertible
    var description: String {
        return self.spriteName
    }
    
    static func random() -> BlockColor {
        // use random number from 0 through 5 to choose a random color from our
        // enum
        return BlockColor(rawValue: Int(arc4random_uniform(NumberOfColors)))!
    }
}


//MARK: Class definition

// Hashable allows us to store Block as a key in a Dictionary
class Block: Hashable, CustomStringConvertible {
    
    // constant. We do not ever want a block to change colors
    let color: BlockColor
    
    // properties
    var column: Int
    var row: Int
    var sprite: SKSpriteNode? // visual element the scene will use to draw our block
    
    // convenience property to shorten our path to spriteName when we call it
    var spriteName: String {
        return color.spriteName
    }
    
    // Implementation of the HASHABLE protocol. Equal items must return the same
    // hashValue. This is the whole point of Dictionaries! See our EQUATABLE implementation
    // below.
    var hashValue: Int {
        return self.column ^ self.row
    }
    
    // Implementation of ex-PRINTABLE protocol (now CustomStringConvertible)
    var description: String {
        return "\(color): [\(column), \(row)]"
    }
    
    init(column: Int, row: Int, color:BlockColor) {
        self.column = column
        self.row = row
        self.color = color
    }
}

// This is the implementation of the EQUATABLE protocol
// it will return true if the position of the block and the color are the same, regardless
// of whether or not the items being compared are different instances of Block.
// For our purposes, this is what we need and screw the existential dilemmas
// of Platonic thinking.
func ==(lhs: Block, rhs: Block) -> Bool {
    return lhs.column == rhs.column && lhs.row == rhs.row && lhs.color.rawValue == rhs.color.rawValue
}

