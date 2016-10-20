//
//  PersonDataManager.h
//  GrabData
//
//  Created by iOSBacon on 16/10/19.
//  Copyright © 2016年 iOSBacon. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PersonCus;
@class Person;

@interface PersonDataManager : NSObject

- (BOOL)insertPerson:(PersonCus *)person;

- (NSArray <PersonCus *> *)getAllPersons;

@end
