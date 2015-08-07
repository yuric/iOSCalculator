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
    }
    
    //@IBAction func appendDigitWithEvent(sender: UIButton, forEvent event: UIEvent) {
    //}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

