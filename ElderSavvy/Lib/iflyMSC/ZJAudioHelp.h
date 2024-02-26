 
#import <Foundation/Foundation.h>
 
#define SANDBOXCACHES(dir) [NSString stringWithFormat:@"%@/%@",[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject],dir]


#define MZ_IM_VOICE_PATH [NSString stringWithFormat:@"%@/",SANDBOXCACHES(@"Audio/voice")]

NS_ASSUME_NONNULL_BEGIN

@interface ZJAudioHelp : NSObject

+ (NSTimeInterval)getAudioDurationWithURL:(NSURL *)url;
/// 返回语音目录下的数据大小 单位是字节
+ (NSInteger)getVoiceFileSize;
/// 清除所有音频文件
+ (void)cleanVoiceFile;
/// 清除某条路径音频文件
+ (void)cleanVoiceFileWithPath:(NSString *)path;
/// 把声音转换为音量 使用了 IM demo 里的计算方式
+ (CGFloat)getVolumnFromDB:(CGFloat)dbValue;
/// 创建相应文件路径
+ (void)createVoiceFileWithPath:(NSString *)path;
@end

NS_ASSUME_NONNULL_END
