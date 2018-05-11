//
//  ViewController.swift
//  timeOut
//
//  Created by brn.developers on 5/11/18.
//  Copyright © 2018 DAS. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    
    var hoursArray = [String]()
    var minsSecondsArray = [String]()
    
    
    @IBOutlet weak var setTimerPickerView: UIPickerView!
    var seconds = 0
    var timer = Timer()
    
    var isTimerRunning = false
    var resumeTapped = false
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 {
            
            return self.hoursArray.count
        }
        else  {
            
            return self.minsSecondsArray.count
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        if component == 0 {
            
            return self.hoursArray[row]
        }
        else  {
            
            return self.minsSecondsArray[row]
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        var hours = Int()
        var mins = Int()
        var sec = Int()
        
        if component == 0 {
            
            //            hours = title != nil ? Int(title!)! : 0
            
            hours = row
            
        }
        if component == 1 {
            
            //           mins = title != nil ? Int(title!)! : 0
            mins = row
        }
        else
        {
            //            sec = title != nil ? Int(title!)! : 0
            sec = row
        }
        
        
        self.seconds = (hours * 3600) + (mins * 60) + sec
        
        
    }
    
    
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        
        self.setTimerPickerView.reloadAllComponents()
        
        if isTimerRunning == false {
            runTimer()
            self.startButton.isEnabled = false
        }
        
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
        pauseButton.isEnabled = true
    }
    
    @IBAction func pauseButtonTapped(_ sender: UIButton) {
        if self.resumeTapped == false {
            timer.invalidate()
            isTimerRunning = false
            self.resumeTapped = true
            self.pauseButton.setTitle("Resume",for: .normal)
        } else {
            runTimer()
            self.resumeTapped = false
            isTimerRunning = true
            self.pauseButton.setTitle("Pause",for: .normal)
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        
        timer.invalidate()
        seconds = 0
        timerLabel.text = timeString(time: TimeInterval(seconds))
        isTimerRunning = false
        pauseButton.isEnabled = false
        startButton.isEnabled = true
        
    }
    
    
    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
            //Send alert to indicate time's up.
        } else {
            seconds -= 1
            timerLabel.text = timeString(time: TimeInterval(seconds))
            
        }
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
        
        //        return  String(hours) + ":" + String(minutes) + ":" + String(seconds)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTimerPickerView.delegate = self
        setTimerPickerView.dataSource = self
        pauseButton.isEnabled = false
        timerLabel.minimumScaleFactor = 0.6;
        timerLabel.adjustsFontSizeToFitWidth = true;
        setArray()
    }
    
    func setArray() {
        
        
        for i in 0..<61 {
            
            if i < 13
            {
                self.hoursArray.append(String(i))
            }
            
            self.minsSecondsArray.append(String(i))
            
            
        }
        
        
    }
    
    
    
}


