//
//  ViewController.swift
//  ElderSavvy
//
//  Created by jodielin on 2024/2/25.
//

import UIKit


class ViewController: UIViewController {
    @IBOutlet weak var recordView: UIView!
    
    @IBOutlet weak var textConversionView: UIView!
    
    @IBOutlet weak var softUseView: UIView!
    
    @IBOutlet weak var codeView: UIView!
    
    @IBOutlet weak var addressView: UIView!
    
    @IBOutlet weak var emergencyCallView: UIView!
    
    var indexIFlySpeech:IFlySpeechSynthesizer!
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let recordTap = UITapGestureRecognizer(target: self, action:#selector(touchRecord(tap:)));
        recordView.addGestureRecognizer(recordTap);
        
        let textConversion = UITapGestureRecognizer(target: self, action:#selector(touchTextConversion(tap:)));
        textConversionView.addGestureRecognizer(textConversion);
        
        let touchSoftUse = UITapGestureRecognizer(target: self, action:#selector(touchSoftUse(tap:)));
        softUseView.addGestureRecognizer(touchSoftUse);
        
        let touchCode = UITapGestureRecognizer(target: self, action:#selector(touchCode(tap:)));
        codeView.addGestureRecognizer(touchCode);
        
        let touchAddress = UITapGestureRecognizer(target: self, action:#selector(touchAddress(tap:)));
        addressView.addGestureRecognizer(touchAddress);
        
        let emergencyCall = UITapGestureRecognizer(target: self, action:#selector(touchEmergencyCall(tap:)));
        emergencyCallView.addGestureRecognizer(emergencyCall);
    }
    
    @objc func touchRecord(tap: UITapGestureRecognizer) {
        //        let recordVC = JORecordVC()
        //        self.navigationController?.pushViewController(recordVC, animated: true)
        self.speakIndexStr(indexStr: "点击要事记录")
        performSegue(withIdentifier: "toRecordVC", sender: nil)
        
    }
    
    @objc func touchTextConversion(tap: UITapGestureRecognizer) {
        self.speakIndexStr(indexStr: "点击文字转换")
        performSegue(withIdentifier: "textConversion", sender: nil)
        
    }
    
    @objc func touchSoftUse(tap: UITapGestureRecognizer) {
        self.speakIndexStr(indexStr: "点击软件使用")
        performSegue(withIdentifier: "JOSoftList", sender: nil)
        
    }
    @objc func touchCode(tap: UITapGestureRecognizer) {
        self.speakIndexStr(indexStr: "点击二维码")
        performSegue(withIdentifier: "toRecordVC", sender: nil)
        
    }
    @objc func touchAddress(tap: UITapGestureRecognizer) {
        self.speakIndexStr(indexStr: "点击位置辅助")
        performSegue(withIdentifier: "JOAddress", sender: nil)
        
    }
    
    @objc func touchEmergencyCall(tap: UITapGestureRecognizer) {
        self.speakIndexStr(indexStr: "点击紧急电话")
            let url = URL(string: "tel://\(10010)")!
            UIApplication.shared.open(url, options: [:])
        
    }
    
    func speakIndexStr(indexStr: String) {
        //获取语音合成单例
        indexIFlySpeech = IFlySpeechSynthesizer.sharedInstance()
        if indexIFlySpeech.isSpeaking{
            indexIFlySpeech.stopSpeaking()
//            print("正在播放，申请停止播放")
        }
        
        
        indexIFlySpeech.delegate = self
        //设置合成参数
        //设置在线工作方式
        indexIFlySpeech.setParameter(IFlySpeechConstant.type_CLOUD(), forKey:IFlySpeechConstant.engine_TYPE())
        //设置音量，取值范围 0~100
        indexIFlySpeech.setParameter("50", forKey:IFlySpeechConstant.volume())
        //发音人，默认为”xiaoyan”，可以设置的参数列表可参考“合成发音人列表”
        indexIFlySpeech.setParameter("xiaoyan", forKey: IFlySpeechConstant.voice_NAME())
        //保存合成文件名，如不再需要，设置为nil或者为空表示取消，默认目录位于library/cache下
    //    [_iFlySpeechSynthesizer setParameter:@" tts.pcm" forKey: [IFlySpeechConstant TTS_AUDIO_PATH]];
        //启动合成会话
        indexIFlySpeech.startSpeaking(indexStr)
    }
    
}

extension ViewController:IFlySpeechSynthesizerDelegate{
    func onCompleted(_ error: IFlySpeechError!) {
        print("错误：合成结束")
    }
    
    func onSpeakBegin() {
        print("合成开始")
    }
    
    func onBufferProgress(_ progress: Int32, message msg: String!) {
        print("//合成缓冲进度")
    }
    //合成播放进度
    func onSpeakProgress(_ progress: Int32, beginPos: Int32, endPos: Int32) {
        if progress == 100{
            print("播放完成")
        }
    }
}
