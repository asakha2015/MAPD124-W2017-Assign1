//
//  ViewController.swift
//  MAPD124-W2017-Assign1
//
//  Created by Reza on 2017-01-22.
//  Copyright © 2017 Reza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //calculator display
    @IBOutlet weak var calc: UILabel!
    
    //initilize varaiables
    var currentOperations: String? = nil
    var firstNumber: String? = nil
    var secondNumber: String? = nil
    var equalCheck: Bool = false
    
    
    // equal button
    @IBAction func equalButton(_ sender: UIButton) {
        
        if (firstNumber == nil || currentOperations == nil || secondNumber == nil) {return}
        firstNumber = "\(calculate(firstNumber: Double(firstNumber!)!, secondNumber: Double(secondNumber!)!, op: currentOperations!))"
        currentOperations = nil
        secondNumber = nil
        calc.text = firstNumber
        equalCheck = true
    }
    
    // Clear button
    @IBAction func ClearButton(_ sender: UIButton) {
        
        calc.text = "0"
        currentOperations = nil
        firstNumber = nil
        secondNumber = nil
        
    }
    
    // Number buttons
    @IBAction func numberButton(_ sender: UIButton) {
        if (equalCheck) {
            calc.text = "0"
            currentOperations = nil
            firstNumber = nil
            secondNumber = nil
            equalCheck = false
        }
        if (calc.text == "0") {
            calc.text = sender.currentTitle!
        }
            
            // Don't allow multiple dots in single operand
        else if (sender.currentTitle! == "." && firstNumber != nil && currentOperations == nil && firstNumber!.contains(".")) {return}
        else if (sender.currentTitle! == "." && secondNumber != nil && secondNumber!.contains(".")) {return}
        else {
            calc.text = calc.text! + sender.currentTitle!
        }
        // If operator not set, update first operand else, update second operand
        if (currentOperations == nil) {
            firstNumber = calc.text!
        } else {
            if (secondNumber == nil) {
                secondNumber = calc.text!.components(separatedBy: currentOperations!)[1]
                calc.text = secondNumber!
            } else {secondNumber = calc.text!}
        }
    }
    
    // operator button
    @IBAction func operationButton(_ sender: UIButton) {
        if (firstNumber == nil) {return} // Cannot select operator until first operand is nil
        if (secondNumber == nil) {
            // If second operand is nil, either do ... or add selected operator to calc
            if (currentOperations == nil) {
                currentOperations = sender.currentTitle!
                firstNumber = calc.text!
                
                calc.text = currentOperations!
            } else {
                calc.text = calc.text!.replacingOccurrences(of: currentOperations!, with: sender.currentTitle!)
                currentOperations = sender.currentTitle!
            }
            // If all is set, do calculation and set answer as first operand, and add new selected operator to that
        } else {
            firstNumber = "\(calculate(firstNumber: Double(firstNumber!)!, secondNumber: Double(secondNumber!)!, op: currentOperations!))"
            secondNumber = nil
            currentOperations = sender.currentTitle!
            calc.text = firstNumber! + currentOperations!
        }
    }
    
    
    // return answer
    func calculate(firstNumber: Double, secondNumber: Double, op: String) -> Double {
        switch op {
        case "+":
            return firstNumber + secondNumber // Adds
        case "-":
            return firstNumber - secondNumber // Subtracts
        case "×":
            return firstNumber * secondNumber // Multiplies
        case "÷":
            return firstNumber / secondNumber // Divides
        case "%":
            return firstNumber * secondNumber / 100 // Percent
            case "^":
            return pow(Double(firstNumber), Double(secondNumber)) //Power button
        default:
            return 0
        }
    }
}
