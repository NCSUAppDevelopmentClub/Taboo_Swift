//
//  ViewController.swift
//  Taboo
//
//  Created by Peter Girouard on 2/1/17.
//  Copyright © 2017 Peter Girouard. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var timer:Timer!
    var time = 60
    var paused = false
    @IBOutlet weak var clock: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clock.text = "\(time)"
        makeTimer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makeTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.decClock), userInfo: nil, repeats: true)
    }
    
    func decClock() {
        if(time == 0) {
            timer.invalidate()
        }
        else {
            time -= 1
            clock.text = "\(time)"
        }
    }
    
    func fillTable() {
        
    }

    @IBAction func onPauseClick(_ sender: AnyObject) {
        if(paused) {
            makeTimer()
            paused = false
        }
        else {
            timer.invalidate()
            paused = true
        }
    }

    @IBAction func onBadClick(_ sender: AnyObject) {
        print("WRONG")
    }
    
    @IBAction func onGoodClick(_ sender: AnyObject) {
        print("CORRECT")
    }
}

