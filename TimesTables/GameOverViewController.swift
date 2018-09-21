//
//  GameOverViewController.swift
//  TimesTables
//
//  Created by John Garrett on 4/17/18.
//  Copyright © 2018 John Garrett. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {

    
    @IBOutlet var lblRight: UILabel!
    @IBOutlet var lblWrong: UILabel!
    @IBOutlet var lblScore: UILabel!
    @IBOutlet var lblTime: UILabel!
    
    var right = 0;
    var wrong = 0;
    var totalTime = 0;
    var score:Double = 0;
    override func viewDidLoad() {
        super.viewDidLoad()
        score = (Double(right) / Double((right+wrong)))*100
        
        score = Double(round(10*score)/10)
        lblRight.text = String(right);
        lblWrong.text = String(wrong);
        lblScore.text = String(score) + "%"
        lblTime.text = String((round(Double(totalTime)/Double(right+wrong))*10)/10) + " seconds"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
