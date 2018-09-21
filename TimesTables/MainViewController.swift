//
//  MainViewController.swift
//  TimesTables
//
//  Created by John Garrett on 4/15/18.
//  Copyright © 2018 John Garrett. All rights reserved.
//
//vars are declared with the question mark after them when value is unknown, i feel like this is better than setting them to 0
        //idk, swift is weird

import UIKit

class MainViewController: UIViewController {
//objects
    @IBOutlet var lblQuestion: UILabel!
    @IBOutlet var ProgressBar: UIProgressView!
    @IBOutlet var lblDifficulty: UILabel!
    @IBOutlet var lblProgress: UILabel!
    @IBOutlet var lblTime: UILabel!
    @IBOutlet var lblTimeLabel: UILabel!
    
    var button:UIButton = UIButton();
    
    var rightAnswerPlacement:UInt32 = 0;//default place is quesiton 0
    var questionCounter = 0;//start off at one
    
    var rounds:Int?;
    var difficulty:Int?;

    var offset:UInt32 = 2; //default offset value
    var range:UInt32 = 6;//default range
    var randAns:Int?;
    
    var progress:Float = 0.0;//start off at 0
    var correct = 0;
    var wrong = 0;
    var lastQuestions = [0,0]
    var intOne:Int?;
    var intTwo:Int?;
    var answer:Int?;
    var answers = [0, 0, 0, 0];
    
    var timer:Timer!;
    var timerRunning = false;
    var timeElapsed = 0;
    var totalTime = 0;
    
    
/****************ANSWER **********************/
    @IBAction func Click(_ sender: UIButton) {
        if((sender as AnyObject).tag == Int(rightAnswerPlacement))//if the button the user clicks on is the right one
        {
            colorAnimate(sender, col: UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: 0.18));
            print("right");//correct overlay
            correct += 1;
            stopTimer();
        }
        else{
            colorAnimate(sender, col: UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 0.18));
            print("wrong");//incorrect overlay
            wrong += 1;
            stopTimer();
            }
        if((questionCounter) != rounds){
            lastQuestions = [intOne!, intTwo!];
            newQuesiton();}
            
    //call game over
        else
        {
            performSegue(withIdentifier: "Final", sender: self);
        }
        
    }
    func colorAnimate(_ sender: UIButton, col:UIColor)
    {
        //animate to new color
        UIView.animate(withDuration: 0.75) {
            sender.backgroundColor = col;
        }
        UIView.animate(withDuration: 0.25){} //do nothing for .25 seconds
        //animate back to original color
        UIView.animate(withDuration: 0.5)
        {
            sender.backgroundColor = UIColor(red: 0/255, green: 150/255, blue: 255/255, alpha: 0.18);
        }
        
    }
    func newQuesiton()
    {
        
        timeElapsed = 0;
        startTimer()
        questionCounter += 1;
        progress = Float(questionCounter) / Float(rounds!)
        
        
        
        ProgressBar.progress = progress;
        lblProgress.text = String(questionCounter) + "/" + String(rounds!)
        
        //which button is getting the right answer
        rightAnswerPlacement = arc4random_uniform(3)+1;
        //the left and right integers respectivly
        intOne = Int(arc4random_uniform(range) + offset); //2-the difficulty level
        intTwo = Int(arc4random_uniform(range) + offset); //2-the diffuculty level<,
        while (intOne == lastQuestions[0] || intTwo == lastQuestions[1])
        {
            intOne = Int(arc4random_uniform(range) + offset); //2-the difficulty level
            intTwo = Int(arc4random_uniform(range) + offset); //2-the diffuculty level
        }
        
        answer = intOne! * intTwo!;
        
        //setting up the question
        lblQuestion.text = String(intOne!) + " x " + String(intTwo!);
        genRand();
        //go through each button
        for i in 1...4
        {
            
            //create a button
            button = view.viewWithTag(i) as! UIButton; //each button on the view
            if (i == Int(rightAnswerPlacement))
            {
                button.setTitle(String(answer!), for: .normal);
            }
            else
            {
                button.setTitle(String(answers[i-1]), for: .normal);
            }
        }
    }
    
    
   
/*****************GAME OVER***************/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let gameOver = segue.destination as! GameOverViewController;
        gameOver.right = correct;
        gameOver.wrong = wrong;
        gameOver.totalTime = totalTime;
    }
    

    @IBAction func Exit(_ sender: Any) {
        if (questionCounter <= 1){wrong = 1;}
        performSegue(withIdentifier: "Final", sender: nil)

    }
    /*************** Generate Random**********************/
    func genRand()
    {
        
        for i in 0...3
        {
            answers[i] = (intOne! * (Int(arc4random_uniform(2)+1)) * intTwo! * (Int(arc4random_uniform(2)+1))) + (Int(arc4random_uniform(10)+1));
            if(answers[i] == answer)
            {
                answers[i] = answer! + Int(arc4random_uniform(3)+1);
                stopTimer();
                
            }
            if (i != 0)
            {
                if(answers[i] == answers[i-1]) {genRand();}
            }
        }
    }
    
/**********************BLUR VIEW*********************/
    @IBOutlet var blur: UIVisualEffectView!
    @IBAction func Pause(_ sender: Any) {
        stopTimer();
        blur.isHidden = false;
    }
    @IBAction func Resume(_ sender: Any) {
        questionCounter -= 1;
        newQuesiton();
        blur.isHidden = true;
    }
    
    
    
/**************************TIMER************************/
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(MainViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        timeElapsed += 1;
        lblTime.text = String(timeElapsed) + " seconds"
        if(timeElapsed > 5){lblTime.textColor = UIColor.orange.withAlphaComponent(0.7);lblTimeLabel.textColor = UIColor.orange.withAlphaComponent(0.7)}
        if(timeElapsed > 10){lblTime.textColor = UIColor.red.withAlphaComponent(0.7);lblTimeLabel.textColor = UIColor.red.withAlphaComponent(0.7)}
    }
    func stopTimer(){
        totalTime += timeElapsed;
        timer.invalidate()
        lblTime.text = "0 seconds"
        timeElapsed = 0;
        lblTime.textColor = UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1.0);
        lblTimeLabel.textColor = UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1.0);
    }
    
    
    
/********************INHERITED********************/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blur.isHidden = true;
    //set the difficulty level
        let diff = Int(difficulty!);
        switch (diff)
        {
        case 0:
            lblDifficulty.text = "Easy";
            offset = 2;
            break;
        case 1:
            lblDifficulty.text = "Medium";
            range = 7;
            offset = 5;
            break;
        case 2:
            lblDifficulty.text = "Hard";
            range = 10;
            offset = 8;
            break;
        default:
            lblDifficulty.text = "Easy";
            break;
        }
        lblProgress.text = "1 out of " + String(rounds!)
        newQuesiton();

        }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
