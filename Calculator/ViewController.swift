//
//  ViewController.swift
//  Calculator
//
//  Created by Yuri Costa on 8/6/15.
//  Copyright (c) 2015 Yuri Costa. All rights reserved.
//

import UIKit

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
        sender.frame = CGRectMake(10, 10, 10, 10)
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func Enter()
    {
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        println("OperandStack = \(operandStack)")
    }

    //setting up display value as numbers and getting it to flow back to the calculator's display
    var displayValue: Double
    {
        get
        {
            return NSNumberFormatter().numberFromString(resultsLabel.text!)!.doubleValue
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
        case "+": performOperation { $0 + $1}
        case "-": performOperation { $0 - $1}
        case "×": performOperation { $1 * $0}
        case "÷": performOperation { $1 / $0}
        case "√": performOperation { sqrt($0)}
            
        default: break
        }
        
        
    }
    // generic calculator function
    //TODO: Right now if there are less than 2 items on the stack it just copies the last one and it will now have 2
    private func performOperation (operation: (Double, Double) -> Double)
    {
        if operandStack.count >= 2
        {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
        }
        Enter()
    }
    
    // generic calculator function for one argument calls
    private func performOperation(operation: Double -> Double)
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

