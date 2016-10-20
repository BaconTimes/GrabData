//
//  CoreDataStorage.h
//  GrabData
//
//  Created by iOSBacon on 16/10/19.
//  Copyright © 2016年 iOSBacon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataStorage : NSObject

@property (nonatomic, strong) NSManagedObjectModel * managedObjectModel;

@property (nonatomic, strong) NSManagedObjectContext * managedObjectContext;

@property (nonatomic, strong) NSPersistentStoreCoordinator * persistentStoreCoordinator;

@property (nonatomic, copy) NSString * sourceUrl;

+ (CoreDataStorage *)sharedInstance;

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator;

- (NSManagedObjectModel *)managedObjectModel;

- (NSManagedObjectContext *)managedObjectContext;

- (void)freeDBResource;

@end
