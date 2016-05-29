//
//  AnswerSelectViewController.swift
//  Spajam2016
//
//  Created by 会津慎弥 on 2016/05/29.
//  Copyright © 2016年 japan-alps. All rights reserved.
//

import UIKit

class AnswerSelectViewController: UIViewController {

    @IBOutlet weak var player1Image: UIImageView!
    @IBOutlet weak var player2Image: UIImageView!
    @IBOutlet weak var player3Image: UIImageView!
    @IBOutlet weak var player4Image: UIImageView!
    
    private var answer : NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gesture = UITapGestureRecognizer(target:self, action: "ClickImageView:")
        player1Image.addGestureRecognizer(gesture)
        player2Image.addGestureRecognizer(gesture)
        player3Image.addGestureRecognizer(gesture)
        player4Image.addGestureRecognizer(gesture)
        
        NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "changeView:", userInfo: nil, repeats: false)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func ClickImageView(recognizer: UIGestureRecognizer){
        
        
    }
    
    
    @objc func changeView(timer: NSTimer){
        
            performSegueWithIdentifier("CheckAnswer", sender: "")
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
            let viewController = segue.destinationViewController as! CheckAnswerViewController
        
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
