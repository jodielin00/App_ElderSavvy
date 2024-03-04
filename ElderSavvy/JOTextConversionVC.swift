//
//  JOTextConversionVC.swift
//  ElderSavvy
//
//  Created by jodielin on 2024/3/1.
//

import UIKit

class JOTextConversionVC: UIViewController {
    @IBOutlet weak var inputTF: UITextView!
    
    @IBOutlet weak var outputTF: UITextView!
    
    var indexIFlySpeech:IFlySpeechSynthesizer!
    var indexIFlySpeechRecognizer:IFlySpeechRecognizer!
    var speakStr:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        speakStr = ""
        indexIFlySpeechRecognizer = IFlySpeechRecognizer.sharedInstance()
        //设置识别参数
        //设置为听写模式
        indexIFlySpeechRecognizer.setParameter("iat", forKey: IFlySpeechConstant.ifly_DOMAIN())
        
        //asr_audio_path 是录音文件名，设置value为nil或者为空取消保存，默认保存目录在Library/cache下。
        indexIFlySpeechRecognizer .setParameter("iat.pcm", forKey: IFlySpeechConstant.asr_AUDIO_PATH())

        //    https://www.xfyun.cn/doc/asr/voicedictation/iOS-SDK.html#_3、常用参数说明
        //        开始录入音频后，音频前面部分最长静音时长，取值范围[0,10000ms]，默认值5000ms
        indexIFlySpeechRecognizer.setParameter("10000", forKey: IFlySpeechConstant.vad_BOS())
//        开始录入音频后，音频后面部分最长静音时长，取值范围[0,10000ms]，默认值1800ms。
        indexIFlySpeechRecognizer.setParameter("10000", forKey: IFlySpeechConstant.vad_EOS())
        indexIFlySpeechRecognizer.delegate = self
        // Do any additional setup after loading the view.
    }
    @IBAction func convertToVoice(_ sender: Any) {
        if inputTF.text.count > 0{
            speakIndexStr(indexStr: inputTF.text)
        }
    }
    

    
    @IBAction func convertToText(_ sender: Any) {
        outputStr()
    }
    
    @IBAction func overVoice(_ sender: Any) {
        if indexIFlySpeechRecognizer.isListening {
            indexIFlySpeechRecognizer.stopListening()
        }
    }
    
    
    func speakIndexStr(indexStr: String) {
        //获取语音合成单例
        indexIFlySpeech = IFlySpeechSynthesizer.sharedInstance()
        if indexIFlySpeech.isSpeaking{
            indexIFlySpeech.stopSpeaking()
            print("正在播放，申请停止播放")
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
    
    func outputStr(){
        speakStr = ""
        //启动识别服务
        if indexIFlySpeechRecognizer.isListening {
            indexIFlySpeechRecognizer.stopListening()
        }
        indexIFlySpeechRecognizer.startListening()
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

extension JOTextConversionVC:IFlySpeechSynthesizerDelegate,IFlySpeechRecognizerDelegate{
   
    func onCompleted(_ error: IFlySpeechError!) {
//        print("错误：合成结束")
    }
    
    func onSpeakBegin() {
//        print("合成开始")
    }
    
    func onBufferProgress(_ progress: Int32, message msg: String!) {
//        print("//合成缓冲进度")
    }
    //合成播放进度
    func onSpeakProgress(_ progress: Int32, beginPos: Int32, endPos: Int32) {
        if progress == 100{
//            print("播放完成")
        }
    }
    
    //语音转化
    func onResults(_ results: [Any]!, isLast: Bool) {
//        print("jieshu")
//        print(results)
//        print(isLast)
//        let indexresultAry:Array = results
    
        var indexStr = JOConvertTool.convertAry(toStr: results)
        speakStr = speakStr.appending(indexStr)
        outputTF.text = speakStr
//        var indexi = 0
//        for indexDic:Dictionary in indexresultAry{
//            let indexAry:Array = indexDic["ws"]
//            for indexDic in indexAry{
//                let indexAry:Array =
//            }
//        }
        
        
    }
    
    //停止录音回调
    func onEndOfSpeech() {
        
    }
    //开始录音回调
    func onBeginOfSpeech() {
        
    }
    //音量回调函数
    func onVolumeChanged(_ volume: Int32) {
        
    }
    //会话取消回调
    func onCancel() {
        
    }
}
