//
//  UnVisitedManager.m
//  GrabData
//
//  Created by iOSBacon on 16/10/19.
//  Copyright © 2016年 iOSBacon. All rights reserved.
//

#import "UnVisitedManager.h"
#import "VisitedManager.h"
#import "UnVisitedUrl+CoreDataClass.h"
#import "UnVisitedUrl+CoreDataProperties.h"
#import "MiddleUrlModel.h"

static UnVisitedManager * _unVisitedManager;

@interface UnVisitedManager ()

@end

@implementation UnVisitedManager

+ (instancetype)sharedUnVisitedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _unVisitedManager = [UnVisitedManager new];
    });
    return _unVisitedManager;
}

- (NSEntityDescription *)entityDescription {
    return [NSEntityDescription entityForName:@"UnVisitedUrl" inManagedObjectContext:self.moc];
}

- (BOOL)isExistInVisited:(MiddleUrlModel *)urlModel {
    return [[VisitedManager new] isExistedModel:urlModel];
}

- (BOOL)isExistInUnVisited:(MiddleUrlModel *)urlModel {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:self.entityDescription];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"url = %@", urlModel.url];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.moc executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        NSLog(@"Unresolved saveError %@, %@", error, [error userInfo]);
        return NO;
    } else {
        return (fetchedObjects.count > 0);
    }
    return YES;
}

- (BOOL) insertUrlModel:(MiddleUrlModel *)urlModel {
    if ([self isExistInVisited:urlModel] || [self isExistInUnVisited:urlModel]) {
        return YES;
    } else {
        UnVisitedUrl * unVisitedModel = [(UnVisitedUrl *)[NSManagedObject alloc] initWithEntity:self.entityDescription insertIntoManagedObjectContext:self.moc];
        unVisitedModel.url = urlModel.url;
        return [self save];
    }
}

@end
