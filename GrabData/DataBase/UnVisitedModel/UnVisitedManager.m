//
//  UnVisitedManager.m
//  GrabData
//
//  Created by iOSBacon on 16/10/19.
//  Copyright © 2016年 iOSBacon. All rights reserved.
//

#import "UnVisitedManager.h"
#import "VisitedManager.h"
#import "CoreDataStorage.h"
#import "UnVisitedUrl+CoreDataClass.h"
#import "UnVisitedUrl+CoreDataProperties.h"
#import "MiddleUrlModel.h"

static UnVisitedManager * unVisitedManager;

@implementation UnVisitedManager

+ (instancetype)sharedUnVisitedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        unVisitedManager = [UnVisitedManager new];
    });
    return unVisitedManager;
}

- (NSEntityDescription *)visitedUrlEntity:(NSManagedObjectContext *)moc {
    return [NSEntityDescription entityForName:@"UnVisitedUrl" inManagedObjectContext:moc];
}

- (BOOL)save:(NSManagedObjectContext *)moc {
    NSError *saveError = nil;
    if (![moc save:&saveError]) {
        NSLog(@"Unresolved saveError %@, %@", saveError, [saveError userInfo]);
    }
    return (saveError == nil);
}

- (BOOL)isExistInVisited:(MiddleUrlModel *)urlModel {
    return [[VisitedManager new] isExistedModel:urlModel];
}

- (BOOL)isExistInUnVisited:(MiddleUrlModel *)urlModel {
    NSManagedObjectContext * moc = [[CoreDataStorage sharedInstance] managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [self visitedUrlEntity:moc];
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
        return (fetchedObjects > 0);
    }
    return YES;
}

- (BOOL) insertUrlModel:(MiddleUrlModel *)urlModel {
    if ([self isExistInVisited:urlModel] || [self isExistInUnVisited:urlModel]) {
        return YES;
    } else {
        NSManagedObjectContext * moc = [[CoreDataStorage sharedInstance] managedObjectContext];
        UnVisitedUrl * unVisitedModel = [(UnVisitedUrl *)[NSManagedObject alloc] initWithEntity:[self visitedUrlEntity:moc] insertIntoManagedObjectContext:moc];
        unVisitedModel.url = urlModel.url;
        return [self save:moc];
    }
}

@end
