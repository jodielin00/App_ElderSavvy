//
//  JOSpeechObject.swift
//  ElderSavvy
//
//  Created by jodielin on 2024/3/10.
//

import UIKit

class JOSpeechObject: NSObject {
    var indexIFlySpeech:IFlySpeechSynthesizer!
    
    static let shared = JOSpeechObject()
       
       private override init() {
           // 初始化代码
           indexIFlySpeech = IFlySpeechSynthesizer.sharedInstance()
       }
       
       // 单例提供的功能方法
        func speakIndexStr(indexStr: String) {
           // 实现功能
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

extension JOSpeechObject:IFlySpeechSynthesizerDelegate{
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
