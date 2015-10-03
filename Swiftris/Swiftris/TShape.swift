//
//  TShape.swift
//  Swiftris
//
//  Created by Elber Carneiro on 9/24/15.
//  Copyright © 2015 Elber Carneiro. All rights reserved.
//

class TShape: Shape {
    
    /*
    
        Orientation 0
    
              *  [ 1 ]
            [ 2 ][ 3 ][ 4 ]
    
        Orientation 90
    
              *  [ 2 ]
                 [ 3 ][ 1 ]
                 [ 4 ]
    
        Orientation 180
    
              *
            [ 4 ][ 3 ][ 2 ]
                 [ 1 ]
    
        Orientation 270
    
              *  [ 4 ]
            [ 1 ][ 3 ]
                 [ 2 ]
    
        * marks the row/column indicator for the shape

    */
    
    override var blockRowColumnPositions: [Orientation: Array<(columnDiff: Int, rowDiff: Int)>] {
        return [
            Orientation.Zero:       [(1, 0), (0, 1), (1, 1), (2, 1)],
            Orientation.Ninety:     [(2, 1), (1, 0), (1, 1), (1, 2)],
            Orientation.OneEighty:  [(1, 2), (2, 1), (1, 1), (0, 1)],
            Orientation.TwoSeventy: [(0, 1), (1, 2), (1, 1), (1, 0)]
        ]
    }
    
    override var bottomBlocksForOrientations: [Orientation: Array<Block>] {
        return [
            Orientation.Zero:       [blocks[FirstBlockIdx], blocks[SecondBlockIdx], blocks[ThirdBlockIdx]],
            Orientation.Ninety:     [blocks[FirstBlockIdx], blocks[FourthBlockIdx]],
            Orientation.OneEighty:  [blocks[FirstBlockIdx], blocks[SecondBlockIdx], blocks[FourthBlockIdx]],
            Orientation.TwoSeventy: [blocks[FirstBlockIdx], blocks[SecondBlockIdx]]
        ]
    }
    
}
