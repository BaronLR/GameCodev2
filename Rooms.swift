//
//  Rooms.swift
//  asdasd
//
//  Created by Student on 2015-02-06.
//  Copyright (c) 2015 Student. All rights reserved.
//

import Foundation

class Rooms
{
    var tempature = 0
    var enteredBefore = false
    var items:String
    
    init (newtemp:Int, newEnter:Bool, items:String)
    {
        self.items = items
        self.tempature = newtemp
        self.enteredBefore = newEnter
    }
}