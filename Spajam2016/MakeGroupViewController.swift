//
//  MakeGroupViewController.swift
//  Spajam2016
//
//  Created by 会津慎弥 on 2016/05/29.
//  Copyright © 2016年 japan-alps. All rights reserved.
//

import UIKit
import SocketIOClientSwift

class MakeGroupViewController: UIViewController,UITextFieldDelegate {
    
    var socket : SocketIOClient!
    
    @IBOutlet weak var player1Label: UILabel!
    @IBOutlet weak var player2Label: UILabel!
    @IBOutlet weak var player3Label: UILabel!
    @IBOutlet weak var player4Label: UILabel!
    @IBOutlet weak var player5Label: UILabel!
    
    @IBOutlet weak var player1Image: UIImageView!
    @IBOutlet weak var player2Image: UIImageView!
    @IBOutlet weak var player3Image: UIImageView!
    @IBOutlet weak var player4Image: UIImageView!
    @IBOutlet weak var player5Image: UIImageView!
    
    var appDelegate : AppDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        socket = appDelegate.socket as SocketIOClient
        
        self.player1Label.text = "かのう"
        
        socket.on("created_j"){ (data,ack) in
            let str = data
            self.appDelegate.members = data
            print("okok")
            
            for i in 0 ..< self.appDelegate.members[0].count {
                
                print(i)
                
                switch(i){
                case 0:
                    self.player2Label.text = self.appDelegate.members[0][i]
                    self.player2Image.image = UIImage(named: "human1.png")
                case 1:
                    self.player3Label.text = self.appDelegate.members[0][i]
                    self.player3Image.image = UIImage(named: "human1.png")
                case 2:
                    self.player4Label.text = self.appDelegate.members[0][i]
                    self.player4Image.image = UIImage(named: "human1.png")
                case 3:
                    self.player5Label.text = self.appDelegate.members[0][i]
                    self.player5Image.image = UIImage(named: "human1.png")
                default :
                    break
                    
                }
            }
            
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadView(){
        loadView()
        self.viewDidLoad()
    }
    
    @IBAction func deadlineMember(sender: AnyObject) {
        //送信
        socket.emit("member_request","0")
        performSegueWithIdentifier("CreateQuestion", sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let viewController = segue.destinationViewController as! CreateQuestionViewController
        
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
