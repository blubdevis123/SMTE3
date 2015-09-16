//
//  AboutViewController.swift
//  Glow2015
//
//  Created by Fhict on 16/09/15.
//  Copyright (c) 2015 Fhict. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var tfShowTextField: UITextField!
    @IBAction func btShowTextField(sender: UIButton) {
        var alertView =
        UIAlertView(
            title: "Je bent een paashaas",
            message: tfShowTextField.text,
            delegate: nil,
            cancelButtonTitle: "Done!")
        alertView.show()
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
