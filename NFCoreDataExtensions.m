//
//  NFCoreDataExtensions.m
//  
//
//  Created by Nick Forge on 9/05/11.
//  Copyright 2011 Nick Forge.
//
//	This code is released under the MIT License.
//

#import "NFCoreDataExtensions.h"

@implementation NSManagedObjectContext (NFCoreDataExtensions)

- (NSArray *)executeFetchRequest:(NSFetchRequest *)request
{
	NSError *error = nil;
	NSArray *results = [self executeFetchRequest:request error:&error];
	
	if (!results) {
		NSLog(@"Error occurred while performing Core Data Fetch Request: %@, %@", error, error.userInfo);
	}
	
	return results;
}

- (BOOL)save
{
	NSError *error = nil;
	BOOL result = [self save:&error];
	
	if (!result) {
		NSLog(@"Error occurred while performing Core Data Save: %@, %@", error, error.userInfo);
	}
	
	return result;
}

#pragma mark -
#pragma mark NSFetchRequest Constructors

#pragma mark -
#pragma mark Fetch Requests with No Predicate

- (NSFetchRequest *)fetchRequestForEntityName:(NSString *)entityName
{
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName inManagedObjectContext:self];
	
	return request;
}

- (NSFetchRequest *)fetchRequestForEntityName:(NSString *)entityName sortByKey:(NSString *)key ascending:(BOOL)ascending
{
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName inManagedObjectContext:self];
	
	request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:key ascending:ascending]];
	
	return request;
}

- (NSFetchRequest *)fetchRequestForEntityName:(NSString *)entityName sortDescriptors:(NSArray *)sortDescriptors
{
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName inManagedObjectContext:self];
	
	request.sortDescriptors = sortDescriptors;
	
	return request;
}

#pragma mark Fetch Requests with an NSPredicate

- (NSFetchRequest *)fetchRequestForEntityName:(NSString *)entityName withPredicate:(NSPredicate *)predicate
{
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName inManagedObjectContext:self];
	
	request.predicate = predicate;
	
	return request;
}

- (NSFetchRequest *)fetchRequestForEntityName:(NSString *)entityName sortByKey:(NSString *)key ascending:(BOOL)ascending withPredicate:(NSPredicate *)predicate
{
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName inManagedObjectContext:self];
	
	request.predicate = predicate;
	request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:key ascending:ascending]];
	
	return request;
}

- (NSFetchRequest *)fetchRequestForEntityName:(NSString *)entityName sortDescriptors:(NSArray *)sortDescriptors withPredicate:(NSPredicate *)predicate
{
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName inManagedObjectContext:self];
	
	request.predicate = predicate;
	request.sortDescriptors = sortDescriptors;
	
	return request;
}

#pragma mark Fetch Requests with a predicateFormat: Argument

- (NSFetchRequest *)fetchRequestForEntityName:(NSString *)entityName withPredicateFormat:(NSString *)predicateFormat, ...
{
	va_list argList;
	va_start(argList, predicateFormat);

	NSFetchRequest *request = [self fetchRequestForEntityName:entityName withPredicateFormat:predicateFormat arguments:argList];
	
	va_end(argList);
	
	return request;
}

- (NSFetchRequest *)fetchRequestForEntityName:(NSString *)entityName sortByKey:(NSString *)key ascending:(BOOL)ascending withPredicateFormat:(NSString *)predicateFormat, ...
{	
	va_list argList;
	va_start(argList, predicateFormat);
	
	NSFetchRequest *request = [self fetchRequestForEntityName:entityName sortByKey:key ascending:ascending withPredicateFormat:predicateFormat arguments:argList];

	va_end(argList);
	
	return request;
}

- (NSFetchRequest *)fetchRequestForEntityName:(NSString *)entityName sortDescriptors:(NSArray *)sortDescriptors withPredicateFormat:(NSString *)predicateFormat, ...
{
	va_list argList;
	va_start(argList, predicateFormat);
	
	NSFetchRequest *request = [self fetchRequestForEntityName:entityName sortDescriptors:sortDescriptors withPredicateFormat:predicateFormat arguments:argList];
	
	va_end(argList);
	
	return request;
}

#pragma mark Fetch Requests with a predicateFormat:arguments: va_list Argument

- (NSFetchRequest *)fetchRequestForEntityName:(NSString *)entityName withPredicateFormat:(NSString *)predicateFormat arguments:(va_list)argList
{
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName inManagedObjectContext:self];
	
	request.predicate = [NSPredicate predicateWithFormat:predicateFormat arguments:argList];
	
	return request;
}

- (NSFetchRequest *)fetchRequestForEntityName:(NSString *)entityName sortByKey:(NSString *)key ascending:(BOOL)ascending withPredicateFormat:(NSString *)predicateFormat arguments:(va_list)argList
{
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName inManagedObjectContext:self];
	
	request.predicate = [NSPredicate predicateWithFormat:predicateFormat arguments:argList];
	request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:key ascending:ascending]];
	
	return request;	
}

- (NSFetchRequest *)fetchRequestForEntityName:(NSString *)entityName sortDescriptors:(NSArray *)sortDescriptors withPredicateFormat:(NSString *)predicateFormat arguments:(va_list)argList
{
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName inManagedObjectContext:self];
	
	request.predicate = [NSPredicate predicateWithFormat:predicateFormat arguments:argList];
	request.sortDescriptors = sortDescriptors;
	
	return request;	
}

#pragma mark -
#pragma mark Fetching Multiple Objects

#pragma mark -
#pragma mark Fetch Multiple Objects with No Predicate

- (NSArray *)fetchObjectsForEntityName:(NSString *)entityName
{
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName inManagedObjectContext:self];
	
	return [self executeFetchRequest:request];
}

- (NSArray *)fetchObjectsForEntityName:(NSString *)entityName sortByKey:(NSString *)key ascending:(BOOL)ascending
{
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName inManagedObjectContext:self];
	
	request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:key ascending:ascending]];
	
	return [self executeFetchRequest:request];
}

- (NSArray *)fetchObjectsForEntityName:(NSString *)entityName sortDescriptors:(NSArray *)sortDescriptors
{
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName inManagedObjectContext:self];

	request.sortDescriptors = sortDescriptors;
	
	return [self executeFetchRequest:request];
}

#pragma mark Fetch Multiple Objects with an NSPredicate

- (NSArray *)fetchObjectsForEntityName:(NSString *)entityName withPredicate:(NSPredicate *)predicate
{
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName inManagedObjectContext:self];
	
	request.predicate = predicate;
	
	return [self executeFetchRequest:request];
}

- (NSArray *)fetchObjectsForEntityName:(NSString *)entityName sortByKey:(NSString *)key ascending:(BOOL)ascending withPredicate:(NSPredicate *)predicate
{
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName inManagedObjectContext:self];
	
	request.predicate = predicate;
	request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:key ascending:ascending]];
	
	return [self executeFetchRequest:request];
}

- (NSArray *)fetchObjectsForEntityName:(NSString *)entityName sortDescriptors:(NSArray *)sortDescriptors withPredicate:(NSPredicate *)predicate
{
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName inManagedObjectContext:self];
	
	request.predicate = predicate;
	request.sortDescriptors = sortDescriptors;
	
	return [self executeFetchRequest:request];
}

#pragma mark Fetch Multiple Objects with a predicateFormat: Argument

- (NSArray *)fetchObjectsForEntityName:(NSString *)entityName withPredicateFormat:(NSString *)predicateFormat, ...
{	
	va_list argList;
	va_start(argList, predicateFormat);
	
	NSFetchRequest *request = [self fetchRequestForEntityName:entityName withPredicateFormat:predicateFormat arguments:argList];
	
	va_end(argList);
	
	return [self executeFetchRequest:request];
}

- (NSArray *)fetchObjectsForEntityName:(NSString *)entityName sortByKey:(NSString *)key ascending:(BOOL)ascending withPredicateFormat:(NSString *)predicateFormat, ...
{
	va_list argList;
	va_start(argList, predicateFormat);
	
	NSFetchRequest *request = [self fetchRequestForEntityName:entityName sortByKey:key ascending:ascending withPredicateFormat:predicateFormat arguments:argList];
	
	va_end(argList);
	
	return [self executeFetchRequest:request];
}

- (NSArray *)fetchObjectsForEntityName:(NSString *)entityName sortDescriptors:(NSArray *)sortDescriptors withPredicateFormat:(NSString *)predicateFormat, ...
{
	va_list argList;
	va_start(argList, predicateFormat);

	NSFetchRequest *request = [self fetchRequestForEntityName:entityName sortDescriptors:sortDescriptors withPredicateFormat:predicateFormat arguments:argList];

	va_end(argList);
	
	return [self executeFetchRequest:request];
}


#pragma mark -
#pragma mark Fetching Single Objects

#pragma mark -
#pragma mark Fetch Single Object with No Predicate

- (id)fetchFirstObjectForEntityName:(NSString *)entityName
{
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName inManagedObjectContext:self];
	
	request.fetchLimit = 1;
	
	return [[self executeFetchRequest:request] lastObject];
}

- (id)fetchFirstObjectForEntityName:(NSString *)entityName sortByKey:(NSString *)key ascending:(BOOL)ascending
{
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName inManagedObjectContext:self];
	
	request.fetchLimit = 1;
	request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:key ascending:ascending]];
	
	return [[self executeFetchRequest:request] lastObject];
}

- (id)fetchFirstObjectForEntityName:(NSString *)entityName sortDescriptors:(NSArray *)sortDescriptors
{
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName inManagedObjectContext:self];
	
	request.fetchLimit = 1;
	request.sortDescriptors = sortDescriptors;
	
	return [[self executeFetchRequest:request] lastObject];
}

#pragma mark Fetch Single Object with an NSPredicate

- (id)fetchFirstObjectForEntityName:(NSString *)entityName withPredicate:(NSPredicate *)predicate
{
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName inManagedObjectContext:self];
	
	request.fetchLimit = 1;
	request.predicate = predicate;
	
	return [[self executeFetchRequest:request] lastObject];
}

- (id)fetchFirstObjectForEntityName:(NSString *)entityName sortByKey:(NSString *)key ascending:(BOOL)ascending withPredicate:(NSPredicate *)predicate
{
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName inManagedObjectContext:self];
	
	request.fetchLimit = 1;
	request.predicate = predicate;
	request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:key ascending:ascending]];
	
	return [[self executeFetchRequest:request] lastObject];
}

- (id)fetchFirstObjectForEntityName:(NSString *)entityName sortDescriptors:(NSArray *)sortDescriptors withPredicate:(NSPredicate *)predicate
{
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName inManagedObjectContext:self];
	
	request.fetchLimit = 1;
	request.predicate = predicate;
	request.sortDescriptors = sortDescriptors;
	
	return [self executeFetchRequest:request];
}

#pragma mark Fetch Single Object with a predicateFormat: Argument
// Fetch Single Objects with predicateFormat:
- (id)fetchFirstObjectForEntityName:(NSString *)entityName withPredicateFormat:(NSString *)predicateFormat, ...
{
	va_list argList;
	va_start(argList, predicateFormat);
	
	NSFetchRequest *request = [self fetchRequestForEntityName:entityName withPredicateFormat:predicateFormat arguments:argList];
	request.fetchLimit = 1;
	
	va_end(argList);	
	
	return [[self executeFetchRequest:request] lastObject];
}

- (id)fetchFirstObjectForEntityName:(NSString *)entityName sortByKey:(NSString *)key ascending:(BOOL)ascending withPredicateFormat:(NSString *)predicateFormat, ...
{	
	va_list argList;
	va_start(argList, predicateFormat);
	
	NSFetchRequest *request = [self fetchRequestForEntityName:entityName sortByKey:key ascending:ascending withPredicateFormat:predicateFormat arguments:argList];
	request.fetchLimit = 1;

	va_end(argList);	

	return [[self executeFetchRequest:request] lastObject];
}

- (id)fetchFirstObjectForEntityName:(NSString *)entityName sortDescriptors:(NSArray *)sortDescriptors withPredicateFormat:(NSString *)predicateFormat, ...
{
	va_list argList;
	va_start(argList, predicateFormat);
	
	NSFetchRequest *request = [self fetchRequestForEntityName:entityName sortDescriptors:sortDescriptors withPredicateFormat:predicateFormat arguments:argList];
	request.fetchLimit = 1;
	
	va_end(argList);	
	
	return [[self executeFetchRequest:request] lastObject];
}

@end


#pragma mark -


@implementation NSFetchRequest (NFCoreDataExtensions)

+ (NSFetchRequest *)fetchRequestWithEntityName:(NSString *)entityName inManagedObjectContext:(NSManagedObjectContext *)context
{
	NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
	fetchRequest.entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
	return fetchRequest;
}

@end


#pragma mark -


@implementation NSFetchedResultsController (NFCoreDataExtensions)

+ (NSFetchedResultsController *)fetchedResultsControllerWithFetchRequest:(NSFetchRequest *)aFetchRequest managedObjectContext:(NSManagedObjectContext *)aContext sectionNameKeyPath:(NSString *)aKeyPath cacheName:(NSString *)aCacheName
{
	return [[[NSFetchedResultsController alloc] initWithFetchRequest:aFetchRequest managedObjectContext:aContext sectionNameKeyPath:aKeyPath cacheName:aCacheName] autorelease];
}

- (BOOL)performFetch
{
	NSError *error = nil;
	BOOL result = [self performFetch:&error];

	if (!result) {
		NSLog(@"Error while performing Fetched Results Controller Fetch: %@ %@", error, error.userInfo);
	}
	
	return result;
}

@end


