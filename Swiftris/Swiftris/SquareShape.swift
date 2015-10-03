//
//  SquareShape.swift
//  Swiftris
//
//  Created by Elber Carneiro on 9/24/15.
//  Copyright © 2015 Elber Carneiro. All rights reserved.
//

class SquareShape: Shape {
    
    /* 

        [ 1*][ 2 ]
        [ 3 ][ 4 ]

        * marks the row/column indicator for the shape
    
        The square shape will not rotate because it it pointless to do so!
    
    */
    
    // Distance of each point from the shape's row/column indicator. Same distance in
    // every orientation
    
    override var blockRowColumnPositions: [Orientation: Array<(columnDiff: Int, rowDiff: Int)>] {
        return [
            Orientation.Zero:       [(0, 0), (1, 0), (0, 1), (1, 1)],
            Orientation.Ninety:     [(0, 0), (1, 0), (0, 1), (1, 1)],
            Orientation.OneEighty:  [(0, 0), (1, 0), (0, 1), (1, 1)],
            Orientation.TwoSeventy: [(0, 0), (1, 0), (0, 1), (1, 1)]
        ]
    }
    
    // Its bottom blocks will always be the third and fourth blocks since it does
    // not rotate
    override var bottomBlocksForOrientations: [Orientation: Array<Block>] {
        return [
            Orientation.Zero:       [blocks[ThirdBlockIdx], blocks[FourthBlockIdx]],
            Orientation.Ninety:     [blocks[ThirdBlockIdx], blocks[FourthBlockIdx]],
            Orientation.OneEighty:  [blocks[ThirdBlockIdx], blocks[FourthBlockIdx]],
            Orientation.TwoSeventy: [blocks[ThirdBlockIdx], blocks[FourthBlockIdx]]
        ]
    }
    
}
