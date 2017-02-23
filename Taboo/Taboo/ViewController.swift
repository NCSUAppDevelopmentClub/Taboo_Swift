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
    var time = 60.00
    var paused = false
    @IBOutlet weak var clock: UILabel!
    @IBOutlet weak var pauseMenu: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clock.text = "\(time)"
        makeTimer()
        pauseMenu.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makeTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(ViewController.decClock), userInfo: nil, repeats: true)
    }
    
    func decClock() {
        if(time <= 0) {
            timer.invalidate()
        }
        else {
            time -= 0.01
            
            let str = String(format: "%.2f", time)
            clock.text = "\(str)"
        }
    }
    
    func fillTable() {
        
    }

    @IBAction func onPauseClick(_ sender: AnyObject) {
        if(paused) {
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0.5, animations: {
                self.pauseMenu.isHidden = true
                self.view.layoutIfNeeded()
            })
            
            makeTimer()
            paused = false
        }
        else {
            UIView.animate(withDuration: 0.5, animations: {
                self.pauseMenu.isHidden = false
                self.view.layoutIfNeeded()
            })
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

