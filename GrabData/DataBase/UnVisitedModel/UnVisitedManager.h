//
//  UnVisitedManager.h
//  GrabData
//
//  Created by iOSBacon on 16/10/19.
//  Copyright © 2016年 iOSBacon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MiddleUrlModel;

@interface UnVisitedManager : NSObject

+ (instancetype)sharedUnVisitedManager;

- (BOOL) insertUrlModel:(MiddleUrlModel *)urlModel;

@end
