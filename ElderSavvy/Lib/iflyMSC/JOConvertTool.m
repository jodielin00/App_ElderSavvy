//
//  JOConvertTool.m
//  ElderSavvy
//
//  Created by jodielin on 2024/3/1.
//

#import "JOConvertTool.h"

@implementation JOConvertTool
+(NSString*)convertAryToStr:(NSArray *)indexAry{
    NSString *indexStr = @"";
    for (NSDictionary *indexDic in indexAry) {
        NSString *indexKey = indexDic.allKeys[0];
        
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:[indexKey dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        
        NSArray *indexWS = dataDic[@"ws"];
        if ([indexWS isKindOfClass:[NSArray class]]) {
            for (NSDictionary *wsIndexDic in indexWS) {
                NSArray *indexCW = wsIndexDic[@"cw"];
                if ([indexCW isKindOfClass:[NSArray class]]) {
                    for (NSDictionary *cwIndexDic in indexCW) {
                        NSString *w = [NSString stringWithFormat:@"%@",cwIndexDic[@"w"]];
                        if (w.length) {
                            indexStr = [indexStr stringByAppendingString:w];
                        }
                    }
                }
            }
        }
    }
    return indexStr;
}
@end
