// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SearchPerson.h instead.

#import <CoreData/CoreData.h>


extern const struct SearchPersonAttributes {
	__unsafe_unretained NSString *num;
	__unsafe_unretained NSString *searchPersonIds;
} SearchPersonAttributes;

extern const struct SearchPersonRelationships {
	__unsafe_unretained NSString *person;
} SearchPersonRelationships;

extern const struct SearchPersonFetchedProperties {
} SearchPersonFetchedProperties;

@class Person;




@interface SearchPersonID : NSManagedObjectID {}
@end

@interface _SearchPerson : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SearchPersonID*)objectID;





@property (nonatomic, strong) NSString* num;



//- (BOOL)validateNum:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* searchPersonIds;



//- (BOOL)validateSearchPersonIds:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *person;

- (NSMutableSet*)personSet;





@end

@interface _SearchPerson (CoreDataGeneratedAccessors)

- (void)addPerson:(NSSet*)value_;
- (void)removePerson:(NSSet*)value_;
- (void)addPersonObject:(Person*)value_;
- (void)removePersonObject:(Person*)value_;

@end

@interface _SearchPerson (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveNum;
- (void)setPrimitiveNum:(NSString*)value;




- (NSString*)primitiveSearchPersonIds;
- (void)setPrimitiveSearchPersonIds:(NSString*)value;





- (NSMutableSet*)primitivePerson;
- (void)setPrimitivePerson:(NSMutableSet*)value;


@end
