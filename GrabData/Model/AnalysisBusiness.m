//
//  AnalysisBusiness.m
//  GrabData
//
//  Created by iOSBacon on 16/10/21.
//  Copyright © 2016年 iOSBacon. All rights reserved.
//

#import "AnalysisBusiness.h"

@implementation AnalysisBusiness

+ (NSArray <NSString *> *)getUrlAnalyseH5code:(NSString *)h5Code {
    NSError * error = nil;
    NSAssert(h5Code != nil, @"参数不能为空");
    NSRegularExpression * regular = [[NSRegularExpression alloc] initWithPattern:@"(((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?))|((https?|ftp|news)://)?([a-z]([a-z0-9\\-]*[\\.。])+([a-z]{2}|aero|arpa|biz|com|coop|edu|gov|info|int|jobs|mil|museum|name|nato|net|org|pro|travel)|(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]))(/[a-z0-9_\\-\\.~]+)*(/([a-z0-9_\\-\\.]*)(\\?[a-z0-9+_\\-\\.%=&]*)?)?(#[a-z][a-z0-9_]*)?$" options:NSRegularExpressionCaseInsensitive error:&error];
    if (error) {
        NSLog(@"error = %@",error);
    }
    NSArray <NSTextCheckingResult *> * result = [regular matchesInString:h5Code options:NSMatchingWithTransparentBounds range:NSMakeRange(0, h5Code.length)];
    if (result.count > 0) {
        NSMutableArray <NSString *> * muArr = [NSMutableArray new];
        for (NSTextCheckingResult * tmpRes in result) {
            [muArr addObject:[h5Code substringWithRange:tmpRes.range]];
        }
        return muArr;
    } else {
        return nil;
    }
}

@end

/**
 *  原始版本
 */
//REGULAREXPRESSION(URLRegularExpression,@"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)")

/**
 *  第二版
 */
//REGULAREXPRESSION(URLRegularExpression,@"((https?|ftp|news)://)?([a-z]([a-z0-9\\-]*[\\.。])+([a-z]{2}|aero|arpa|biz|com|coop|edu|gov|info|int|jobs|mil|museum|name|nato|net|org|pro|travel)|(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]))(/[a-z0-9_\\-\\.~]+)*(/([a-z0-9_\\-\\.]*)(\\?[a-z0-9+_\\-\\.%=&]*)?)?(#[a-z][a-z0-9_]*)?$")

/**
 *  第三版
 */
//REGULAREXPRESSION(URLRegularExpression,@"(((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?))|((https?|ftp|news)://)?([a-z]([a-z0-9\\-]*[\\.。])+([a-z]{2}|aero|arpa|biz|com|coop|edu|gov|info|int|jobs|mil|museum|name|nato|net|org|pro|travel)|(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]))(/[a-z0-9_\\-\\.~]+)*(/([a-z0-9_\\-\\.]*)(\\?[a-z0-9+_\\-\\.%=&]*)?)?(#[a-z][a-z0-9_]*)?$")
