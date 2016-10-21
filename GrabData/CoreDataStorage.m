//
//  CoreDataStorage.m
//  GrabData
//
//  Created by iOSBacon on 16/10/19.
//  Copyright © 2016年 iOSBacon. All rights reserved.
//

#import "CoreDataStorage.h"

@implementation CoreDataStorage

static CoreDataStorage * sharedInstance;

+ (CoreDataStorage *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CoreDataStorage alloc] init];
    });
    return sharedInstance;
}

- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator * coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    
    NSURL * modelUrl = [[NSBundle mainBundle] URLForResource:@"Wahaha" withExtension:@"momd"];
    if (modelUrl == nil) {
        modelUrl = [[NSBundle mainBundle] URLForResource:@"Wahaha" withExtension:@"mom"];
    }
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelUrl];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
//    NSString * docsPath = [self persistentStoreDirectory];
    NSString * dataBaseName = [NSString stringWithFormat:@"%@.sqlite",@"Wahaha"];
#if TARGET_IPHONE_SIMULATOR
    NSString * storePath = [@"/Users/iosbacon/Desktop/anotherGrab/GrabData" stringByAppendingPathComponent:dataBaseName]; //docsPath
#elif TARGET_OS_IPHONE
    NSString * storePath = [docsPath stringByAppendingPathComponent:dataBaseName]; //
#endif
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (storePath) {
        NSLog(@"the path of dataBase is %@", storePath);
        NSURL * storeUrl = [NSURL fileURLWithPath:storePath];
        NSDictionary * options = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                                  [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption,nil];
        NSError * error = nil;
        
        if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:options error:&error]) {
            NSLog(@"Unresolved error: %@, %@", error, [error userInfo]);
            abort();
        }
    } else {
        NSError * error = nil;
        [_persistentStoreCoordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:&error];
    }
    return _persistentStoreCoordinator;
}

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSString *)persistentStoreDirectory {
    NSArray * path = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString * basePath = path.count > 0 ? path.firstObject : NSTemporaryDirectory();
    basePath = [basePath stringByAppendingPathComponent:@"Wahaha"];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:basePath]) {
        [fileManager createDirectoryAtPath:basePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return basePath;
}

- (NSString *)dealSourceUrl {
    if (_sourceUrl == nil) {
        return nil;
    } else {
        NSString * sqliteName = [[_sourceUrl dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        NSMutableString * muStr = [NSMutableString stringWithString:sqliteName];
        [muStr replaceOccurrencesOfString:@"=" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, muStr.length)];
        return muStr;
    }
}

- (void)freeDBResource {
    _managedObjectContext = nil;
    _persistentStoreCoordinator = nil;
}
/*
 
 - (NSURL *)applicationDocumentsDirectory {
 // The directory the application uses to store the Core Data store file. This code uses a directory named "NXIN.adwa" in the application's documents directory.
 return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
 }
 
 - (NSManagedObjectModel *)managedObjectModel {
 // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
 if (_managedObjectModel != nil) {
 return _managedObjectModel;
 }
 NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"adwa" withExtension:@"momd"];
 _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
 return _managedObjectModel;
 }
 
 - (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
 // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
 if (_persistentStoreCoordinator != nil) {
 return _persistentStoreCoordinator;
 }
 
 // Create the coordinator and store
 
 _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
 NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"adwa.sqlite"];
 NSError *error = nil;
 NSString *failureReason = @"There was an error creating or loading the application's saved data.";
 if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
 // Report any error we got.
 NSMutableDictionary *dict = [NSMutableDictionary dictionary];
 dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
 dict[NSLocalizedFailureReasonErrorKey] = failureReason;
 dict[NSUnderlyingErrorKey] = error;
 error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
 // Replace this with code to handle the error appropriately.
 // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
 NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
 abort();
 }
 
 return _persistentStoreCoordinator;
 }
 
 
 - (NSManagedObjectContext *)managedObjectContext {
 // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
 if (_managedObjectContext != nil) {
 return _managedObjectContext;
 }
 
 NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
 if (!coordinator) {
 return nil;
 }
 _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
 [_managedObjectContext setPersistentStoreCoordinator:coordinator];
 return _managedObjectContext;
 }
 
 #pragma mark - Core Data Saving support
 
 - (void)saveContext {
 NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
 if (managedObjectContext != nil) {
 NSError *error = nil;
 if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
 // Replace this implementation with code to handle the error appropriately.
 // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
 NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
 abort();
 }
 }
 }

 */

@end
