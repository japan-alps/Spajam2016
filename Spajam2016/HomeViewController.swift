//
//  ViewController.swift
//  Spajam2016
//
//  Created by 高畑 孝輝 on 2016/05/28.
//  Copyright © 2016年 japan-alps. All rights reserved.
//

import UIKit
import SocketIOClientSwift

class HomeViewController: UIViewController,UITextFieldDelegate,UIScrollViewDelegate {
    
    private var txtActiveField = UITextField()
    
    @IBOutlet weak var makeGroupButton: UIButton!
    @IBOutlet weak var joinGroupButton: UIButton!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet var sc: UIScrollView!
    
    var socket : SocketIOClient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sc.frame = self.view.frame
        sc.delegate = self
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        socket = appDelegate.socket as SocketIOClient
        
        socket.on("created_c"){ (data,ack) in
            print(data)
        }
        
        socket.on("not_created_c"){ (data,ack) in
            print(data)
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     キーボード以外をタップするとキーボードを閉じる
     */
    @IBAction func TapScreen(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    /*
     キーボード表示時にテキストフィールドと重なっているか調べる
     重なっていたらスクロールする
     */
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "handleKeyboardWillShowNotification:", name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: "handleKeyboardWillHideNotification:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func handleKeyboardWillShowNotification(notification: NSNotification) {
        
        let userInfo = notification.userInfo!
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let myBoundSize: CGSize = UIScreen.mainScreen().bounds.size
        var txtLimit = txtActiveField.frame.origin.y + txtActiveField.frame.height + 8.0
        let kbdLimit = myBoundSize.height - keyboardScreenEndFrame.size.height
        
        if txtLimit >= kbdLimit {
            sc.contentOffset.y = txtLimit - kbdLimit
        }
    }
    
    func handleKeyboardWillHideNotification(notification: NSNotification) {
        sc.contentOffset.y = 0
    }
    
    /*
     Returnをタップするとキーボードを閉じる
     */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func makeGroupAction(sender: AnyObject) {
        self.socket.emit("create_room",nicknameTextField.text!)
        performSegueWithIdentifier("MakeGroup", sender: sender)
    }
    
    @IBAction func joinGroupAction(sender: AnyObject) {
        self.socket.emit("join_room",nicknameTextField.text!)
        performSegueWithIdentifier("JoinGroup", sender: sender)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if sender is UIButton {
            if segue == "MakeGroup" {
                let viewController = segue.destinationViewController as! MakeGroupViewController
                viewController.player1Label.text = nicknameTextField.text!
            }else if segue == "JoinGroup" {
                let viewController = segue.destinationViewController as! JoinGroupViewController
                
            }
        }
    }
    
}

