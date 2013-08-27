// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SearchPerson.m instead.

#import "_SearchPerson.h"

const struct SearchPersonAttributes SearchPersonAttributes = {
	.num = @"num",
	.searchPersonIds = @"searchPersonIds",
};

const struct SearchPersonRelationships SearchPersonRelationships = {
	.person = @"person",
};

const struct SearchPersonFetchedProperties SearchPersonFetchedProperties = {
};

@implementation SearchPersonID
@end

@implementation _SearchPerson

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SearchPerson" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SearchPerson";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SearchPerson" inManagedObjectContext:moc_];
}

- (SearchPersonID*)objectID {
	return (SearchPersonID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic num;






@dynamic searchPersonIds;






@dynamic person;

	
- (NSMutableSet*)personSet {
	[self willAccessValueForKey:@"person"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"person"];
  
	[self didAccessValueForKey:@"person"];
	return result;
}
	






@end
