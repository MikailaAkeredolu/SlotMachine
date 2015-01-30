//
//  SlotBrain.swift
//  SlotMachine
//
//  Created by Mikaila Akeredolu on 1/29/15.
//  Copyright (c) 2015 MakerOfAppsDotCom. All rights reserved.
//

import Foundation

//responsible for checking all our slots if we have winnings

class SlotBrain
{
   
    //create a class function that takes in slost and  pass in struct Slot array of arrays returns array of arrays
    //reorganize our slots into rows
    
    class func unpackSlotsIntoSlotRows (slots:[[Slot]]) ->[[Slot]]
    {
        //create 3 arrays that hold  horizontal ---- Slot struct instances but start as empty arrays
        
        var slotRow: [Slot] = []
        var slotRow2:[Slot] = []
        var slotRow3:[Slot] = []
        
        for slotArray in slots
        {  //unpackSlotsIntoSlotRows (slots:[[Slot]]) ->[[Slot]] with fast enumeration
            
            for var index = 0; index < slotArray.count; index++ //slotArray in slots
            {
                let slot = slotArray[index] //grab the slot out of slotarray by indexing into it with the index
                if index == 0 {
                    slotRow.append(slot)
                    
                }else if index == 1
                {
                    slotRow2.append(slot)
                    
                }else if index == 2
                {
                    slotRow3.append(slot)
                }else{
                    println("erro")
                }
            }
        }
        //generate var slotinrows is array of array that has slot intstances equals to slot rows
        var slotsInRows: [[Slot]] = [slotRow,slotRow2,slotRow3]
        
        return slotsInRows
    }
    
    //COMPUTE WINNINGS
    
    class func computeWinnings(slots:[[Slot]])-> Int{ //pass in slots as parameter

        var slotInRows = unpackSlotsIntoSlotRows(slots)
        var winnings = 0
        
        var flushWinCount = 0
        var threeOfAKindWinCount = 0
        var straightWinCount = 0
        
        for slotRow in slotInRows
        {
            if checkFlush(slotRow)==true
            { //pass in flushrow
                println("flush")
                winnings += 1
                flushWinCount += 1
            }
            
            if checkThreeInRow(slotRow) == true
            {
                println("three in a row")
                winnings += 1
                straightWinCount += 1
            }
            
            if checkThreeOfAKind(slotRow) == true{
                println("three of akind")
                
                winnings += 3
                threeOfAKindWinCount += 1
                
            }
        }
        
        
        
        //
        if flushWinCount == 3{
            println("royal flush") //all 3 returns 3 or red 3 times in a rolr
            
            winnings += 15
        }
        
        if straightWinCount == 3 {
            println("epic  straight")
            winnings += 1000
            
        }
        
    
        if threeOfAKindWinCount == 3 {
            println("threes all round")
            winnings += 50
            
        }
        
        
        return winnings  //return 18 if royal flush 15 plus 3
        
        
    }
    
    
    class func checkFlush(slotRow:[Slot]) -> Bool{ //check for red and black cards
    
        let slot1 = slotRow[0]
        let slot2 = slotRow[1]
        let slot3 = slotRow[2]
        
        
        if slot1.isRed == true && slot2.isRed==true && slot3.isRed==true
        {
            return true
            
        }else if slot1.isRed == false && slot2.isRed==false && slot3.isRed==false
        {
            return true
        }else{
            
            return false
        }
        
    }
    
    
    class func checkThreeInRow (slotRow:[Slot]) -> Bool
    {
        
        let slot1 = slotRow[0] //grab slot at index0
        let slot2 = slotRow[1]
        let slot3 = slotRow[2]
        
        //check for descending 3 in a row
        if slot1.value == slot2.value - 1 && slot1.value == slot3.value - 2{
            
            return true
        }
             //check for ascending 3 in a row
        else if slot1.value == slot2.value + 1 && slot1.value == slot3.value + 2
        {
            return true
        }else{
            return false
        }
    }
    
    class func checkThreeOfAKind(slotRow: [Slot])-> Bool{
        
        let slot1 = slotRow[0] //grab slot at index0
        let slot2 = slotRow[1]
        let slot3 = slotRow[2]

        if slot1.value == slot2.value && slot1.value == slot3.value { //if they all have the same value
            return true
        }else{
            return false
        }
        
    }

}