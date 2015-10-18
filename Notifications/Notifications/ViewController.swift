//
//  ViewController.swift
//  Notifications
//
//  Created by Fhict on 16/10/15.
//  Copyright © 2015 Fhict. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "drawAShape", name: "actionOnePressed", object: nil)
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "showAMessage", name: "actionTwoPressed", object: nil)
        
        let dateComp:NSDateComponents = NSDateComponents()
        dateComp.year = 2015
        dateComp.month = 10
        dateComp.day = 18
        dateComp.hour = 20
        dateComp.minute = 23
        dateComp.timeZone = NSTimeZone.systemTimeZone()
        
        let calender: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let date:NSDate = calender.dateFromComponents(dateComp)!
        
        let notification:UILocalNotification = UILocalNotification()
        notification.category = "FIRST_CATEGORY"
        notification.alertBody = "Hi, i am a notification"
        notification.fireDate = date
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }

    
 /*   func drawAShape(notification:NSNotification){
        let view:UIView = UIView(frame: CGRectMake(10, 10, 10, 100))
        view.backgroundColor  = UIColor.redColor()
        
        self.view.addSubview(view)
    }
    
    func showAMessage(notification:NSNotification){
        let message: UIAlertController = UIAlertController(title: "A notification Message", message: "Hello there", preferredStyle: UIAlertControllerStyle.Alert)
        message.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(message, animated: true, completion: nil)
    }
    */
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

