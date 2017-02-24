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
    var time = 15.00
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
            self.view.layoutIfNeeded()
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
        tableView.reloadData()
        usedWords.removeAll()
    }
    
    @IBAction func onGoodClick(_ sender: AnyObject) {
        print("CORRECT")
        tableView.reloadData()
        usedWords.removeAll()
    }
}

