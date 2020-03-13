//
//  ViewController.swift
//  Retro Calculator
//
//  Created by Marchell on 13/03/20.
//  Copyright © 2020 Marchell. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValueString = ""
    var rightValueString = ""
    var result = ""
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Substract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty
    

    // IB Outlets
    @IBOutlet weak var outputLabel: UILabel!
    
    // Identical to onCreate in Android
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        outputLabel.text = "0"
        
        // Configurung the .wav file path on Bundle
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        
        // Basically try-catch statement on Java
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        
        runningNumber += "\(sender.tag)"
        outputLabel.text  = runningNumber
    }
    
    
    @IBAction func onDivide(_ sender: Any) {
        processOperation(operation: .Divide)
    }
    
    
    @IBAction func onMultiply(_ sender: Any) {
        processOperation(operation: .Multiply)
    }
    
    
    @IBAction func onSubstract(_ sender: Any) {
        processOperation(operation: .Substract)
    }
    
    
    
    @IBAction func onAdd(_ sender: Any) {
        processOperation(operation: .Add)
    }
    
    
    @IBAction func onEquals(_ sender: Any) {
        processOperation(operation: currentOperation)
    }
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    func processOperation(operation: Operation) {
        if currentOperation != Operation.Empty {
            
            // And operator is selected, but number has yet to be assigned
            if runningNumber != "" {
                rightValueString = runningNumber
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValueString)! * Double(rightValueString)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValueString)! / Double(rightValueString)!)"
                } else if currentOperation == Operation.Substract {
                    result = "\(Double(leftValueString)! - Double(rightValueString)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValueString)! + Double(rightValueString)!)"
                }
                
                leftValueString = result
                outputLabel.text = result
            }
            
            currentOperation = operation
            
        } else {
            // This is the first time an operator has been pressed
            leftValueString = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }

}

