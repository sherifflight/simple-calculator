//
//  ViewController.swift
//  simple-calculator
//
//  Created by Евгений Дьяконов on 03/08/2019.
//  Copyright © 2019 Евгений Дьяконов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var displayResultLabel: UILabel!
    var stillTyping: Bool = false
    var dotIsPlaced: Bool = false
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var operation: String = ""
    
    let plusOperand: String = "+"
    let minusOperand: String = "-"
    let multiplyOperand: String = "×"
    let divideOperand: String = "÷"
    
    var currentInput: Double {
        get {
            return Double(displayResultLabel.text!)!
        }
        
        set {
            let value = "\(newValue)"
            let valueArray = value.components(separatedBy: ".")
            if valueArray[1] == "0" {
                displayResultLabel.text = "\(valueArray[0])"
            } else {
                displayResultLabel.text = "\(newValue)"
            }
            stillTyping = false
        }
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        let number = sender.currentTitle!
        print(number)
        
        if stillTyping {
            if displayResultLabel.text?.count ?? 0 < 10 {
                displayResultLabel.text = displayResultLabel.text! + number
            }
        } else {
            displayResultLabel.text = number
            stillTyping = true
        }
    }
    
    @IBAction func operandsPressed(_ sender: UIButton) {
        operation = sender.currentTitle!
        firstOperand = currentInput
        stillTyping = false
        dotIsPlaced = false
    }
    
    @IBAction func equalityPressed(_ sender: UIButton) {
        if stillTyping {
            secondOperand = currentInput
        }
        
        dotIsPlaced = false
        
        switch operation {
        case plusOperand:
            operateWithTwoOperands{$0 + $1}
        case minusOperand:
            operateWithTwoOperands{$0 - $1}
        case multiplyOperand:
            operateWithTwoOperands{$0 * $1}
        case divideOperand:
            operateWithTwoOperands{$0 / $1}
        default:
            break
        }
    }
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        firstOperand = 0
        secondOperand = 0
        currentInput = 0
        displayResultLabel.text = "0"
        stillTyping = false
        operation = ""
        dotIsPlaced = false
    }
    
    @IBAction func plusMinusButtonPressed(_ sender: UIButton) {
        currentInput = -currentInput
    }
    
    @IBAction func percentButtonPressed(_ sender: UIButton) {
        if firstOperand == 0 {
            currentInput = currentInput / 100
        } else {
            secondOperand = firstOperand * currentInput / 100
        }
    }
    
    @IBAction func aquareRootButtonPressed(_ sender: UIButton) {
        currentInput = sqrt(currentInput)
    }
    
    @IBAction func dotButtonPressed(_ sender: UIButton) {
        if stillTyping && !dotIsPlaced {
            displayResultLabel.text = displayResultLabel.text! + "."
            dotIsPlaced = true
        } else if (!stillTyping && !dotIsPlaced) {
            displayResultLabel.text = "0."
        }
    }
    
    func operateWithTwoOperands(operation: (Double, Double) -> Double) {
        currentInput = operation(firstOperand, secondOperand)
        stillTyping = false
    }
    
}

