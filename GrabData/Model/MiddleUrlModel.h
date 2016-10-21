//
//  MiddleUrlModel.h
//  GrabData
//
//  Created by iOSBacon on 16/10/19.
//  Copyright © 2016年 iOSBacon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MiddleUrlModel : NSObject

@property (nonatomic, strong) NSString * url;

- (instancetype)initWithUrl:(NSString *)url;

+ (instancetype)modelWithUrl:(NSString *)url;

@end
