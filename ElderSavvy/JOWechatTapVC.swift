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
        
        if indexImgValue == 1001 {
            self.navigationController?.popViewController(animated: false)
            return
        }
        
        if detailType == "wechatVideo"{
            if indexImgValue == 0 {
                indexname = "wVideochat1"
                speakIndexStr(indexStr: "点击聊天框")
                
            }else if indexImgValue == 1{
                indexname = "wVideochat2"
                speakIndexStr(indexStr: "点击加号")
                
            }else if indexImgValue == 2{
                indexname = "wVideochat3"
                speakIndexStr(indexStr: "点击视频通话")
                
            }else if indexImgValue == 3{
                indexname = "wVideochat4"
                indexImgValue = 1000
                
            }
        }else if detailType == "wechatVoice"{
            if indexImgValue == 0 {
                indexname = "wVoicechat1"
                speakIndexStr(indexStr: "点击聊天框")
                
            }else if indexImgValue == 1{
                indexname = "wVoicechat2"
                speakIndexStr(indexStr: "点击加号")
                
            }else if indexImgValue == 2{
                indexname = "wVoicechat3"
                speakIndexStr(indexStr: "点击语音通话")
                
            }else if indexImgValue == 3{
                indexname = "wVoicechat4"
                indexImgValue = 1000
                
            }
        }else if detailType == "wechatTransfer"{
            if indexImgValue == 0 {
                indexname = "wTransfer1"
                speakIndexStr(indexStr: "点击转账对象的对话框")
                
            }else if indexImgValue == 1{
                indexname = "wTransfer2"
                speakIndexStr(indexStr: "点击加号")
                
            }else if indexImgValue == 2{
                indexname = "wTransfer3"
                speakIndexStr(indexStr: "选择转帐")
                
            }else if indexImgValue == 3{
                indexname = "wTransfer4"
                speakIndexStr(indexStr: "输入转账金额后点击转账")
                
            }else if indexImgValue == 4{
                indexname = "wTransfer5"
                speakIndexStr(indexStr: "输入支付密码")
                indexImgValue = 1000
            }
        }else if detailType == "wechatScan"{
            if indexImgValue == 0 {
                indexname = "wScan1"
                speakIndexStr(indexStr: "点击右上角加号")
                
            }else if indexImgValue == 1{
                indexname = "wScan2"
                speakIndexStr(indexStr: "点击扫一扫")
                
            }else if indexImgValue == 2{
                indexname = "wScan3"
                indexImgValue = 1000
            }
        }else if detailType == "wechatOpenPay"{
            if indexImgValue == 0 {
                indexname = "wPay1"
                speakIndexStr(indexStr: "点击右上角加号")
                
            }else if indexImgValue == 1{
                indexname = "wPay2"
                speakIndexStr(indexStr: "点击收付款")
                
            }else if indexImgValue == 2{
                indexname = "wPay3"
                indexImgValue = 1000
            }
        }else if detailType == "aliTransfer"{
            if indexImgValue == 0 {
                indexname = "aliTransfer1"
                speakIndexStr(indexStr: "点击转账")
                
            }else if indexImgValue == 1{
                indexname = "aliTransfer2"
                speakIndexStr(indexStr: "输入转账对象手机号")
                
            }else if indexImgValue == 2{
                indexname = "aliTransfer3"
                speakIndexStr(indexStr: "选择转账对象")
                
            }else if indexImgValue == 3{
                indexname = "aliTransfer4"
                speakIndexStr(indexStr: "输入转账金额")
                indexImgValue = 1000
            }
        }else if detailType == "aliScan"{
            if indexImgValue == 0 {
                indexname = "aliScan1"
                speakIndexStr(indexStr: "点击扫一扫")
                
            }else if indexImgValue == 1{
                indexname = "aliScan2"
                indexImgValue = 1000
            }
        }else if detailType == "aliPay"{
            if indexImgValue == 0 {
                indexname = "aliPay1"
                speakIndexStr(indexStr: "点击付钱或收钱")
                
            }else if indexImgValue == 1{
                indexname = "aliPay2"
                indexImgValue = 1000
            }
        }else if detailType == "toWechatPay"{
            indexname = "wPay3"
            speakIndexStr(indexStr: "微信收付款")
        }else if detailType == "toAliPay"{
            indexname = "aliPay2"
            speakIndexStr(indexStr: "支付宝收付款")
        }
        
        backImgView.image = UIImage(named: indexname)
        indexImgValue! += 1
    }
    
    func speakIndexStr(indexStr: String) {
        JOSpeechObject.shared.speakIndexStr(indexStr: indexStr)
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
