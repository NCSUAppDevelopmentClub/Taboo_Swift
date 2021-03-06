//
//  ViewController.swift
//  Taboo
//
//  Created by Peter Girouard on 2/1/17.
//  Copyright © 2017 Peter Girouard. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var timer:Timer!
    var time = 60.00
    var paused = false
    let tabooWordCount = 5
    @IBOutlet weak var clock: UILabel!
    @IBOutlet weak var pauseMenu: UIView!
    @IBOutlet var tableView: UITableView!
    
    let listOfWords = ["Well hellooooo", "howdy", "Big Daddy Dickinson", "Does this work", "This is a word", "Apple", "Water bottle", "Banana", "Pencil", "Peanut Butter", "Another apple", "Stapler", "Microwave plate", "Pizza box"]
    var usedWords = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clock.text = "\(time)"
        makeTimer()
        pauseMenu.isHidden = true
        tableView.separatorColor = UIColor.white
        pauseMenu.isHidden = false
        pauseMenu.alpha = 0.0
        pauseMenu.center.y = self.view.center.y*3.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadNewWord() -> String {
        var wordIndex = 0
        repeat {
            wordIndex = Int(arc4random_uniform(UInt32(listOfWords.count)))
        } while usedWords.contains(wordIndex)
        
        usedWords.append(wordIndex)
        return listOfWords[wordIndex]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tabooWordCountFloat = CGFloat(tabooWordCount)
        let heightInt = Int(tableView.bounds.height/tabooWordCountFloat)
        return CGFloat(heightInt)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tabooWordCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let wordCell = tableView.dequeueReusableCell(withIdentifier: "wordCell", for: indexPath)
        
        wordCell.textLabel?.text = loadNewWord()
        wordCell.textLabel?.textAlignment = .center
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        return wordCell
    }
    
    func makeTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(ViewController.decClock), userInfo: nil, repeats: true)
    }
    
    func decClock() {
        if(time <= 0.0001) {
            time = 0;
            timer.invalidate()
        }
        else if (time < 10) {
            time -= 0.01
            
            let str = String(format: "%.2f", time)
            clock.text = "\(str)"
        }
        else {
            time -= 0.01
            
            let str = String(format: "%.0f", time)
            clock.text = "\(str)"
        }
    }
    
    func fillTable() {
        
    }

    @IBAction func onPauseClick(_ sender: AnyObject) {
        //Switch pause to opposite state whenever pause button is clicked
        paused = !paused
        
        //If game was paused stop the timer and animate the pause menu up while fading it in
        if paused {
            timer.invalidate()
            UIView.animate(withDuration: 0.75, animations: {
                self.pauseMenu.center.y = self.view.center.y
                self.pauseMenu.alpha = 1.0
            })
        }
        
        //If the game was unpaused restart the timer and remove the pause menu immediately
        else {
            self.pauseMenu.alpha = 0.0
            self.pauseMenu.center.y = self.view.center.y*3.0
            makeTimer()
        }
    }

    @IBAction func onBadClick(_ sender: AnyObject) {
        print("WRONG")
        tableView.reloadData()
        usedWords.removeAll()
    }
    
    @IBAction func onGoodClick(_ sender: AnyObject) {
        print("CORRECT")
        tableView.reloadData()
        usedWords.removeAll()
    }
}

