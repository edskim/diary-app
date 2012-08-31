//
//  DiaryEntryDataStore.m
//  diary
//
//  Created by Edward Kim on 8/30/12.
//  Copyright (c) 2012 AppAcademy. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "DiaryEntryDataStore.h"
#import "Entry.h"

@implementation DiaryEntryDataStore

+ (NSManagedObjectModel*)model {
    static NSManagedObjectModel *diaryModel = nil;
    if (!diaryModel) {
        diaryModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    }
    return diaryModel;
}

+ (NSManagedObjectContext*)context {
    static NSManagedObjectContext *diaryContext = nil;
    if (!diaryContext) {
        NSArray* documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
        NSString* documentDirectory = [documentDirectories objectAtIndex:0];
        
        NSURL* storeURL = [NSURL fileURLWithPath:[documentDirectory stringByAppendingString:@"diaryStore.data"]];
        
        //set up the model with all entries setup in this bundle
        NSPersistentStoreCoordinator* psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[DiaryEntryDataStore model]];
        
        //create the sqlite database and add to persistent store coordinator
        NSError* err;
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&err]) {
            [NSException raise:@"Open failed!"
                        format:@"Reason: %@", [err localizedDescription]];
        } else {
            //create context and set persistent store coordinator
            diaryContext = [NSManagedObjectContext new];
            [diaryContext setPersistentStoreCoordinator:psc];
            
            // ???
            [diaryContext setUndoManager:nil];
        }
    }
    return diaryContext;
}

+ (NSArray*)allEntries {
    NSFetchRequest *req = [NSFetchRequest new];
    req.entity = [[DiaryEntryDataStore model].entitiesByName objectForKey:@"Entry"];
    
    NSError *err;
    NSArray *result = [[DiaryEntryDataStore context] executeFetchRequest:req error:&err];
    if (!result) {
        [NSException raise:@"Fetch failed!" format:@"Reason: %@", [err localizedDescription]];
    }
    return  result;
}

+ (Entry*)createEntry {
    Entry *entry = [NSEntityDescription insertNewObjectForEntityForName:@"Entry" inManagedObjectContext:[DiaryEntryDataStore context]];
    return entry;
}

+ (void)save {
    NSError *err;
    if (![[DiaryEntryDataStore context] save:&err]) {
        [NSException raise:@"Save failed!" format:@"Reason: %@", [err localizedDescription]];
    }
}

@end
