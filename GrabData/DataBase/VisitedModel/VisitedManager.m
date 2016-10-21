//
//  VisitedManager.m
//  GrabData
//
//  Created by iOSBacon on 16/10/19.
//  Copyright © 2016年 iOSBacon. All rights reserved.
//

#import "VisitedManager.h"
#import "MiddleUrlModel.h"
#import "VisitedUrl+CoreDataClass.h"
#import "VisitedUrl+CoreDataProperties.h"
#import "CoreDataStorage.h"

static VisitedManager * visitedManager;

@implementation VisitedManager

+ (VisitedManager *)sharedVisitedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        visitedManager = [VisitedManager new];
    });
    return visitedManager;
}

- (NSEntityDescription *)visitedUrlEntity:(NSManagedObjectContext *)moc {
    return [NSEntityDescription entityForName:@"VisitedUrl" inManagedObjectContext:moc];
}

- (BOOL)save:(NSManagedObjectContext *)moc {
    NSError *saveError = nil;
    if (![moc save:&saveError]) {
        NSLog(@"Unresolved saveError %@, %@", saveError, [saveError userInfo]);
    }
    return (saveError == nil);
}

- (BOOL)isExistedModel:(MiddleUrlModel *)urlModel {
    NSManagedObjectContext * moc = [[CoreDataStorage sharedInstance] managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"VisitedUrl" inManagedObjectContext:moc];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"url = %@", urlModel.url];
    [fetchRequest setPredicate:predicate];
    // Specify how the fetched objects should be sorted
    
    NSError *error = nil;
    NSArray *fetchedObjects = [moc executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        NSLog(@"Unresolved saveError %@, %@", error, [error userInfo]);
        return NO;
    } else {
        return (fetchedObjects.count > 0);
    }
}

- (BOOL)insertUrl:(MiddleUrlModel *)urlModel {
    if ([self isExistedModel:urlModel]) {
        return NO;
    } else {
        NSManagedObjectContext * moc = [[CoreDataStorage sharedInstance] managedObjectContext];
        VisitedUrl * visitedSysModel = [(VisitedUrl *)[NSManagedObject alloc] initWithEntity:[self visitedUrlEntity:moc] insertIntoManagedObjectContext:moc];
        visitedSysModel.url = urlModel.url;
        return [self save:moc];
    }
}

@end
