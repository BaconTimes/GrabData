//
//  BaseDataManager.h
//  GrabData
//
//  Created by iOSBacon on 16/10/21.
//  Copyright © 2016年 iOSBacon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CoreDataStorage.h"

@class MiddleUrlModel;

@interface BaseDataManager : NSObject

@property (nonatomic, strong, readonly) NSEntityDescription * entityDescription;

@property (nonatomic, strong, readonly) NSManagedObjectContext * moc;

- (BOOL)save;

- (BOOL) deleteUrlModel:(MiddleUrlModel *)urlModel;

- (NSArray <MiddleUrlModel *> *)getDataWithLimit:(NSInteger)limit;

- (MiddleUrlModel *)getOneUrl;

@end
