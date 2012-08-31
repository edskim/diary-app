//
//  Entry.h
//  diary
//
//  Created by Edward Kim on 8/30/12.
//  Copyright (c) 2012 AppAcademy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Entry : NSManagedObject

@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSDate * date;

@end
