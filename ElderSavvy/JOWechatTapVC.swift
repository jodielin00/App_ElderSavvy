//
//  JOWechatTapVC.swift
//  ElderSavvy
//
//  Created by jodielin on 2024/3/3.
//

import UIKit

class JOWechatTapVC: UIViewController {

    @IBOutlet weak var backImgView: UIImageView!
    
    @IBOutlet weak var coverView: UIView!
    
    @IBOutlet weak var redRemindKuangImgV: UIView!
    
    var indexImgValue:Int?
    var detailType:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indexImgValue = 0;
        redRemindKuangImgV.layer.borderWidth = 3;
        redRemindKuangImgV.layer.borderColor=UIColor.red.cgColor
        redRemindKuangImgV.isHidden = true
        let recordTap = UITapGestureRecognizer(target: self, action:#selector(touchRemind(tap:)));
        coverView.addGestureRecognizer(recordTap)
        setUpImgWithIndex(indexValue: 0)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @objc func touchRemind(tap: UITapGestureRecognizer) {
       
        
       setUpImgWithIndex(indexValue: 0)
        
    }

    func setUpImgWithIndex(indexValue:Int){
        let width = CGRectGetWidth(coverView.frame)
        var indexname = ""
        if detailType == "wechatVideo"{
            if indexImgValue == 0 {
                indexname = "wevideo01"
                
            }else if indexImgValue == 1{
                indexname = "wevideo02"
                
            }else if indexImgValue == 2{
                indexname = "wevideo03"
                
            }else if indexImgValue == 3{
                indexname = "wevideo04"
                indexImgValue = -1
                
            }
        }else if detailType == "wechatVoice"{
            if indexImgValue == 0 {
                indexname = "wevideo01"
                
            }else if indexImgValue == 1{
                indexname = "wevideo02"
                
            }else if indexImgValue == 2{
                indexname = "wevoice03"
                
            }else if indexImgValue == 3{
                indexname = "wevideo04"
                indexImgValue = -1
                
            }
        }else if detailType == "wechatTransfer"{
            if indexImgValue == 0 {
                indexname = "wevideo01"
                
            }else if indexImgValue == 1{
                indexname = "wevideo02"
                
            }else if indexImgValue == 2{
                indexname = "weTran03"
                
            }else if indexImgValue == 3{
                indexname = "weTran04"
                
            }else if indexImgValue == 4{
                indexname = "weTran05"
                indexImgValue = -1
            }
        }else if detailType == "wechatScan"{
            if indexImgValue == 0 {
                indexname = "wechatAdd"
                
            }else if indexImgValue == 1{
                indexname = "wechatScan"
                indexImgValue = -1
            }
        }else if detailType == "wechatOpenPay"{
            if indexImgValue == 0 {
                indexname = "weOpenPay"
                
            }else if indexImgValue == 1{
                indexname = "weOpenPay02"
                indexImgValue = -1
            }
        }
        
        backImgView.image = UIImage(named: indexname)
        indexImgValue! += 1
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
