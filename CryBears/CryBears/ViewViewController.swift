//
//  ViewViewController.swift
//  CryBears
//
//  Created by Yunfang Xiao on 11/28/18.
//  Copyright © 2018 韩笑尘. All rights reserved.
//

import UIKit

class ViewViewController: UIViewController {

    @IBOutlet weak var textfield: UITextView!
    var labelText: String?
    @IBAction func like(_ sender: Any) {
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
