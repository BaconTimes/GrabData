//
//  UnVisitedUrl+CoreDataProperties.m
//  GrabData
//
//  Created by iOSBacon on 16/10/19.
//  Copyright © 2016年 iOSBacon. All rights reserved.
//

#import "UnVisitedUrl+CoreDataProperties.h"

@implementation UnVisitedUrl (CoreDataProperties)

+ (NSFetchRequest<UnVisitedUrl *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"UnVisitedUrl"];
}

@dynamic url;

@end
