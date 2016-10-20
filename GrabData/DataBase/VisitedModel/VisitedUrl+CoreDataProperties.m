//
//  VisitedUrl+CoreDataProperties.m
//  GrabData
//
//  Created by iOSBacon on 16/10/19.
//  Copyright © 2016年 iOSBacon. All rights reserved.
//

#import "VisitedUrl+CoreDataProperties.h"

@implementation VisitedUrl (CoreDataProperties)

+ (NSFetchRequest<VisitedUrl *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"VisitedUrl"];
}

@dynamic url;

@end
