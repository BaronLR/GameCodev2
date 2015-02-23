
import UIKit
import SpriteKit
import SceneKit

class ViewController: UIViewController
{
    var GameSelected = 0
    var currentRow:Int = 0
    var bodytemploss:Int = 0
    var currentCollum:Int = 0
    var positionArr = Array(count:20, repeatedValue:Array(count:20, repeatedValue:Rooms(newtemp: 0, newEnter: false, items:"")))
    var currentText:String = ""
    var bodyTempature:Float = 100
    var Inventory:Array<String> = []
    var ItemButtonArray:Array<UIButton> = []
    @IBOutlet var btnCompNorth: UIButton!
    @IBOutlet weak var lblOutput: UITextView!
    @IBOutlet var btnInventory: UIButton!
    @IBOutlet var btnCompassHead: UIImageView!
    @IBOutlet var btnCompSouth: UIButton!
    @IBOutlet var btnCompEast: UIButton!
    @IBOutlet var btnCompWest: UIButton!
    @IBOutlet var ViewSelection: UISegmentedControl!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var progressBodyTemp: UIProgressView!
  
    @IBOutlet var lblBodyTemperature: UILabel!
    @IBOutlet var progBodyTemperature: UIProgressView!
  
   
    
    @IBAction func btnNorthPress(sender: UIButton) {
          Inputmovement("North")
    }
    
    @IBAction func btnEastPress(sender: UIButton) {
          Inputmovement("East")
    }
    
    @IBAction func btnSouthPress(sender: UIButton) {
          Inputmovement("South")
    }
    @IBAction func btnWestPress(sender: UIButton) {
          Inputmovement("West")
    }
    @IBAction func btnInv1Click(sender: UIButton) {
        usingInvItems(btnInv1.description)
    }
    @IBAction func btnInv2Click(sender: UIButton) {
        
    }
    @IBAction func btnInv3Click(sender: UIButton) {
        
    }
    @IBAction func btnInv4Click(sender: UIButton) {
        
    }
    @IBAction func btnInv5Clikc(sender: UIButton) {
        
    }
   
    @IBOutlet var btnInv1: UIButton!
    @IBOutlet var btnInv2: UIButton!
    @IBOutlet var btnInv3: UIButton!
    @IBOutlet var btnInv4: UIButton!
    @IBOutlet var btnInv5: UIButton!
  
    var counter:Int = 0 {
        didSet {
            let fractionalProgress = Float(counter) / 100.0
            let animated = counter != 0
            if counter > 100 {
                counter = 100
            }
            progBodyTemperature.setProgress(fractionalProgress, animated: animated)
            lblBodyTemperature.text = ("\(counter)%")
        }
    }
    func usingInvItems(var Item:String) {
        println(Item)
    }
  
   
    
    override func viewDidLoad()
    {
        lblBodyTemperature.hidden = false
        lblBodyTemperature.text = ("You're body temperature is at\(counter)%")
        self.counter = 90
        var maxCollum:Int = 19
        var maxRow:Int = 19
        currentCollum = random() % maxCollum
        currentRow = random() % maxRow
        disableButtonsForLaunch()
    
        for var i = 0; i < 19; i++
        {
            for var j = 0; j < 19; j++
            {
                positionArr[i][j] = createRooms();
            }
        }
   
        returnText("You Wake Up")
        super.viewDidLoad()
     
    }
    
    func createRooms() -> Rooms {
        var initialTemp = Int(arc4random_uniform(20))
        var tempModifier = Int(arc4random_uniform(2))
        var randomItemChoices:Array<String> = ["Mysterious Key","Flashlight","Pistol","nothing","nothing","nothing","Blanket","Warm coat","Pack of matches","nothing","Cup of Coco"]
        
        var ItemDiscription:Array<String> = ["",""]
        if tempModifier == 1 {
            initialTemp *= -1
        }
        
        var randomRoom = Rooms(newtemp: initialTemp, newEnter: false, items: randomItemChoices[random() % randomItemChoices.count])
        return randomRoom
    }

    func Inputmovement(var userInput:String) { //Only used if Keyboard Input
        var dictionaryMovement = Array(arrayLiteral: "North","East","South","West")
        var dictNorth = Array(arrayLiteral: "North", "north", "n" )
        var dictEast = Array(arrayLiteral: "East", "east", "e" )
        var dictWest = Array(arrayLiteral: "West", "west", "w" )
        var dictSouth = Array(arrayLiteral: "South", "south", "s" )
        if contains(dictionaryMovement, userInput) {
            if contains(dictNorth, userInput) {
                playerMovement("North")
                println("You head North")
            }
            if contains(dictSouth, userInput) {
                playerMovement("South")
                println("You head South")
            }
            if contains(dictEast, userInput) {
                playerMovement("East")
                println("You head East")
                
            }
            if contains(dictWest, userInput) {
                playerMovement("West")
                println("You West")
            }
        }
        else {
            println("That is not an option")
        }
    }
    
    
    func playerMovement(var Direction:String) //Get the direction they are heading
    {
        if Direction == "North" {
            if currentRow == 0 {reachedCliff(Direction)}
            else {
                currentRow -= 1
                returnText(Direction) } }
            
       else if Direction == "East" {
            if currentCollum == 19 { reachedCliff(Direction) }
            else { currentCollum += 1
               returnText(Direction) }}
            
       else if Direction == "South" {
            if currentRow == 19 { reachedCliff(Direction)}
            else {
            currentRow += 1
            returnText(Direction)}}
        
       else if Direction == "West" {
            if currentCollum == 0 {reachedCliff(Direction)}
            else {
            currentCollum -= 1
            returnText(Direction)
            }
        }
    }
    func disableButtonsForLaunch() {
        btnInv1.hidden = true
        btnInv2.hidden = true
        btnInv3.hidden = true
        btnInv4.hidden = true
        btnInv5.hidden = true
        btnInv1.setTitle("", forState: .Normal)
        btnInv2.setTitle("", forState: .Normal)
        btnInv3.setTitle("", forState: .Normal)
        btnInv4.setTitle("", forState: .Normal)
        btnInv5.setTitle("", forState: .Normal)
    }
    
    func reachedCliff(var Direction:String) {
        let HitWallPhrases =
        [
            "This must be one of the only rooms in here without a door...", "It's just a wall... with no door.",
            "Why is there no door? It's just a rusty old wall...", "I don't think I can go this way", "This is interesting, you can't go this way..."
        ]
        let HitAWall = "\n\n(" + Direction + ")"   +  HitWallPhrases[random() % HitWallPhrases.count]
        typeOutText(HitAWall)
    }
    func calcTempLoss() -> Int //Work In Progress
    {
        
        var roomReference = positionArr[currentRow][currentCollum]
        var temp:Int = roomReference.tempature
        bodytemploss = temp
        return bodytemploss
        
        
    }
    func addButtons()
    {
      
        let buttonArray = [btnInv1,btnInv2,btnInv3,btnInv4,btnInv5]
        for var i = 0 ; i < Inventory.count;
        {
            if Inventory.count <= 4
            {
            
               if Inventory[i] != "nothing"
               {
                   buttonArray[i].setTitle(Inventory[i], forState: .Normal)
                   i++
               }
            }
            
        }
        
    }

    func typeOutText(var output:String)
    {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0))
            {
                for char in output
                {
                  
                    dispatch_async(dispatch_get_main_queue())
                        {
                            self.lblOutput.text.append(char)
                          
                            return
                    }
                    self.lblOutput.clipsToBounds = true
                    usleep(40000)
                }
           
             
                
        }
       
    }
    func addToInventory() {
        
        var roomReference = positionArr[currentRow][currentCollum]
        if roomReference.items != "nothing"
        {
          Inventory.extend([roomReference.items])
        }
        addButtons()
        
        self.counter += roomReference.tempature

    }
  
    func AorNot() -> String {
        var roomReference = positionArr[currentRow][currentCollum]
        var AorNot:String = ""
        if roomReference.items != "nothing" { //determines whether the sentence requires an 'a', if the room does not have an item, the sentence doesn't require a 'a'
            AorNot = "a "
        } else {
            AorNot = ""
        }
        return AorNot
    }
    
    func returnText(var Direction:String)
    {
        var roomReference = positionArr[currentRow][currentCollum]
        addToInventory() //Add's current rooms items to Inventory
        lblBodyTemperature.text = ("You're body temperature is at\(counter)%")
       let temperature =
        [
            true : ["It's absolutely freezing in here, you need to find a way to warm up","You can see you're own breath","You can't stay here for long it's too cold"],
            false : ["It's rather warm in this room","It's starting to feel warm in here", "You're relieved that the tempaure is resonable","It's fairly warm in this room","It's not that bad in this room, temperature wise"]
        ]
        let entered =
        [
            true : ["you have seen this room before", "either all of these rooms are starting to look the same, or you really have been here before " ,"you remember this place, but how?","you've seen this room before", "have you been walking in circles or something? You have been here before"],
            false : ["yet, you have never seen this place before...", "it's definatly the first time you have entered this room","This is room seems new"]
        ]
        let findingItems =
        [
            "After searching the room you found ","You sort through an old desk and you find ", "You turn around and search a cabnit, inside you discovered ","There is a hole in the rusting wall, inside of it you find "
        ]
        var output1 = temperature[roomReference.tempature < 0]![random() % temperature.count]
        var output2 = entered[roomReference.enteredBefore]![random() % temperature.count]
        var phraseTemp = ". You're watch says it's " + roomReference.tempature.description + "c in this room. You have used " +  Inventory.count.description + "/5ths of the space in your backpack. "
        var phraseDirectionStart = "\n\n(" + Direction + ") "
        var finalphrase = output1 + " and " + output2 + ". "
        
        
        let OutputFinal = phraseDirectionStart + finalphrase + findingItems[random() % findingItems.count] + AorNot() + roomReference.items + phraseTemp
        
        dump(Inventory)
        
        typeOutText(OutputFinal)
     
    }
    
    @IBAction func ViewSelectionSwitch(sender: UISegmentedControl)
    {
        GameSelected++
        if GameSelected % 2 == 0
        {
            //lblOutput.text = lblOutput.text! + "\n\n(User) In Game"
            inGame()
        }
        else
        {
          // lblOutput.text = lblOutput.text! + "\n\n(User) In Inventory"
            inInventory()
        }
    }
    func inGame()
    {
        lblOutput.hidden = false
        lblBodyTemperature.hidden = false
        btnCompassHead.hidden = false
        btnCompEast.hidden = false
        btnCompSouth.hidden = false
        btnCompWest.hidden = false
        btnCompNorth.hidden = false
        btnInventory.hidden = true
        progBodyTemperature.hidden = false
        btnInv1.hidden = true
        btnInv2.hidden = true
        btnInv3.hidden = true
        btnInv4.hidden = true
        btnInv5.hidden = true
    }
    func inInventory()
    {
        progBodyTemperature.hidden = true
        lblBodyTemperature.hidden = true
        lblOutput.hidden = true
  
        btnCompassHead.hidden = true
        btnCompEast.hidden = true
        btnCompSouth.hidden = true
        btnCompWest.hidden = true
        btnCompNorth.hidden = true
        btnInventory.hidden = false
        progBodyTemperature.hidden = true
        btnInv1.hidden = false
        btnInv2.hidden = false
        btnInv3.hidden = false
        btnInv4.hidden = false
        btnInv5.hidden = false
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

}


