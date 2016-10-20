//
//  VisitedUrl+CoreDataProperties.h
//  GrabData
//
//  Created by iOSBacon on 16/10/19.
//  Copyright © 2016年 iOSBacon. All rights reserved.
//

#import "VisitedUrl+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface VisitedUrl (CoreDataProperties)

+ (NSFetchRequest<VisitedUrl *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *url;

@end

NS_ASSUME_NONNULL_END
