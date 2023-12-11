//
//  ViewController.swift
//  SwiftCalculator
//
//  Created by Stefanus Albert Wilson on 12/11/23.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet var buttons: [UIButton]!
    private var isTypingDone: Bool = true
    
    private var displayValue: Double {
        get {
            guard let number = Double(displayLabel.text!) else {
                fatalError("Cannot convert display label text to a Double")
            }
            return number
        }
        
        set {
            displayLabel.text! = String(newValue)
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        for button in buttons {
            button.layer.cornerRadius = button.frame.size.height / 2
            button.titleLabel?.font = UIFont(name: Constant.fontFamily, size: CGFloat(Constant.fontSize))
        }
        
        
    }
    
    private var calculator = CalculatorLogic()

    @IBAction func calcButtonPressed(_ sender: UIButton) {
        
        isTypingDone = true
        
        calculator.setNumber(displayValue)
        
        if let calcMethod = sender.currentTitle {
            if let result = calculator.calculate(symbol: calcMethod) {
                displayValue = result
            }
        }
    }
    
    
    @IBAction func numberButtonPressed(_ sender: UIButton) {
        
        if let numberValue = sender.currentTitle {
            if isTypingDone {
                displayLabel.text = numberValue
                isTypingDone = false
            } else {
                if numberValue == "." {
                    let isInt = floor(displayValue) == displayValue
                    
                    if(!isInt) {
                        return
                    }
                }
                displayLabel.text = displayLabel.text! + numberValue
            }
        }
    }
    
}

