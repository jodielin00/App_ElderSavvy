//
//  JONewSwitchSoftVC.swift
//  ElderSavvy
//
//  Created by jodielin on 2024/3/20.
//

import UIKit

class JONewSwitchSoftVC: UIViewController {
    @IBOutlet weak var wechatImg: UIImageView!
    
    @IBOutlet weak var aliImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let recordTap = UITapGestureRecognizer(target: self, action:#selector(touchWechat(tap:)));
        wechatImg.addGestureRecognizer(recordTap);
        wechatImg.isUserInteractionEnabled = true
        
        aliImg.isUserInteractionEnabled = true
        let aliTap = UITapGestureRecognizer(target: self, action:#selector(touchAli(tap:)));
        aliImg.addGestureRecognizer(aliTap);
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc func touchWechat(tap: UITapGestureRecognizer) {
        JOSpeechObject.shared.speakIndexStr(indexStr: "点击微信")
        performSegue(withIdentifier: "toWechatDetailVC", sender: nil)
        
    }
    
    @objc func touchAli(tap: UITapGestureRecognizer) {
        JOSpeechObject.shared.speakIndexStr(indexStr: "点击支付宝")
        performSegue(withIdentifier: "toAliDetailVC", sender: nil)
        
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
