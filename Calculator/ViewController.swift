//
//  ViewController.swift
//  Calculator
//
//  Created by Yuri Costa on 8/6/15.
//  Copyright (c) 2015 Yuri Costa. All rights reserved.
//

import UIKit

extension String
{
    public func indexOfCharacter(char: Character) -> Int? {
        if let idx = find(self, char) {
            return distance(self.startIndex, idx)
        }
        return nil
    }
}
class ViewController: UIViewController {
    
    @IBOutlet weak var resultsLabel: UILabel!
    var userIsInTheMiddleOfTypingANumber: Bool = false
    
    @IBAction func appendDigit(sender: UIButton)
    {
        let digit = sender.currentTitle!
        println("Digit= \(digit)")
        //constantString += sender.titleLabel?.text as String
        if (userIsInTheMiddleOfTypingANumber)
        {
            resultsLabel.text = resultsLabel.text! + digit
            userIsInTheMiddleOfTypingANumber = true
        }
        else
        {
            resultsLabel.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    var operandStack = Array<Double>()
    
    func parseNumber(num:String) -> Double
    {
        let index = count(num) > 1 ? num.indexOfCharacter("π") : -1
        let multiplier = index > -1 ? 3.14159265 : 1
        let new_num = count(num) > 1 ? num.stringByReplacingOccurrencesOfString("π", withString:"") : num
        switch new_num
        {
            case let x as String where x.toInt() >= 0 && x.toInt() <= 10: return NSNumberFormatter().numberFromString(x)!.doubleValue * multiplier
            case "π": return 3.1415926
        default: return NSNumberFormatter().numberFromString(num)!.doubleValue

        }
    }
    @IBAction func clear() {
        operandStack.removeAll(keepCapacity: true)
         resultsLabel.text = "000"
        println("OperandStack = \(operandStack)")
    }
    @IBAction func Enter()
    {
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(parseNumber(displayValue))
        println("OperandStack = \(operandStack)")
    }

    //setting up display value as numbers and getting it to flow back to the calculator's display
    var displayValue: String
    {
        get
        {
            //return NSNumberFormatter().numberFromString(resultsLabel.text!)!.doubleValue
            return resultsLabel.text!

        }
        set
        {
            resultsLabel.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
    //Time to crunch the stack
    @IBAction func operate(sender: UIButton)
    {
        var operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber
        {
            Enter()
        }
        switch operation
        {
        case "+": performOperation { ($0 + $1).description}
        case "-": performOperation { ($0 - $1).description}
        case "×": performOperation { ($1 * $0).description}
        case "÷": performOperation { ($1 / $0).description}
        case "√": performOperation { sqrt($0).description}
        case "sin": performOperation { sin($0).description}
        case "cos": performOperation { cos($0).description}

        default: break
        }
        
    }
    // generic calculator function
    //TODO: Right now if there are less than 2 items on the stack it just copies the last one and it will now have 2
    private func performOperation (operation: (Double, Double) -> String)
    {
        if operandStack.count >= 2
        {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
        }
        Enter()
    }
    
    // generic calculator function for one argument calls
    private func performOperation(operation: Double -> String)
    {
        if operandStack.count >= 1
        {
            displayValue = operation(operandStack.removeLast())
        }
        Enter()
    }
    



    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

