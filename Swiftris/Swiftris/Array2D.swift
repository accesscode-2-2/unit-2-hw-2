//
//  Array2D.swift
//  Swiftris
//
//  Created by Elber Carneiro on 9/24/15.
//  Copyright © 2015 Elber Carneiro. All rights reserved.
//

/* Generic arrays in Swift are actually of type struct, not class but we need a
class in this case since class objects are passed by reference whereas structures 
are passed by value (copied). Our game logic will require a single copy of this 
data structure to persist across the entire game. */

// The parameter <T> will allow us to use any type of data
class Array2D<T> {
    
    let columns: Int
    let rows: Int

    // Here we declare the actual array. The type shows that the values are optional
    // and may in fact be nil
    var array: Array<T?>
    
    init(columns: Int, rows: Int) {
        self.columns = columns
        self.rows = rows

        // Initialize the array with the proper size
        array = Array<T?>(count: rows * columns, repeatedValue: nil)
    }
    
    // This is the method that will allow us to use subscripting on the class,
    // as if it was an array
    subscript(column: Int, row: Int) -> T? {
        get {
            return array[(row * columns) + column]
        }
        set(newValue) {
            array[(row * columns) + column] = newValue
        }
    }

}