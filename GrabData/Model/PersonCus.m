//
//  PersonCus.m
//  GrabData
//
//  Created by iOSBacon on 16/10/19.
//  Copyright © 2016年 iOSBacon. All rights reserved.
//

#import "PersonCus.h"

@implementation PersonCus

- (NSString *)description {
    return [NSString stringWithFormat:@"the age of %@ is %@", self.name, self.age];
}

@end
