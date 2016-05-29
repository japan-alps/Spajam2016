//
//  MasterMonitorViewController.swift
//  Spajam2016
//
//  Created by 会津慎弥 on 2016/05/29.
//  Copyright © 2016年 japan-alps. All rights reserved.
//

import UIKit
import SocketIOClientSwift

class MasterMonitorViewController: UIViewController {
    
    var socket : SocketIOClient!
    var appDelegate : AppDelegate!
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        socket = appDelegate.socket as SocketIOClient
        
        socket.on("receive_stream"){(data,ack) in
            print("hellohellohello")
            let json = JSON(data)
            let name = json[0]["name"].string
            let imgData = json[0]["img"].string
            
            let img = NSData(base64EncodedString: imgData!, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
            
            let members = self.appDelegate.members
            
            for var i = 0; i < members[0].count; i+=1 {
                let image = UIImage(data: img!)
                if name == members[0][0] {
                    self.image1.image = image
                }
                
                if name == members[0][1] {
                    self.image2.image = image
                }
                 /*
                if name == members[0][3] {
                    self.image3.image = image
                }
                if name == members[0][4] {
                    self.image4.image = image
                }
                 */
                           }
        }
        
            socket.on("finish2"){ (data,ack) in
                let str = data
                self.performSegueWithIdentifier("AnswerSelect", sender: "")
            }
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            
            let viewController = segue.destinationViewController as! AnswerSelectViewController
            
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
