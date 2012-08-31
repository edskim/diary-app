//
//  DiaryEntryDataStore.h
//  diary
//
//  Created by Edward Kim on 8/30/12.
//  Copyright (c) 2012 AppAcademy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Entry;

@interface DiaryEntryDataStore : NSObject
+ (NSManagedObjectModel*)model;
+ (NSManagedObjectContext*)context;
+ (NSArray*)allEntries;
+ (Entry*)createEntry;
+ (void)save;
@end
