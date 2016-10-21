//
//  UnVisitedManager.h
//  GrabData
//
//  Created by iOSBacon on 16/10/19.
//  Copyright © 2016年 iOSBacon. All rights reserved.
//

#import "BaseDataManager.h"

@class MiddleUrlModel;

@interface UnVisitedManager : BaseDataManager

+ (instancetype)sharedUnVisitedManager;

- (BOOL) insertUrlModel:(MiddleUrlModel *)urlModel;

@end
