//
//  CreateQuestionViewController.swift
//  Spajam2016
//
//  Created by 会津慎弥 on 2016/05/29.
//  Copyright © 2016年 japan-alps. All rights reserved.
//

import UIKit
import SocketIOClientSwift

class CreateQuestionViewController: UIViewController,UITextViewDelegate,UIScrollViewDelegate {
    
    var socket : SocketIOClient!
    private var txtActiveField = UITextView()
    
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet var sc: UIScrollView!
    
    var questionStr:NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sc.frame = self.view.frame
        sc.delegate = self
        
        questionTextView.delegate = self
        
        questionTextView.layer.borderWidth = 1
        questionTextView.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        socket = appDelegate.socket as SocketIOClient
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendQuestion(sender: AnyObject) {
        socket.on("question_from_server"){ (data,ack) in
            let str = data
            self.questionStr = str
            self.performSegueWithIdentifier("MasterQuestions", sender: sender)
        }
        
        socket.emit("question_from_client",questionTextView.text!)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let viewController = segue.destinationViewController as! QuestionsViewController
        viewController.questionStr = questionStr[0] as! String
        viewController.flag = true
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool{
        txtActiveField = textView
        return true
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
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
