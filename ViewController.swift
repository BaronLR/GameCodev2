
import UIKit
import SpriteKit
import SceneKit

class ViewController: UIViewController
{
    var GameSelected = 0
    var currentRow:Int = 0
    var bodytemploss:Int = 0
    var currentCollum:Int = 0
    var positionArr = Array(count:5, repeatedValue:Array(count:5, repeatedValue:Rooms(newtemp: 0, newEnter: false)))
    var currentText:String = ""
    var bodyTempature:Float = 100
    
    //var myCounter = 0
   // var timer:NSTimer?
    /*
    func fireTimer(){
        timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "typeLetter", userInfo: nil, repeats: true)
    }
    func typeLetter(var output:Array<Character>){
        if myCounter < output.count {
            lblOutput.text = lblOutput.text + String(output[myCounter])
            let randomInterval = Double((arc4random_uniform(8)+1))/20
            timer?.invalidate()
            timer = NSTimer.scheduledTimerWithTimeInterval(randomInterval, target: self, selector: "typeLetter", userInfo: nil, repeats: false)
        } else {
            timer?.invalidate()
        }
        myCounter++
    }
*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var lblOutput: UITextView!
    
    @IBOutlet var ViewSelection: UISegmentedControl!
    
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var progressBodyTemp: UIProgressView!
    
    @IBAction func ViewSelectionSwitch(sender: UISegmentedControl)
    {
        
        GameSelected++
        if GameSelected % 2 == 0
        {
              lblOutput.text = lblOutput.text! + "\n (User) In Game"
        }
        else
        {
              lblOutput.text = lblOutput.text! + "\n (User) In Inventory"
        }
    }
    
    @IBAction func btnInventory(sender: UIButton) {
        //Open Inventory
    }
   
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
    
    override func viewDidLoad()
    {
        progressBodyTemp.progress = bodyTempature
        for var i = 0; i < 5; i++
        {
            for var j = 0; j < 5; j++
            {
                positionArr[i][j] = createRooms();
            }
        }
        lblTemp.text = "It is " + positionArr[currentRow][currentCollum].tempature.description + "c in this room"
        returnText("You Wake Up")
        super.viewDidLoad()
     
    }
   
    func createRooms() -> Rooms {
        var initialTemp = Int(arc4random_uniform(20))
        var tempModifier = Int(arc4random_uniform(2))
       
        if tempModifier == 1
        {
            initialTemp *= -1   // Negative Temperature
        }
        var randomRoom = Rooms(newtemp: initialTemp, newEnter: false)
        return randomRoom
    }

    func Inputmovement(var userInput:String)
    {
        var dictionaryMovement = Array(arrayLiteral: "North","East","South","West")
        var dictNorth = Array(arrayLiteral: "North", "north", "n" )
        var dictEast = Array(arrayLiteral: "East", "east", "e" )
        var dictWest = Array(arrayLiteral: "West", "west", "w" )
        var dictSouth = Array(arrayLiteral: "South", "south", "s" )
        if contains(dictionaryMovement, userInput)
        {
            if contains(dictNorth, userInput)
            {
                playerMovement("North")
                println("You head North")
            }
            if contains(dictSouth, userInput)
            {
                playerMovement("South")
                println("You head South")
            }
            if contains(dictEast, userInput)
            {
                playerMovement("East")
                println("You head East")
                
            }
            if contains(dictWest, userInput)
            {
                playerMovement("West")
                println("You West")
            }
        }
        else
        {
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
            if currentCollum == 4 { reachedCliff(Direction) }
            else { currentCollum += 1
               returnText(Direction) }}
            
       else if Direction == "South" {
            if currentRow == 4 { reachedCliff(Direction)}
            else {
            currentRow += 1
            returnText(Direction)}}
        
        if Direction == "West" {
            if currentCollum == 0 {reachedCliff(Direction)}
            else {
            currentCollum -= 1
            returnText(Direction)
            }
        }
    }
    
    func reachedCliff(var Direction:String) {
        lblOutput.text = lblOutput.text! + "\n(" + Direction + ")"   + "Nothing but a rusting wall this way"
    }
    func calcTempLoss() -> Int //Work In Progress
    {
        
        var roomReference = positionArr[currentRow][currentCollum]
        var temp:Int = roomReference.tempature
        bodytemploss = temp
        return bodytemploss
        
        
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
                    usleep(20000)
                }
                
        }
    }
    func returnText(var Direction:String)
    {
        var roomReference = positionArr[currentRow][currentCollum]
        bodyTempature = bodyTempature - Float(calcTempLoss())
        progressBodyTemp.progress +=  bodyTempature
        
        
       let temperature =
        [
            true : ["It's freezing in here","You can see you're own breath","You can't stay here for long it's too cold"],
            false : ["it's warm","You can get warmed up in here", "you're relieved that it's warm"]
        ]
        let entered =
        [
            true : ["you've been here before", "this room is familiar","You've seen this room before"],
            false : ["you've never seen this room", "it's definatly the first time you have entered this room","This is room seems new"]
        ]
        
        var output1 = temperature[roomReference.tempature < 0]![random() % temperature.count]
        var output2 = entered[roomReference.enteredBefore]![random() % temperature.count]
        
        var finalphrase = output1 + " and " + output2
        let OutputFinal  =   "\n\n(" + Direction + ") "  + finalphrase
        typeOutText(OutputFinal)
        
        lblTemp.text = "It is " + positionArr[currentRow][currentCollum].tempature.description + "c in this room"
        roomReference.enteredBefore = true
     
    }
   

  



}


