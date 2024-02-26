 

#import "ZJAudioRecorder.h"
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import "ZJAudioHelp.h"

#define zj_IM_CHAT_RECODER_SEND_EVENT(event) \
if (self.delegate && [self.delegate respondsToSelector:@selector(zj_recorder:onEvent:)]) { \
[self.delegate zj_recorder:self onEvent:event];\
}

#define SEND_ERROR(error) \
if (self.delegate && [self.delegate respondsToSelector:@selector(zj_recorder:onError:)]) { \
[self.delegate zj_recorder:self onError:error];\
}

 

#pragma mark - Constant
const float kSampleRate         = 44100;
const int kPCMBitDepth          = 16;
const int kBitRate              = 64000;
const float kRecordTimeInterval = 0.2;
const int kMaxAudioSize         = 1024 * 1024 * 20;

#pragma mark - NSDictionary Category
@interface NSDictionary (ZJAudio)

+ (NSDictionary *)LPCMSetting;
+ (NSDictionary *)AACSetting;

@end

@implementation NSDictionary (ZJAudio)

+ (NSDictionary *)LPCMSetting {
    NSMutableDictionary *setting = @{}.mutableCopy;
    setting[AVFormatIDKey] = @(kAudioFormatLinearPCM);
    setting[AVSampleRateKey] = @(kSampleRate);
    setting[AVNumberOfChannelsKey] = @(2);
    setting[AVLinearPCMBitDepthKey] = @(kPCMBitDepth);
    return setting;
}

+ (NSDictionary *)AACSetting {
    NSMutableDictionary *setting = @{}.mutableCopy;
    setting[AVFormatIDKey] = @(kAudioFormatMPEG4AAC);
    setting[AVSampleRateKey] = @(kSampleRate);
    setting[AVNumberOfChannelsKey] = @(1);
    setting[AVLinearPCMBitDepthKey] = @(kPCMBitDepth);
    setting[AVEncoderBitRateKey] = @(kBitRate);
    return setting;
}

@end

void showTime(void (^block)(void)) {
    NSDate *start = [NSDate new];
     block();
    NSDate *stop = [NSDate new];
 
}


@interface ZJAudioRecorder () <AVAudioRecorderDelegate>

@property (nonatomic, strong) AVAudioRecorder *recorder;

@property (nonatomic, strong) NSTimer *recordTimer;

@end

@implementation ZJAudioRecorder


- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.minDuration = 1;
        self.maxDuration = 60;
        
        [self registerSystemNotification];
    }
    return self;
}

- (void)registerSystemNotification {
     [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleEnterBackgroundEvent)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
 }

- (void)startRecordWithURL:(NSURL *)url {
    if (url == nil) {
        SEND_ERROR(ZJAudioErrorRecordURLIsNil);
        return;
    }
    
     if (self.recorder.isRecording) {
        [self.recorder stop];
        [self deleteRecord];
    }
    
     AVAudioSession *session = AVAudioSession.sharedInstance;
     if (session.isInputAvailable == NO) {
        return;
    }
    
    AVAudioSessionRecordPermission permission = session.recordPermission;
    if (permission == AVAudioSessionRecordPermissionDenied) {
        // 被拒绝
        SEND_ERROR(ZJAudioErrorRecordUserDeny);
    } else {
        @weakify(self);
        [session requestRecordPermission:^(BOOL granted) {
            @strongify(self);
            [self handleRequestRecordPermission:granted URL:url];
        }];
    }
}

- (void)handleRequestRecordPermission:(BOOL)granted URL:(NSURL *)url {
    if (granted) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
             NSError *error;
            self.recorder = [[AVAudioRecorder alloc] initWithURL:url
            settings:[NSDictionary AACSetting]
            error:&error];
            if (self.recorder == nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    SEND_ERROR(ZJAudioErrorRecordCreateFail);
                });
                return;
            }
            self.recorder.delegate = self;
            self.recorder.meteringEnabled = YES;
            NSError *err = nil;
            AVAudioSession *session = [AVAudioSession sharedInstance];
            [session setCategory:AVAudioSessionCategoryPlayAndRecord withOptions:AVAudioSessionCategoryOptionDefaultToSpeaker|AVAudioSessionCategoryOptionAllowBluetooth|AVAudioSessionCategoryOptionAllowBluetoothA2DP error:&err];
            [session setActive:YES error:nil];
            if (err) {
                [self deleteRecord];
                dispatch_async(dispatch_get_main_queue(), ^{
                    SEND_ERROR(ZJAudioErrorRecordCreateFail);
                });
                return;
            }
            if ([self.recorder prepareToRecord] && [self.recorder record]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                     [self startRecordTimer];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"kAudioRecorderEventEnd" object:@(NO)];
                    zj_IM_CHAT_RECODER_SEND_EVENT(ZJAudioRecorderEventStart);
                });
            } else {
                [self deleteRecord];
                dispatch_async(dispatch_get_main_queue(), ^{
                    SEND_ERROR(ZJAudioErrorRecordCreateFail);
                });
            }
        });
    }
    else {
         dispatch_async(dispatch_get_main_queue(), ^{
            SEND_ERROR(ZJAudioErrorRecordUserDeny);
        });
    }
}

- (void)cancelRecord {
    [self.recorder stop];
    [self deleteRecord];
    [self stopRecordTimer];
}

- (void)stopRecord {
    if (self.recorder.isRecording) {
        [self.recorder stop];
    }
    [self stopRecordTimer];
}

- (void)startRecordTimer {
    [self stopRecordTimer];
    /// 用定时器获取平均音量
    self.recordTimer = [NSTimer scheduledTimerWithTimeInterval:kRecordTimeInterval
                                                        target:self
                                                      selector:@selector(handleRecordTimerEvent)
                                                      userInfo:nil
                                                       repeats:YES];
}

- (void)stopRecordTimer {
    if (self.recordTimer.isValid) {
        [self.recordTimer invalidate];
        self.recordTimer = nil;
    }
}

- (void)deleteRecord {
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.recorder.url.path]) {
        if (![self.recorder deleteRecording]) {
         }
    }
}


#pragma mark - Getter
- (NSURL *)currentURL {
    return self.recorder.url;
}

- (NSTimeInterval)currentDuration {
    if (self.recorder.isRecording) {
        return self.recorder.currentTime;
    }
    NSTimeInterval duration = [ZJAudioHelp getAudioDurationWithURL:self.currentURL];
    return duration;
}


#pragma mark - Target Action

- (void)handleRecordTimerEvent {
    if (!self.recorder.isRecording) {
        return;
    }
    
    if (self.recorder.currentTime > self.maxDuration) {
        [self stopRecord];
        return;
    }
    
    [self.recorder updateMeters];
    self.powerDB = [self.recorder averagePowerForChannel:0];

    dispatch_async(dispatch_get_main_queue(), ^{
        zj_IM_CHAT_RECODER_SEND_EVENT(ZJAudioRecorderEventPowerChange);
        zj_IM_CHAT_RECODER_SEND_EVENT(ZJAudioRecorderEventDurantionChange);
    });
    
}

- (void)handleEnterBackgroundEvent {
    NSInteger size = [ZJAudioHelp getVoiceFileSize];
    if (size > kMaxAudioSize) {
        [ZJAudioHelp cleanVoiceFile];
    }
}

#pragma mark - AVAudioRecorderDelegate
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
    if (flag) {
        NSTimeInterval duration = [ZJAudioHelp getAudioDurationWithURL:recorder.url];
         if (duration < self.minDuration) {
            [self deleteRecord];
            SEND_ERROR(ZJAudioErrorRecordDurationTooShort);
            return;
        }
         if (duration > self.maxDuration + 1) {
            // [recorder deleteRecording];
            dispatch_async(dispatch_get_main_queue(), ^{
                SEND_ERROR(ZJAudioErrorRecordDurationTooLong);
            });
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // 录制成功
             zj_IM_CHAT_RECODER_SEND_EVENT(ZJAudioRecorderEventFinish);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kAudioRecorderEventEnd" object:@(YES)];
        });

    }
}

- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error {
    [self stopRecord];
    [self deleteRecord];
}



@end


