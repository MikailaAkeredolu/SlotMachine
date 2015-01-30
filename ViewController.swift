//
//  ViewController.swift
//  SlotMachine
//
//  Created by Mikaila Akeredolu on 12/29/14.
//  Copyright (c) 2014 MakerOfAppsDotCom. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

   //add proerties/containers
    
        var firstContainer: UIView! //creating first container to load everytime view loads
        var secondContainer: UIView!
        var thirdContainer: UIView!
        var fourthContainer: UIView!
   
    
    //create a couple of kconstants that are global to this entire class
     //CGFloat type could be double or float k stands for constant
    
    let kMarginforView:CGFloat = 10.0 //10 points left and right of view
    
    let kMarginForSlot:CGFloat = 2.0 // thick border line |
    
    let kSixth:CGFloat = 1.0/6.0
    
    let kThird:CGFloat = 1.0/3.0
    
    
    //FOR BUTTONS
    
    let kHalf:CGFloat = 1.0/2.0
    
    let kEight:CGFloat = 1.0/8.0
    
    
    //declare property - create slot instances using Factory for secondContainer
    var slots:[[Slot]] = [] //empty array of arrays then go down to spin button func
    
    
    //STATS for credits,bets and winnings
    var credits = 0
    var currentBet = 0
    var winnings = 0
    
    //INFORMATION LABELS - add 6 differnt labels
    var titleLabel: UILabel! //property for first conatiner label
    
    var creditsLabel: UILabel!
    var betLabel: UILabel!
    var winnerPaidlabel: UILabel!
    
    var creditsTitleLabel: UILabel!
    var betTitleLabel: UILabel!
    var winnerPaidTitleLabel: UILabel!
    
    //BUTTONS FOR FOURTH CONTAINER
    var resetButton: UIButton!
    var betOneButton:UIButton!
    var betMaxButton:UIButton!
    var spinButton:UIButton!
    

    
    //FOR SECOND CONTAINER image views
    let kNumberOfContainers = 3 //number of columns
    let kNumberOfSlots = 3 //number of rows
    
    //VIEW DID LOAD
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // call the set up container view functions below
        
        setUpContainerViews()
        
        setUpFirstContainer(self.firstContainer)
        
        //setUpSecondContainer(self.secondContainer)
        
        setupThirdContainer(self.thirdContainer)
        
        setupFourthContainer(self.fourthContainer)
        
        
        hardReset()  //call hard reset - it will set up second container too
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //IBACTIONS -
    func resetButtonPressed(button:UIButton)
    {
        hardReset()
        
    }

    
    func betOneButtonPressed(button:UIButton)
    {
        if credits <= 0 //
        {
            showAlertWithText(header: "No more Credits", message: "Reset Game")
            
        }else
        {
            if currentBet < 5
            {
                currentBet += 1 //increase current bet by 1
                
                credits -= 1 //remove 1 credit from thier existing credit
                
                updateMainView() //update labels
                
        }else{
                showAlertWithText(message: "You can only bet 5 credits at a time! ")
             }
        }
        
    }
    
    
    func betmaxButtonPressed(button:UIButton){
       //increase the bet to 5
        
        if credits <= 5{
            showAlertWithText(header: "Not enough Credits", message: "Bet Less")
        }
        else{
            if currentBet < 5{ //lets say this is 3
            var creditsToBetMax = 5 - currentBet // 5-3 = 2
            credits -= creditsToBetMax //subtracts  2 credits
            currentBet += creditsToBetMax //add 2 credits to their current bet
            updateMainView()
            
        }
                //if credit is equal or greater than 5
        else{
            self.showAlertWithText(message: "you can only bet 5 credits at a time")
        }
    }
}
    
    func spinButtonPressed(button:UIButton)
    {
    
        //call function from below to remove old images before setting up second container again
        removeSlotImageViews()
        

        //each time u press spin bubitfounttton generate new set of slots from factory
        
        slots = Factory.createSlots() // var slots:[[Slot]] = [] from above globall variable
        
        setUpSecondContainer(self.secondContainer) //generate new set of imageviews by updating second container
        
        
        //implement Slotbrain
        
        var winningsMultiplier = SlotBrain.computeWinnings(slots)
        
        //update winnings
        
        winnings = winningsMultiplier * currentBet
        credits += winnings
        currentBet = 0
        
        updateMainView()
        
    }
    
    
    
    
    //set up main CONTAINER VIEWS - helper method
    
    func setUpContainerViews()
    {
        
    //specify with & height  & x,y coordinates
        
        self.firstContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x + kMarginforView, y: self.view.bounds.origin.y, width: self.view.bounds.width - (kMarginforView * 2), height: self.view.bounds.height * kSixth))
        self.firstContainer.backgroundColor = UIColor.redColor()
        self.view.addSubview(self.firstContainer) //add a subview to a current view
        

        self.secondContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x + kMarginforView , y: firstContainer.frame.height, width: self.view.bounds.width - (kMarginforView * 2), height: self.view.bounds.height * (3 * kSixth)))
        self.secondContainer.backgroundColor = UIColor.blackColor()
        self.view.addSubview(self.secondContainer)
        
        self.thirdContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x + kMarginforView, y:firstContainer.frame.height + secondContainer.frame.height, width: self.view.bounds.width - (kMarginforView * 2), height: self.view.bounds.height  * kSixth))
        self.thirdContainer.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(self.thirdContainer)
        
        self.fourthContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x + kMarginforView, y: firstContainer.frame.height + secondContainer.frame.height + thirdContainer.frame.height, width: self.view.bounds.width - (kMarginforView * 2), height: self.view.bounds.height * kSixth))
        self.fourthContainer.backgroundColor = UIColor.blackColor()
        self.view.addSubview(self.fourthContainer)
        
        
    }
    
    func setUpFirstContainer(containerView:UIView)
    {
        self.titleLabel = UILabel() //initializing label property - var titleLabel: UILabel!
        self.titleLabel.text = "super slots"
        self.titleLabel.textColor = UIColor.yellowColor()
        self.titleLabel.font = UIFont(name: "MarkerFelt-Wide", size: 40)
        self.titleLabel.sizeToFit() //automatically size the width and height for font
        self.titleLabel.center = containerView.center // center the title label according to the superview
        containerView.addSubview(self.titleLabel) //add to container view as sub view
        
    }
    
    //CREATE 3 ROWS ANS 3 COLUMN INSIDE SECOND CONTAINER VIEW
    func setUpSecondContainer(containerView:UIView)
    {
        //create for loop using number of containers constant -- [slot1| slot2| slot3] --containernumber1
        for var containerNumber = 0; containerNumber < kNumberOfContainers;  ++containerNumber //will run 3 times to generate containers/columns
        {
            for var slotNumber = 0; slotNumber < kNumberOfSlots; ++slotNumber //will run 3 times to generate 3 indv slots |slot1|in a [container]
            {
                
                //generate new ui image views
                
                var slot:Slot //create a slot instance of type Slot struct
                
                var slotImageView = UIImageView() //generate local uiimage view instance
                
                if slots.count != 0  //  var slots:[[Slot]] = [] --this is the slots array glbvr
                {
                    let slotContainer = slots[containerNumber] //is this colum 1, 2 or 3 [slot1| slot2| slot3] --containernumber1
                    
                    slot = slotContainer[slotNumber] //check individual slot |slot1| within array of slots column 
                    
                    slotImageView.image = slot.image //update slot image from factory
                    //case 0:
                    //slot = Slot(value: 1, image: UIImage(named: "Ace"), isRed: true)
                    
                }
                else
                {
                    slotImageView.image = UIImage(named: "Ace")
                    
                }
                
                slotImageView.backgroundColor = UIColor.yellowColor()
                
                //create frames for image views
                slotImageView.frame = CGRect(x: containerView.bounds.origin.x + (containerView.bounds.size.width * CGFloat(containerNumber) * kThird), y: containerView.bounds.origin.y + (containerView.bounds.size.height * CGFloat (slotNumber) * kThird), width: containerView.bounds.width * kThird - kMarginForSlot, height: containerView.bounds.height * kThird - kMarginForSlot)
               
                //add subview
                containerView.addSubview(slotImageView)
                
            }
        }
        
        
    }
    
    
    func setupThirdContainer(containerView:UIView)
    {
        //set up credits label
        self.creditsLabel = UILabel() //initialize -  var creditsLabel: UILabel!
        self.creditsLabel.text = "000000"
        self.creditsLabel.textColor = UIColor.redColor()
        self.creditsLabel.font = UIFont(name: "Menlo-Bold", size: 16)
        self.creditsLabel.sizeToFit()
        self.creditsLabel.center = CGPoint(x: containerView.frame.width * kSixth, y: containerView.frame.height * kThird)
        self.creditsLabel.textAlignment = NSTextAlignment.Center
        self.creditsLabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(self.creditsLabel)
        
        //set up bet
        self.betLabel = UILabel()
        self.betLabel.text = "0000"
        self.betLabel.textColor = UIColor.redColor()
        self.betLabel.font = UIFont(name: "Menlo-Bold", size: 16)
        self.betLabel.sizeToFit()
        self.betLabel.center = CGPoint(x: containerView.frame.width * kSixth * 3, y: containerView.frame.height * kThird)
        self.betLabel.textAlignment = NSTextAlignment.Center
        self.betLabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(self.betLabel)
        
        self.winnerPaidlabel = UILabel()
        self.winnerPaidlabel.text = "000000"
        self.winnerPaidlabel.textColor = UIColor.redColor()
        self.winnerPaidlabel.font = UIFont(name: "Menlo-Bold", size: 16)
        self.winnerPaidlabel.sizeToFit()
        self.winnerPaidlabel.center = CGPoint(x: containerView.frame.width * kSixth * 5, y: containerView.frame.height * kThird)
        self.winnerPaidlabel.textAlignment = NSTextAlignment.Center
        self.winnerPaidlabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(self.winnerPaidlabel)
        
        
        self.creditsTitleLabel = UILabel()
        self.creditsTitleLabel.text = "Credits"
        self.creditsTitleLabel.textColor = UIColor.blackColor()
        self.creditsTitleLabel.font = UIFont(name: "AmericanTypewriter", size: 14)
        self.creditsTitleLabel.sizeToFit()
        self.creditsTitleLabel.center = CGPoint(x: containerView.frame.width * kSixth, y: containerView.frame.height * kThird * 2)
        self.creditsTitleLabel.textAlignment = NSTextAlignment.Center
       containerView.addSubview(self.creditsTitleLabel)
        
        self.betTitleLabel = UILabel()
        self.betTitleLabel.text = "Bet"
        self.betTitleLabel.textColor = UIColor.blackColor()
        self.betTitleLabel.font = UIFont(name: "AmericanTypewriter", size: 14)
        self.betTitleLabel.sizeToFit()
        self.betTitleLabel.center = CGPoint(x: containerView.frame.width
             * kSixth * 3, y: containerView.frame.height * kThird * 2)
      containerView.addSubview(self.betTitleLabel)
        
        self.winnerPaidTitleLabel = UILabel()
        self.winnerPaidTitleLabel.text = "Winner Paid"
        self.winnerPaidTitleLabel.textColor = UIColor.blackColor()
        self.winnerPaidTitleLabel.font = UIFont(name: "AmericanTypewriter", size: 14)
        self.winnerPaidTitleLabel.sizeToFit()
        self.winnerPaidTitleLabel.center = CGPoint(x: containerView.frame.width
            * 5 * kSixth, y: containerView.frame.height * 2 * kThird)
        containerView.addSubview(self.winnerPaidTitleLabel)
        
    }
    
    //creating buttons in code
    
    func setupFourthContainer(containerView:UIView)
    {
        //  var resetButton: UIButton!
        self.resetButton = UIButton() //initialize buttons
        self.resetButton.setTitle("Reset", forState: UIControlState.Normal)
        self.resetButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.resetButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        self.resetButton.backgroundColor = UIColor.lightGrayColor()
        self.resetButton.sizeToFit()
        self.resetButton.center = CGPoint(x: containerView.frame.width * kEight, y: containerView.frame.height * kHalf)
        //set target and action
        self.resetButton.addTarget(self, action: "resetButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        //create function called - resetButtonPressed above
        
        containerView.addSubview(self.resetButton)         //add subview
        
        
        self.betOneButton = UIButton()
        self.betOneButton.setTitle("Bet One", forState: UIControlState.Normal)
        self.betOneButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.betOneButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        self.betOneButton.backgroundColor = UIColor.greenColor()
        self.betOneButton.sizeToFit()
        self.betOneButton.center = CGPoint(x: containerView.frame.width * 3 * kEight, y: containerView.frame.height * kHalf)
        self.betOneButton.addTarget(self, action: "betOneButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        containerView.addSubview(self.betOneButton)
        
        self.betMaxButton = UIButton()
        self.betMaxButton.setTitle("Bet Max", forState: UIControlState.Normal)
        self.betMaxButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.betMaxButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        self.betMaxButton.backgroundColor = UIColor.redColor()
        self.betMaxButton.sizeToFit()
        self.betMaxButton.center = CGPoint(x: containerView.frame.width * 5 * kEight, y: containerView.frame.height * kHalf)
        self.betMaxButton.addTarget(self, action: "betmaxButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.betMaxButton)
        
        self.spinButton = UIButton()
        self.spinButton.setTitle("Spin Button", forState: UIControlState.Normal)
        self.spinButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.spinButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        self.spinButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        self.spinButton.backgroundColor = UIColor.greenColor()
        self.spinButton.sizeToFit()
        self.spinButton.center = CGPoint(x: containerView.frame.width * 7 * kEight , y: containerView.frame.height * kHalf)
        self.spinButton.addTarget(self, action: "spinButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        containerView.addSubview(self.spinButton)         //add subview
        
    }
    
    //remove old images
    func removeSlotImageViews()
    {
        if self.secondContainer != nil
        {
            let container:UIView? = self.secondContainer //an optional -- UIView?
            
            //add subviews to optional array if not empty
            let subViews:Array? = container!.subviews //unwrap container
            
            //fast enumeration
            for view in subViews!{ //unwrap subViews!
                
                view.removeFromSuperview() //remove all subviews or images from second container
            }
            
            
        }
        
    }
    
    //reset game
    
    func hardReset()
    {
        removeSlotImageViews() //remove all the image views
        
        slots.removeAll(keepCapacity: true) //keeping memory available to us cos we will add same amount of slots
        
        self.setUpSecondContainer(secondContainer) //set up second cointainer
        
        credits = 50 //give customer 50 credits
        winnings = 0
        currentBet = 0
        
        updateMainView() //making changes to credits,winnings and bets
        
    }
    
    //update the 3 labels
    
    func updateMainView(){
        //do some string interopolation
        
        self.creditsLabel.text = "\(credits)"
        self.betLabel.text = "\(currentBet)"
        self.winnerPaidlabel.text = "\(winnings)"
        
        /*
        var credits = 0
        var currentBet = 0
        var winnings = 0
        */
    }

    
    //function to pop up uiAlerts
    
    func showAlertWithText(header: String = "Warning", message: String){ //using a default parameter for header parameter - "Warning"
        
        //create instance of uialertController and pass in its parameters
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        //let user dismiss alert controller
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default, handler: nil))
        
        //present alertController because its a type of view controller
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    //Factory.createSlots()   //CALLING class function a class function is - UIColor.redColor()
    
    
    
    //vs CALLING instance function where you first have to create an instance of your class
    /*
    var factoryInstance = Factory()
    factoryInstance.createSlot()
    */
    

    
    
    
}

