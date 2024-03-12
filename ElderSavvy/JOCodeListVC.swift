//
//  JOCodeListVC.swift
//  ElderSavvy
//
//  Created by jodielin on 2024/3/11.
//

import UIKit

class JOCodeListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func touchWechatPay(_ sender: Any) {
        performSegue(withIdentifier: "toPayimage", sender: "toWechatPay")
    }
    
    @IBAction func touchAliPay(_ sender: Any) {
        performSegue(withIdentifier: "toPayimage", sender: "toAliPay")
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPayimage" {
            let detailTypeStr:String = sender as! String
                if let destinationVC = segue.destination as? JOWechatTapVC {
                    destinationVC.detailType = detailTypeStr
                }
            }
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
