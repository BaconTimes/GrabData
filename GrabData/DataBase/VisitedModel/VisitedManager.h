//
//  VisitedManager.h
//  GrabData
//
//  Created by iOSBacon on 16/10/19.
//  Copyright © 2016年 iOSBacon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MiddleUrlModel;

@interface VisitedManager : NSObject

+ (VisitedManager *)sharedVisitedManager;

- (BOOL)insertUrl:(MiddleUrlModel *)urlModel;

- (BOOL)isExistedModel:(MiddleUrlModel *)urlModel;

@end
