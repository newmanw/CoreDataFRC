//
//  Report.h
//  CoreDataTest
//
//  Created by William Newman on 1/9/15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Report : NSManagedObject

@property (nonatomic, retain) NSNumber * dirty;
@property (nonatomic, retain) NSDate * timestamp;

@end
