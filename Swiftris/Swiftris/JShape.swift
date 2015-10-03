//
//  JShape.swift
//  Swiftris
//
//  Created by Elber Carneiro on 9/24/15.
//  Copyright © 2015 Elber Carneiro. All rights reserved.
//

class JShape: Shape {
    
    /*
    
    Orientation 0
    
          * [ 1 ]
            [ 2 ]
       [ 4 ][ 3 ]
    
    Orientation 90
    
       [ 4*]
       [ 3 ][ 2 ][ 1 ]
    
    Orientation 180
    
       [ 3*][ 4 ]
       [ 2 ]
       [ 1 ]
    
    Orientation 270
    
       [ 1*][ 2 ][ 3 ]
                 [ 4 ]
    
    * marks the row/column indicator for the shape
    
    */
    
    override var blockRowColumnPositions: [Orientation: Array<(columnDiff: Int, rowDiff: Int)>] {
        return [
            Orientation.Zero:       [(1, 0), (1, 1), (1, 2), (0, 2)],
            Orientation.Ninety:     [(2, 1), (1, 1), (0, 1), (0, 0)],
            Orientation.OneEighty:  [(0, 2), (0, 1), (0, 0), (1, 0)],
            Orientation.TwoSeventy: [(0, 0), (1, 0), (2, 0), (2, 1)]
        ]
    }
    
    override var bottomBlocksForOrientations: [Orientation: Array<Block>] {
        return [
            Orientation.Zero:       [blocks[ThirdBlockIdx], blocks[FourthBlockIdx]],
            Orientation.Ninety:     [blocks[FirstBlockIdx], blocks[SecondBlockIdx], blocks[ThirdBlockIdx]],
            Orientation.OneEighty:  [blocks[FirstBlockIdx], blocks[FourthBlockIdx]],
            Orientation.TwoSeventy: [blocks[FirstBlockIdx], blocks[SecondBlockIdx], blocks[FourthBlockIdx]]
        ]
    }
}
