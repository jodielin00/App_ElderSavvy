//
//  JOAliUseVC.swift
//  ElderSavvy
//
//  Created by jodielin on 2024/3/21.
//

import UIKit

class JOAliUseVC: UIViewController {

    var detailType:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        detailType = ""
        self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func aliTransfer(_ sender: Any) {
        detailType = "aliTransfer"
        performSegue(withIdentifier: "toAliTapVC", sender: nil)
    }
    
    @IBAction func aliScan(_ sender: Any) {
        detailType = "aliScan"
        performSegue(withIdentifier: "toAliTapVC", sender: nil)
    }
    
    @IBAction func aliOpenPay(_ sender: Any) {
        detailType = "aliPay"
        performSegue(withIdentifier: "toAliTapVC", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAliTapVC" {
                if let destinationVC = segue.destination as? JOWechatTapVC {
                    destinationVC.detailType = detailType
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
