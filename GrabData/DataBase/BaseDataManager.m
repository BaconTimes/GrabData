//
//  BaseDataManager.m
//  GrabData
//
//  Created by iOSBacon on 16/10/21.
//  Copyright © 2016年 iOSBacon. All rights reserved.
//

#import "BaseDataManager.h"

@implementation BaseDataManager

- (NSManagedObjectContext *)moc {
    return [[CoreDataStorage sharedInstance] managedObjectContext];
}

- (BOOL)save {
    NSError *saveError = nil;
    if (![self.moc save:&saveError]) {
        NSLog(@"Unresolved saveError %@, %@", saveError, [saveError userInfo]);
    }
    return (saveError == nil);
}

@end
