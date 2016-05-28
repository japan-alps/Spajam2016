//
//  JoinGroupViewController.swift
//  Spajam2016
//
//  Created by 会津慎弥 on 2016/05/29.
//  Copyright © 2016年 japan-alps. All rights reserved.
//

import UIKit
import SocketIOClientSwift

class JoinGroupViewController: UIViewController {

    var socket : SocketIOClient!
    private var txtActiveField = UITextField()

    @IBOutlet var sc: UIScrollView!
    @IBOutlet weak var idTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pushSendButton(sender: AnyObject) {
        socket.emit("question_from_client",idTextField.text!)
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
    
    @IBAction func joinGroup(sender: AnyObject) {
        performSegueWithIdentifier("WaitParticipate", sender: sender)
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
