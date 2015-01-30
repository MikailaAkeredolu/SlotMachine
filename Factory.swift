//
//  Factory.swift
//  SlotMachine
//
//  Created by Mikaila Akeredolu on 1/7/15.
//  Copyright (c) 2015 MakerOfAppsDotCom. All rights reserved.
//

import Foundation
import UIKit //import this cos u go use images

class Factory  //factory design pattern - for abstracting code
{

    
//create a class function - called on factory class
    class func createSlots() -> [[Slot]]  //this will return an array of arrays holding struct instances
    {
        //we cannot access properties in a class function so we must declare its properties within the class function
        //create 9 total slots by using for loops
        
        let kNumberOfSlots = 3
        let kNumberOfContainers = 3
        
        var slots:[[Slot]] = []  //outter array
        //create an empty array of arrays that holds slot intances STRUCT Slot.swift file
        
        /*slots array will look like this:
        slots = 
        [
        [slot1| slot2| slot3],  ---- column 1
        [slot4| slot5| slot6],  ---- column 2
        [slot7| slot8| slot9]   ---- column 3
        ]
        */
        
         //mySlotArray = slot[0]
        /*mySlotArray at index 0  will be [slot1,slot2,slot3]
        
        slot = mySlotArray[1] that would give me |slot2|
        */
        
        
        //generate 3 slot array instances
        for var containerNumber = 0; containerNumber < kNumberOfContainers; ++containerNumber{
            
            var slotArray:[Slot] = []  //inner array consist of 3 slots grouped
            
            
            for var slotNumber = 0; slotNumber < kNumberOfSlots; ++slotNumber{
                
                //use the below - class func createSlot (currentCards:[Slot]) -> Slot
                var slot = Factory.createSlot(slotArray)  //create individual slot instances |slot1| & parameter = var slotArray:[Slot] = []
                
                slotArray.append(slot) //adding slot to slotArray aka inner array consist of 3 slot instances grouped
                
            }
            //add slotArray to slots declared above as property of class function
            slots.append(slotArray) //add inner arrays to outta array
            
        }
        
        
        return slots
    }
    
    //create another class function to create individual slot instances
    
    class func createSlot (currentCards:[Slot]) -> Slot
    {
        //enumerate thru slot instances passed as parameters to currentCards- get the slot value then add it to current card value array
        
        var currentCardValues:[Int] = []  //empty array that holds integers
        
        for slot in currentCards  //currentCards is parameter of func
        {
            currentCardValues.append(slot.value) //get property value of (slot.value) and add it to currentCardsValues array
        }
        
        //create random number variable
        var randomNumber = Int(arc4random_uniform(UInt32(13))) //get 0 - 12 random numbers
        
        //while contains statement has 2 parameters
        while contains(currentCardValues, randomNumber + 1)
        { //if currentCard Value contains randomNumber 0-12 add 1 to make it 1-13

            randomNumber = Int(arc4random_uniform(UInt32(13))) //generate new randomNumber to ensure does not contain same value
        }
        
        
        //Finally create slot instance - do a switch statement to generate random based upon slot instance
        
        var slot:Slot  //variable slot is of type Slot Struct
        
        switch randomNumber{ //using randomNumber variable above
            
        case 0:
            slot = Slot(value: 1, image: UIImage(named: "Ace"), isRed: true)
            
        case 1:
             slot = Slot(value: 2, image: UIImage(named: "Two"), isRed: true)
        
        case 2:
            slot = Slot(value: 3, image: UIImage(named: "Three"), isRed: true)
        
        case 3:
            slot = Slot(value: 4, image: UIImage(named: "Four"), isRed: true)
            
        case 4:
            slot = Slot(value: 5, image: UIImage(named: "Five"), isRed: false)
            
        case 5:
            slot = Slot(value: 6, image: UIImage(named: "Six"), isRed: false)
            
        case 6:
            slot = Slot(value: 7, image: UIImage(named: "Seven"), isRed: true)
            
        case 7:
            slot = Slot(value: 8, image: UIImage(named: "Eight"), isRed: false)
            
        case 8:
            slot = Slot(value: 9, image: UIImage(named: "Nine"), isRed: false)
            
        case 9:
            slot = Slot(value: 10, image: UIImage(named: "Ten"), isRed: true)
            
        case 10:
            slot = Slot(value: 11, image: UIImage(named: "Jack"), isRed: false)
            
        case 11:
            slot = Slot(value: 12, image: UIImage(named: "Queen"), isRed: false)
            
        case 12:
            slot = Slot(value: 13, image: UIImage(named: "King"), isRed: true)
            
        default:
            slot = Slot(value: 0, image: UIImage(named: "Ace"), isRed: true)
        }
        
        return slot
        
    }
    
    
}



/*this is an instance function not a class function
func createSlot(){
println("print instance function")

}
*/