// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Person.m instead.

#import "_Person.h"

const struct PersonAttributes PersonAttributes = {
	.chanyong = @"chanyong",
	.email = @"email",
	.firstPinyin = @"firstPinyin",
	.firstPinyin1 = @"firstPinyin1",
	.firstPinyin2 = @"firstPinyin2",
	.firstPinyinNum = @"firstPinyinNum",
	.firstPinyinNum1 = @"firstPinyinNum1",
	.firstPinyinNum2 = @"firstPinyinNum2",
	.homePhone = @"homePhone",
	.id = @"id",
	.personalCellPhone = @"personalCellPhone",
	.pinyin = @"pinyin",
	.pinyin1 = @"pinyin1",
	.pinyin2 = @"pinyin2",
	.pinyinNum = @"pinyinNum",
	.pinyinNum1 = @"pinyinNum1",
	.pinyinNum2 = @"pinyinNum2",
	.shortNum = @"shortNum",
	.shortNum2 = @"shortNum2",
	.title = @"title",
	.username = @"username",
	.virtualCellPhone = @"virtualCellPhone",
	.workCellPhone = @"workCellPhone",
	.workPhone2 = @"workPhone2",
	.workingPhone = @"workingPhone",
};

const struct PersonRelationships PersonRelationships = {
	.depart = @"depart",
	.superDeparts = @"superDeparts",
};

const struct PersonFetchedProperties PersonFetchedProperties = {
};

@implementation PersonID
@end

@implementation _Person

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Person";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Person" inManagedObjectContext:moc_];
}

- (PersonID*)objectID {
	return (PersonID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"chanyongValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"chanyong"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic chanyong;



- (BOOL)chanyongValue {
	NSNumber *result = [self chanyong];
	return [result boolValue];
}

- (void)setChanyongValue:(BOOL)value_ {
	[self setChanyong:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveChanyongValue {
	NSNumber *result = [self primitiveChanyong];
	return [result boolValue];
}

- (void)setPrimitiveChanyongValue:(BOOL)value_ {
	[self setPrimitiveChanyong:[NSNumber numberWithBool:value_]];
}





@dynamic email;






@dynamic firstPinyin;






@dynamic firstPinyin1;






@dynamic firstPinyin2;






@dynamic firstPinyinNum;






@dynamic firstPinyinNum1;






@dynamic firstPinyinNum2;






@dynamic homePhone;






@dynamic id;






@dynamic personalCellPhone;






@dynamic pinyin;






@dynamic pinyin1;






@dynamic pinyin2;






@dynamic pinyinNum;






@dynamic pinyinNum1;






@dynamic pinyinNum2;






@dynamic shortNum;






@dynamic shortNum2;






@dynamic title;






@dynamic username;






@dynamic virtualCellPhone;






@dynamic workCellPhone;






@dynamic workPhone2;






@dynamic workingPhone;






@dynamic depart;

	

@dynamic superDeparts;

	
- (NSMutableSet*)superDepartsSet {
	[self willAccessValueForKey:@"superDeparts"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"superDeparts"];
  
	[self didAccessValueForKey:@"superDeparts"];
	return result;
}
	






@end
