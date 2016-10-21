//
//  MiddleUrlModel.m
//  GrabData
//
//  Created by iOSBacon on 16/10/19.
//  Copyright © 2016年 iOSBacon. All rights reserved.
//

#import "MiddleUrlModel.h"

@implementation MiddleUrlModel

- (instancetype)initWithUrl:(NSString *)url{
    self = [super init];
    if (self) {
        _url = url;
    }
    return self;
}

+ (instancetype)modelWithUrl:(NSString *)url {
    return [[self alloc] initWithUrl:url];
}

@end
