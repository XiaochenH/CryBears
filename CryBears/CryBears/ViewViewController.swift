//
//  ViewViewController.swift
//  CryBears
//
//  Created by Yunfang Xiao on 11/28/18.
//  Copyright © 2018 韩笑尘. All rights reserved.
//

import UIKit
import Firebase

class ViewViewController: UIViewController {
    
    

    @IBOutlet weak var textfield: UITextView!
    
    var labelText: String?
    var ref: DatabaseReference?
    var postid: String?
    
    @IBAction func like(_ sender: Any) {
        ref = Database.database().reference()
        
        //ref?.child("Posts").child(postid).updateChildValues(["likes": 2])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textfield.text = labelText

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
