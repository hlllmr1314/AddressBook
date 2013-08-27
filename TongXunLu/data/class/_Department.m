// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Department.m instead.

#import "_Department.h"

const struct DepartmentAttributes DepartmentAttributes = {
	.id = @"id",
	.level = @"level",
	.name = @"name",
	.searchPersonIds = @"searchPersonIds",
};

const struct DepartmentRelationships DepartmentRelationships = {
	.parentDept = @"parentDept",
	.searchPersons = @"searchPersons",
	.subDepart = @"subDepart",
	.subPerson = @"subPerson",
};

const struct DepartmentFetchedProperties DepartmentFetchedProperties = {
};

@implementation DepartmentID
@end

@implementation _Department

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Department" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Department";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Department" inManagedObjectContext:moc_];
}

- (DepartmentID*)objectID {
	return (DepartmentID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic id;






@dynamic level;






@dynamic name;






@dynamic searchPersonIds;






@dynamic parentDept;

	

@dynamic searchPersons;

	
- (NSMutableSet*)searchPersonsSet {
	[self willAccessValueForKey:@"searchPersons"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"searchPersons"];
  
	[self didAccessValueForKey:@"searchPersons"];
	return result;
}
	

@dynamic subDepart;

	
- (NSMutableSet*)subDepartSet {
	[self willAccessValueForKey:@"subDepart"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"subDepart"];
  
	[self didAccessValueForKey:@"subDepart"];
	return result;
}
	

@dynamic subPerson;

	
- (NSMutableSet*)subPersonSet {
	[self willAccessValueForKey:@"subPerson"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"subPerson"];
  
	[self didAccessValueForKey:@"subPerson"];
	return result;
}
	






@end
