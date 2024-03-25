//
//  JOWechatUseVC.swift
//  ElderSavvy
//
//  Created by jodielin on 2024/3/21.
//

import UIKit

class JOWechatUseVC: UIViewController {
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
    
    @IBAction func wechatVideo(_ sender: Any) {
        detailType = "wechatVideo"
        performSegue(withIdentifier: "toWechatTapVC", sender: nil)
    }
    
    @IBAction func wechatVoice(_ sender: Any) {
        detailType = "wechatVoice"
        performSegue(withIdentifier: "toWechatTapVC", sender: nil)
    }
    
    @IBAction func wechatTransfer(_ sender: Any) {
        detailType = "wechatTransfer"
        performSegue(withIdentifier: "toWechatTapVC", sender: nil)
    }
    
    @IBAction func wechatScan(_ sender: Any) {
        detailType = "wechatScan"
        performSegue(withIdentifier: "toWechatTapVC", sender: nil)
    }
    
    
    @IBAction func wechatOpenPay(_ sender: Any) {
        detailType = "wechatOpenPay"
        performSegue(withIdentifier: "toWechatTapVC", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWechatTapVC" {
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
