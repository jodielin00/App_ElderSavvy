 
#import "ZJAudioHelp.h"
#import <AVFoundation/AVFoundation.h>

@implementation ZJAudioHelp

+ (NSTimeInterval)getAudioDurationWithURL:(NSURL *)url {
    if (!url || url.absoluteString.length <= 0) {
        return 0;
    }
    NSDictionary *options = @{AVURLAssetPreferPreciseDurationAndTimingKey: @(YES)};
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:options];
    return CMTimeGetSeconds(asset.duration);
}

+ (NSInteger)getVoiceFileSize {
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:MZ_IM_VOICE_PATH]) return 0;
    NSArray<NSString *> *subFiles = [manager subpathsAtPath:MZ_IM_VOICE_PATH];
    __block NSInteger size = 0;
    [subFiles enumerateObjectsUsingBlock:^(NSString *fileName, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *path = [MZ_IM_VOICE_PATH stringByAppendingPathComponent:fileName];
        NSError *err = nil;
        NSDictionary *dict = [manager attributesOfItemAtPath:path error:&err];
        NSNumber *fileSize = dict[NSFileSize];
        size += fileSize.integerValue;
    }];
    return size;
}

+ (void)cleanVoiceFile {
    [ZJAudioHelp cleanVoiceFileWithPath:MZ_IM_VOICE_PATH];
}

+ (CGFloat)getVolumnFromDB:(CGFloat)dbValue {
    dbValue = dbValue + 60;
    float index = 0;
    if (dbValue < 25){
        index = 1;
    } else{
        index = ceil((dbValue - 25) / 5.0) + 1;
    }
    return index;
}

+ (void)createVoiceFileWithPath:(NSString *)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    // fileExistsAtPath 判断一个文件或目录是否有效，isDirectory判断是否一个目录
    BOOL existed = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    NSLog(@"路径：%@",path);

    if ( !(isDir == YES && existed == YES) ) {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

+ (void)cleanVoiceFileWithPath:(NSString *)path {
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:path]) return;
    NSArray<NSString *> *subFiles = [manager subpathsAtPath:path];
    [subFiles enumerateObjectsUsingBlock:^(NSString *fileName, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *tempPath = [path stringByAppendingPathComponent:fileName];
        NSError *err = nil;
        [manager removeItemAtPath:tempPath error:&err];
    }];
}

@end
