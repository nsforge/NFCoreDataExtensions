NFCoreDataExtensions
--------

NFCoreDataExtensions contains a number of helpful categories on Core Data classes. Most of the categories are on `NSManagedObjectContext`, but there are some on `NSFetchRequest` and `NSFetchedResultsController`. The aim behind NFCoreDataExtensions is to reduce the verbosity of typical Core Data usage, while remaining useful for the vast majority of Core Data use cases.

This was partly inspired by Matt Gallagher's [Core Data: one line fetch](http://cocoawithlove.com/2008/03/core-data-one-line-fetch.html) blog post, and by Austin Ziegler's [coredata-easyfetch](https://github.com/halostatue/coredata-easyfetch) library.


Usage
-------

To use NFCoreDataExtensions, simply add `NFCoreDataExtensions.h` and `NFCoreDataExtensions.m` to your Xcode project, then add the following line to your Prefix.pch:

	#import "NFCoreDataExtensions.h"
	
	
Examples
--------

Here is an example of how you would normally use Core Data to fetch for `Button` objects where `color` == 'Blue', sorted by `size`.

	NSManagedObjectContext *context = [self managedObjectContext];
	
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Button" inManagedObjectContext:context];

	NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
	[request setEntity:entity];
	
	NSString *color = @"Blue";
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"color == %@", color]
	
	NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"size" ascending:YES]];
	[request setSortDescriptors:sortDescriptors];
	
	NSError *error = nil;
	NSArray *buttons = [context executeFetchRequest:request error:&error];
	if (!buttons) {
		NSLog(@"Error occurred during Core Data fetch: %@", error);
	}
	
This is extremely verbose for an operation that you have to perform regularly in every Core Data app. Using NFCoreDataExtensions, here is how you would achieve the same thing:

	NSManagedObjectContext *context = [self managedObjectContext];
	NSString *color = @"Blue";
	
	NSArray *buttons = [context fetchObjectsForEntityName:@"Button" sortByKey:@"size" ascending:YES predicateFormat:@"color == %@", color];
	
Win!

Some other examples:

	NSManagedObjectContext *context = [self managedObjectContext];
	NSString *color = @"Blue";

	NSArray *allButtons = [context fetchObjectsForEntityName:@"Button"];
	NSArray *allButtonsSortedBySize = [context fetchObjectsForEntityName:@"Button" sortByKey:@"size" ascending:YES];
	NSArray *blueButtons = [context fetchObjectsForEntityName:@"Button" withPredicateFormat:@"color == %@", color];
	NSArray *blueButtonsSortedBySize = [context fetchObjectsForEntityName:@"Button" sortByKey:@"size" ascending:YES withPredicateFormat:@"color == %@", color];

You can also request single objects (these methods actually tell Core Data to only fetch one object, so they should be faster than selecting the first object after performing a request for multiple objects):

	Button *anyButton = [context fetchFirstObjectForEntityName:@"Button"];
	Button *anyBlueButton = [context fetchFirstObjectForEntityName:@"Button" withPredicateFormat:@"color == %@", color];
	Button *largestButton = [context fetchFirstObjectForEntityName:@"Button" sortByKey:@"size" ascending:NO];
	Button *largestBlueButton = [context fetchFirstObjectForEntityName:@"Button" sortByKey:@"size" ascending:NO withPredicateFormat:@"color == %@", color];
	
Sort Descriptors
-----

There are variants of each fetch method that allow you to specify Sort Descriptors with an array of `NSSortDescriptor` objects, or with sortByKey:ascending: arguments. There are also variants of the fetch methods without Sort Descriptors.

Predicates
-----

There are variants of each fetch method that allow you to specify the Predicate as either an `NSPredicate` object, or using a 'predicate format string' (you can use any format string here that you would use with `[NSPredicate predicateWithFormat:]`). There are also variants which don't specify a Predicate.

NSFetchedResultsController
-----

There is a convenience method, which, when used alongside the `-[NSManagedObjectContext fetchRequestForEntityName...]` methods, make setting up an `NSFetchedResultsController` very straightforward:

	NSManagedObjectContext *context = [self managedObjectContext];
	NSString *color = @"Blue";

	NSFetchRequest *request = [context fetchRequestForEntityName:@"Button" sortByKey:@"size" ascending:YES withPredicateFormat:@"color == %@", color];
	
	NSFetchedResultsController *frc = [NSFetchedResultsController fetchedResultsControllerWithFetchRequest:request
	 																				  managedObjectContext:context
																						sectionNameKeyPath:nil
																								 cacheName:nil];
	[frc performFetch];

