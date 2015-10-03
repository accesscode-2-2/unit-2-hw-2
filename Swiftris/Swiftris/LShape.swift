//
//  LShape.swift
//  Swiftris
//
//  Created by Elber Carneiro on 9/24/15.
//  Copyright © 2015 Elber Carneiro. All rights reserved.
//

class LShape: Shape {
 
    /*
    
    Orientation 0
    
             [ 1*]
             [ 2 ]
             [ 3 ][ 4 ]
    
    Orientation 90
    
                *
        [ 3 ][ 2 ][ 1 ]
        [ 4 ]
    
    Orientation 180
    
        [ 4 ][ 3*]
             [ 2 ]
             [ 1 ]
    
    Orientation 270
    
                * [ 4 ]
        [ 1 ][ 2 ][ 3 ]
    
    * marks the row/column indicator for the shape
    
    */
    
    override var blockRowColumnPositions: [Orientation: Array<(columnDiff: Int, rowDiff: Int)>] {
        return [
            Orientation.Zero:       [( 0, 0), (0, 1), ( 0, 2), ( 1, 2)],
            Orientation.Ninety:     [( 1, 1), (0, 1), (-1, 1), (-1, 2)],
            Orientation.OneEighty:  [( 0, 2), (0, 1), ( 0, 0), (-1, 0)],
            Orientation.TwoSeventy: [(-1, 1), (0, 1), ( 1, 1), ( 1, 0)]
        ]
    }
    
    override var bottomBlocksForOrientations: [Orientation: Array<Block>] {
        return [
            Orientation.Zero:       [blocks[ThirdBlockIdx], blocks[FourthBlockIdx]],
            Orientation.Ninety:     [blocks[FirstBlockIdx], blocks[SecondBlockIdx], blocks[FourthBlockIdx]],
            Orientation.OneEighty:  [blocks[FirstBlockIdx], blocks[FourthBlockIdx]],
            Orientation.TwoSeventy: [blocks[FirstBlockIdx], blocks[SecondBlockIdx], blocks[ThirdBlockIdx]]
        ]
    }
}
