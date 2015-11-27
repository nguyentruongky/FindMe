//
//  ViewController.swift
//  FindMe
//
//  Created by Ky Nguyen on 7/28/15.
//  Copyright (c) 2015 Ky Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var _red:CGFloat = 0
    var _green:CGFloat = 0
    var _blue:CGFloat = 0
    
    var _difIndex = 0
    var _timer = NSTimer()
    
    let interval = 0.015
    let maxTime = 100
    
    var _count = 0
    
    
    var _score = 0
    var _alpha = 0.6
    
    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet var progressView: UIProgressView!
    
    

    
    @IBAction func startButtonTouch(sender: AnyObject) {
        
        startGame()
        startProgress()
    }
    
    @IBOutlet weak var scoreUI: UILabel!
    
    @IBAction func choose(sender: UIButton) {
        
        let tag = sender.tag
        if tag == _difIndex {
            
            next()
        }
        else {
            
            end()
        }
    }
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    
    
    
    
    
    
    
    
    func showResultAlert(title:String, message: String) {
        
        var action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        showAlert(title, message: message, action: action)
    }
    
    func showAlert(title:String, message:String, action: UIAlertAction) {
        
        var alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }

    func generateColor() -> UIColor {
        
        _red = randomUnder255()/255
        _green = randomUnder255()/255
        _blue = randomUnder255()/255
        
        return UIColor(red: _red, green: _green, blue: _blue, alpha: 1)
    }
    
    func generateDifferentColor() -> UIColor {
        
        return UIColor(red: _red, green: _green, blue: _blue, alpha: CGFloat(_alpha))
    }
    
    func randomUnder255() -> CGFloat {
        
        return CGFloat(arc4random_uniform(255))
    }
    
    func randomUnder25() -> Int {
        
        return Int(arc4random_uniform(25))
    }
    
    func startGame() {
        
        
        _difIndex = randomUnder25()
        
        var color = generateColor()
        var difColor = generateDifferentColor()
        
        for index in 0...buttons.count - 1 {
            
            buttons[index].backgroundColor = color
            
            if index == _difIndex {
                
                buttons[index].backgroundColor = difColor
            }
        }
        
        startTimer()
        progressView.setProgress(0, animated: true)
    }
    
    func startTimer() {
        
        _timer.invalidate()
        _count = maxTime
        _timer = NSTimer.scheduledTimerWithTimeInterval(interval, target: self, selector: Selector("countDown"), userInfo: nil, repeats: true)
    }
    
    func countDown() {
        
        _count--

        if _count <= 0 {
            
            end()
            progressView.progress = 0
            return
        }
        
        progressView.progress = Float(_count) / 100
    }
    
    func next() {
        
        _score++
        scoreUI.text = String(_score)
        
        startGame()
    }
    
    func end() {

        _timer.invalidate()
        showResultAlert("Oops", message: "You scored: \(_score)")

    }
    
    func startProgress() {
        
        progressView.progress = Float(_count)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

