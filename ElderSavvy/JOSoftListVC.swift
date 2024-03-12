//
//  JOSoftListVC.swift
//  ElderSavvy
//
//  Created by jodielin on 2024/2/26.
//

import UIKit

class JOSoftListVC: UIViewController {
    var detailType:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "软件使用介绍"
        detailType = ""
        // Do any additional setup after loading the view.
//        JOWechatTapVC
    }
    
    @IBAction func wechatVideo(_ sender: Any) {
        detailType = "wechatVideo"
        performSegue(withIdentifier: "wechatTapVC", sender: nil)
    }
    
    @IBAction func wechatVoice(_ sender: Any) {
        detailType = "wechatVoice"
        performSegue(withIdentifier: "wechatTapVC", sender: nil)
    }
    
    @IBAction func wechatTransfer(_ sender: Any) {
        detailType = "wechatTransfer"
        performSegue(withIdentifier: "wechatTapVC", sender: nil)
    }
    
    @IBAction func wechatScan(_ sender: Any) {
        detailType = "wechatScan"
        performSegue(withIdentifier: "wechatTapVC", sender: nil)
    }
    
    
    @IBAction func wechatOpenPay(_ sender: Any) {
        detailType = "wechatOpenPay"
        performSegue(withIdentifier: "wechatTapVC", sender: nil)
    }
    
    @IBAction func aliTransfer(_ sender: Any) {
        detailType = "aliTransfer"
        performSegue(withIdentifier: "wechatTapVC", sender: nil)
    }
    
    @IBAction func aliScan(_ sender: Any) {
        detailType = "aliScan"
        performSegue(withIdentifier: "wechatTapVC", sender: nil)
    }
    
    @IBAction func aliOpenPay(_ sender: Any) {
        detailType = "aliPay"
        performSegue(withIdentifier: "wechatTapVC", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "wechatTapVC" {
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
