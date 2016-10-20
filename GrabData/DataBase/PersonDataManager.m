//
//  PersonDataManager.m
//  GrabData
//
//  Created by iOSBacon on 16/10/19.
//  Copyright © 2016年 iOSBacon. All rights reserved.
//

#import "PersonDataManager.h"
#import "Person+CoreDataClass.h"
#import "Person+CoreDataProperties.h"
#import "CoreDataStorage.h"
#import "PersonCus.h"

@implementation PersonDataManager

- (NSEntityDescription *)personEntity:(NSManagedObjectContext *)moc {
    return [NSEntityDescription entityForName:@"Person" inManagedObjectContext:moc];
}

- (BOOL)save:(NSManagedObjectContext *)moc {
    NSError * saveError = nil;
    if (![moc save:&saveError]) {
        NSLog(@"Unresolved saveError %@, %@", saveError, [saveError userInfo]);
    }
    return (saveError == nil);
}

- (BOOL)insertPerson:(PersonCus *)person {
    NSManagedObjectContext * moc = [[CoreDataStorage sharedInstance] managedObjectContext];
    Person * tempPerson = (Person *)[[NSManagedObject alloc] initWithEntity:[self personEntity:moc] insertIntoManagedObjectContext:moc];
    tempPerson.age = person.age;
    tempPerson.name = person.name;
    return [self save:moc];
}

- (NSArray <PersonCus *> *)getAllPersons {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [self personEntity:[[CoreDataStorage sharedInstance] managedObjectContext]];
    [fetchRequest setEntity:entity];
    NSError *error = nil;
    NSArray *fetchedObjects = [[[CoreDataStorage sharedInstance] managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        NSLog(@"Unresolved saveError %@, %@", error, [error userInfo]);
        return nil;
    } else {
        NSMutableArray <PersonCus *> * muArr = [NSMutableArray new];
        for (Person * tp in fetchedObjects) {
            PersonCus * per = [PersonCus new];
            per.age = tp.age;
            per.name = tp.name;
            [muArr addObject:per];
        }
        return muArr;
    }
}

@end
