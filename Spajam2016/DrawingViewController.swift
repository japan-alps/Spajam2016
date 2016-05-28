//
//  DrawingViewController.swift
//  Spajam2016
//
//  Created by 会津慎弥 on 2016/05/29.
//  Copyright © 2016年 japan-alps. All rights reserved.
//

import UIKit
import ACEDrawingView

class DrawingViewController: UIViewController {

    @IBOutlet weak var drawingView: ACEDrawingView!
    
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var penButton: UIButton!
    @IBOutlet weak var eraserButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initDrawingView()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initDrawingView(){
        drawingView.lineWidth = 3
        drawingView.drawTool = ACEDrawingToolTypePen
    }
    
    @IBAction func penAction(sender: UIButton) {
        drawingView.lineWidth = 3
        drawingView.drawTool = ACEDrawingToolTypePen
    }
    
    @IBAction func eraserAction(sender: UIButton) {
        drawingView.lineWidth = 20
        drawingView.drawTool = ACEDrawingToolTypeEraser
    }
    
    // 全消し
    @IBAction func resetAction(sender: AnyObject) {
        
        let alertController = UIAlertController(title: "Clear", message: "編集したデータを全て削除し、\n白紙に戻しますか?", preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default) {
            action in
            
            self.drawingView.clear()
        }
        let cancellAction = UIAlertAction(title: "Cancell", style: .Cancel, handler: nil)
        
        alertController.addAction(defaultAction)
        alertController.addAction(cancellAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    //画像をNSDataに変換
    func ImageToString(image:UIImage) -> String? {
        let data:NSData = UIImagePNGRepresentation(image)!
        //NSDataへの変換が成功していたら
        if let pngData:NSData = data {
            //BASE64のStringに変換する
            let encodeString:String =
                pngData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
            return encodeString
        }
        return nil
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
