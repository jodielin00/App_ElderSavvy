
#import <Foundation/Foundation.h>


#ifndef weakify
    #if DEBUG
        #if __has_feature(objc_arc)
        #define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
        #else
        #define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
        #else
        #define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
        #endif
    #endif
#endif

#ifndef strongify
    #if DEBUG
        #if __has_feature(objc_arc)
        #define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
        #else
        #define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
        #else
        #define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
        #endif
    #endif
#endif


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ZJAudioRecorderEvent) {
     ZJAudioRecorderEventStart,
     ZJAudioRecorderEventFinish,
     ZJAudioRecorderEventPowerChange,
     ZJAudioRecorderEventDurantionChange
};


typedef NS_ENUM(NSUInteger, ZJAudioRecordError) {
     ZJAudioErrorRecordCreateFail,
     ZJAudioErrorRecordDurationTooShort,
     ZJAudioErrorRecordDurationTooLong,
     ZJAudioErrorRecordURLIsNil,
     ZJAudioErrorRecordUserDeny,
};


@class ZJAudioRecorder;

@protocol ZJAudioRecorderDelegate <NSObject>

@optional
/// 录音事件
- (void)zj_recorder:(ZJAudioRecorder *)recorder onEvent:(ZJAudioRecorderEvent)event;
/// 录音发生了错误
- (void)zj_recorder:(ZJAudioRecorder *)recorder onError:(ZJAudioRecordError)errorType;

@end

@interface ZJAudioRecorder : NSObject

@property (nonatomic, weak) id<ZJAudioRecorderDelegate> delegate;

@property (nonatomic, assign) float powerDB;
/// 当前录音路径
@property (nonatomic, strong, nullable, readonly) NSURL *currentURL;
/// 当前录音时长，并不准确
@property (nonatomic, assign, readonly) NSTimeInterval currentDuration;
/// 最大录音时长，默认值：60s
@property (nonatomic, assign) NSTimeInterval maxDuration;
/// 最短录音时长，默认值: 3s
@property (nonatomic, assign) NSTimeInterval minDuration;

/**
 在指定的 url 下开始录音，音频格式支持 aac

 @param url 音频文件保存的 url
 */
- (void)startRecordWithURL:(NSURL *)url;

- (void)stopRecord;

- (void)cancelRecord;

@end

NS_ASSUME_NONNULL_END
