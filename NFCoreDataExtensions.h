//
//  NFCoreDataExtensions.h
//  
//
//  Created by Nick Forge on 9/05/11.
//  Copyright 2011 Nick Forge.
//
//	This code is released under the MIT License.
//

#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

@interface NSManagedObjectContext (NFCoreDataExtensions)

// This is a wrapper around -executeFetchRequest:error:. If there's an error,
// the error description will be sent to NSLog.

- (NSArray *)executeFetchRequest:(NSFetchRequest *)request;

// This is a wrapper around -save:. If there's an error, the error description
// will be sent to NSLog.

- (BOOL)save;

//----------------------------------
//
//	Creating NSFetchRequests
//
//----------------------------------

// No Predicate
- (NSFetchRequest *)fetchRequestForEntityName:(NSString *)entityName;
- (NSFetchRequest *)fetchRequestForEntityName:(NSString *)entityName sortByKey:(NSString *)key ascending:(BOOL)ascending;
- (NSFetchRequest *)fetchRequestForEntityName:(NSString *)entityName sortDescriptors:(NSArray *)sortDescriptors;

// NSPredicate
- (NSFetchRequest *)fetchRequestForEntityName:(NSString *)entityName withPredicate:(NSPredicate *)predicate;
- (NSFetchRequest *)fetchRequestForEntityName:(NSString *)entityName sortByKey:(NSString *)key ascending:(BOOL)ascending withPredicate:(NSPredicate *)predicate;
- (NSFetchRequest *)fetchRequestForEntityName:(NSString *)entityName sortDescriptors:(NSArray *)sortDescriptors withPredicate:(NSPredicate *)predicate;

// withPredicateFormat:
- (NSFetchRequest *)fetchRequestForEntityName:(NSString *)entityName withPredicateFormat:(NSString *)predicateFormat, ...;
- (NSFetchRequest *)fetchRequestForEntityName:(NSString *)entityName sortByKey:(NSString *)key ascending:(BOOL)ascending withPredicateFormat:(NSString *)predicateFormat, ...;
- (NSFetchRequest *)fetchRequestForEntityName:(NSString *)entityName sortDescriptors:(NSArray *)sortDescriptors withPredicateFormat:(NSString *)predicateFormat, ...;

// withPredicateFormat: (va_list variant)
- (NSFetchRequest *)fetchRequestForEntityName:(NSString *)entityName withPredicateFormat:(NSString *)predicateFormat arguments:(va_list)argList;
- (NSFetchRequest *)fetchRequestForEntityName:(NSString *)entityName sortByKey:(NSString *)key ascending:(BOOL)ascending withPredicateFormat:(NSString *)predicateFormat arguments:(va_list)argList;
- (NSFetchRequest *)fetchRequestForEntityName:(NSString *)entityName sortDescriptors:(NSArray *)sortDescriptors withPredicateFormat:(NSString *)predicateFormat arguments:(va_list)argList;


//----------------------------------
//
//	Fetching Without an Explicit NSFetchRequest
//
//----------------------------------

// Multi-object Fetches
- (NSArray *)fetchObjectsForEntityName:(NSString *)entityName;
- (NSArray *)fetchObjectsForEntityName:(NSString *)entityName sortByKey:(NSString *)key ascending:(BOOL)ascending;
- (NSArray *)fetchObjectsForEntityName:(NSString *)entityName sortDescriptors:(NSArray *)sortDescriptors;

- (NSArray *)fetchObjectsForEntityName:(NSString *)entityName withPredicate:(NSPredicate *)predicate;
- (NSArray *)fetchObjectsForEntityName:(NSString *)entityName sortByKey:(NSString *)key ascending:(BOOL)ascending withPredicate:(NSPredicate *)predicate;
- (NSArray *)fetchObjectsForEntityName:(NSString *)entityName sortDescriptors:(NSArray *)sortDescriptors withPredicate:(NSPredicate *)predicate;

- (NSArray *)fetchObjectsForEntityName:(NSString *)entityName withPredicateFormat:(NSString *)predicateFormat, ...;
- (NSArray *)fetchObjectsForEntityName:(NSString *)entityName sortByKey:(NSString *)key ascending:(BOOL)ascending withPredicateFormat:(NSString *)predicateFormat, ...;
- (NSArray *)fetchObjectsForEntityName:(NSString *)entityName sortDescriptors:(NSArray *)sortDescriptors withPredicateFormat:(NSString *)predicateFormat, ...;


// Single-object Fetches
- (id)fetchFirstObjectForEntityName:(NSString *)entityName;
- (id)fetchFirstObjectForEntityName:(NSString *)entityName sortByKey:(NSString *)key ascending:(BOOL)ascending;
- (id)fetchFirstObjectForEntityName:(NSString *)entityName sortDescriptors:(NSArray *)sortDescriptors;

- (id)fetchFirstObjectForEntityName:(NSString *)entityName withPredicate:(NSPredicate *)predicate;
- (id)fetchFirstObjectForEntityName:(NSString *)entityName sortByKey:(NSString *)key ascending:(BOOL)ascending withPredicate:(NSPredicate *)predicate;
- (id)fetchFirstObjectForEntityName:(NSString *)entityName sortDescriptors:(NSArray *)sortDescriptors withPredicate:(NSPredicate *)predicate;

- (id)fetchFirstObjectForEntityName:(NSString *)entityName withPredicateFormat:(NSString *)predicateFormat, ...;
- (id)fetchFirstObjectForEntityName:(NSString *)entityName sortByKey:(NSString *)key ascending:(BOOL)ascending withPredicateFormat:(NSString *)predicateFormat, ...;
- (id)fetchFirstObjectForEntityName:(NSString *)entityName sortDescriptors:(NSArray *)sortDescriptors withPredicateFormat:(NSString *)predicateFormat, ...;

@end

@interface NSFetchRequest (NFCoreDataExtensions)

+ (NSFetchRequest *)fetchRequestWithEntityName:(NSString *)entityName inManagedObjectContext:(NSManagedObjectContext *)context;

@end

@interface NSFetchedResultsController (NFCoreDataExtensions)

+ (NSFetchedResultsController *)fetchedResultsControllerWithFetchRequest:(NSFetchRequest *)fetchRequest managedObjectContext:(NSManagedObjectContext *)context sectionNameKeyPath:(NSString *)keyPath cacheName:(NSString *)cacheName;

// This is a wrapper around -performFetch:.If there's an error,
// the error description will be sent to NSLog.

- (BOOL)performFetch;

@end
