//
//  FirstViewController.swift
//  TimesTables
//
//  Created by John Garrett on 4/15/18.
//  Copyright © 2018 John Garrett. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    
    
    @IBOutlet var lblRounds: UILabel!
    @IBOutlet var stp: UIStepper!
    @IBOutlet var option: UISegmentedControl!
    var rnds = 1;
    var diff = 0;
    
    
    @IBAction func difficultySeg(_ sender: Any) {
        diff = option.selectedSegmentIndex;
    }
    
    
//set the rounds value to the current value of the stepper
    @IBAction func Step(_ sender: Any) {
        rnds = Int(stp.value);
        lblRounds.text =  String(rnds);
    }
    
    
    @IBAction func Switch(_ sender: Any) {
        performSegue(withIdentifier: "First2Second", sender: self);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let mainController = segue.destination as! MainViewController;
        mainController.rounds = rnds;
        mainController.difficulty = diff;
    }
    
    
    
    
    
    
    
    /*****INHERITED***/
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
