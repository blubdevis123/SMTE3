//
//  DetailsViewController.swift
//  Surf(Assignment 3)
//
//  Created by Fhict on 17/09/15.
//  Copyright (c) 2015 Fhict. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbLife: UILabel!
    @IBOutlet weak var lbActiveYears: UILabel!
    @IBOutlet weak var lbCountryOfBirth: UILabel!
    @IBOutlet weak var tfComments: UITextView!

    var selectedPirate: Pirate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lbName.text = self.selectedPirate?.name
        self.lbLife.text = self.selectedPirate?.life
        self.lbActiveYears.text = self.selectedPirate?.years_active
        self.lbCountryOfBirth.text = self.selectedPirate?.country_of_origin
        self.tfComments.text = self.selectedPirate?.comments

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btBack(sender: AnyObject) {
        self.dismissViewControllerAnimated(true,completion:nil)
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
