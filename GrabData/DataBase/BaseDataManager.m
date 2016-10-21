//
//  BaseDataManager.m
//  GrabData
//
//  Created by iOSBacon on 16/10/21.
//  Copyright © 2016年 iOSBacon. All rights reserved.
//

#import "BaseDataManager.h"
#import "MiddleUrlModel.h"

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

- (BOOL) deleteUrlModel:(MiddleUrlModel *)urlModel {
    NSFetchRequest * bacFetch = [[NSFetchRequest alloc] init];
    bacFetch.entity = self.entityDescription;
    bacFetch.predicate = [NSPredicate predicateWithFormat:@" url = %@", urlModel.url];
    NSError *error = nil;
    NSArray *fetchedObjects = [self.moc executeFetchRequest:bacFetch error:&error];
    if (fetchedObjects == nil) {
        NSLog(@"Unresolved saveError %@, %@", error, [error userInfo]);
        return NO;
    } else {
        if (fetchedObjects.count > 0) {
            for (NSManagedObject * manaObject in fetchedObjects) {
                [self.moc deleteObject:manaObject];
            }
            return [self save];
        }
        return NO;
    }
}

- (NSArray <MiddleUrlModel *> *)getDataWithLimit:(NSInteger)limit {
    NSFetchRequest * bacFetch = [[NSFetchRequest alloc] init];
    if (limit > 0) {
        [bacFetch setFetchLimit:limit];
    }
    bacFetch.entity = self.entityDescription;
    NSError *error = nil;
    NSArray *fetchedObjects = [self.moc executeFetchRequest:bacFetch error:&error];
    if (fetchedObjects == nil && error != nil) {
        NSLog(@"Unresolved saveError %@, %@", error, [error userInfo]);
    } else {
        if (fetchedObjects.count > 0) {
            NSMutableArray * muArr = [NSMutableArray new];
            for (id objBac in fetchedObjects) {
                if ([objBac respondsToSelector:@selector(url)]) {
                    [muArr addObject:[MiddleUrlModel modelWithUrl:[objBac performSelector:@selector(url)]]];
                }
            }
            return muArr;
        }
    }
    return nil;
}

- (MiddleUrlModel *)getOneUrl {
    return [self getDataWithLimit:1].firstObject;
}

@end
