//
//  QuestionsViewController.swift
//  Spajam2016
//
//  Created by 会津慎弥 on 2016/05/29.
//  Copyright © 2016年 japan-alps. All rights reserved.
//

import UIKit
import SocketIOClientSwift

class QuestionsViewController: UIViewController {
    
    var socket : SocketIOClient!
    var flag = true
    
    @IBOutlet weak var questionsTextView: UITextView!
    
    var questionStr:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        socket = appDelegate.socket as SocketIOClient
        
        questionsTextView.text = questionStr
        
        //タイマーを作る.
        
        NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "changeView:", userInfo: nil, repeats: false)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func changeView(timer: NSTimer){
        if(flag == true){
            performSegueWithIdentifier("MasterMonitoring", sender: "")
        }else{
            performSegueWithIdentifier("AnswerDrawing", sender: "")
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier ==  "MasterMonitoring"){
            let viewController = segue.destinationViewController as! MasterMonitorViewController
        }else {
            let viewController = segue.destinationViewController as! DrawingViewController
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
