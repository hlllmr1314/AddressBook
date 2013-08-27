// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Department.h instead.

#import <CoreData/CoreData.h>


extern const struct DepartmentAttributes {
	__unsafe_unretained NSString *id;
	__unsafe_unretained NSString *level;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *searchPersonIds;
} DepartmentAttributes;

extern const struct DepartmentRelationships {
	__unsafe_unretained NSString *parentDept;
	__unsafe_unretained NSString *searchPersons;
	__unsafe_unretained NSString *subDepart;
	__unsafe_unretained NSString *subPerson;
} DepartmentRelationships;

extern const struct DepartmentFetchedProperties {
} DepartmentFetchedProperties;

@class Department;
@class Person;
@class Department;
@class Person;






@interface DepartmentID : NSManagedObjectID {}
@end

@interface _Department : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (DepartmentID*)objectID;





@property (nonatomic, strong) NSString* id;



//- (BOOL)validateId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* level;



//- (BOOL)validateLevel:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* searchPersonIds;



//- (BOOL)validateSearchPersonIds:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Department *parentDept;

//- (BOOL)validateParentDept:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet *searchPersons;

- (NSMutableSet*)searchPersonsSet;




@property (nonatomic, strong) NSSet *subDepart;

- (NSMutableSet*)subDepartSet;




@property (nonatomic, strong) NSSet *subPerson;

- (NSMutableSet*)subPersonSet;





@end

@interface _Department (CoreDataGeneratedAccessors)

- (void)addSearchPersons:(NSSet*)value_;
- (void)removeSearchPersons:(NSSet*)value_;
- (void)addSearchPersonsObject:(Person*)value_;
- (void)removeSearchPersonsObject:(Person*)value_;

- (void)addSubDepart:(NSSet*)value_;
- (void)removeSubDepart:(NSSet*)value_;
- (void)addSubDepartObject:(Department*)value_;
- (void)removeSubDepartObject:(Department*)value_;

- (void)addSubPerson:(NSSet*)value_;
- (void)removeSubPerson:(NSSet*)value_;
- (void)addSubPersonObject:(Person*)value_;
- (void)removeSubPersonObject:(Person*)value_;

@end

@interface _Department (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveId;
- (void)setPrimitiveId:(NSString*)value;




- (NSString*)primitiveLevel;
- (void)setPrimitiveLevel:(NSString*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSString*)primitiveSearchPersonIds;
- (void)setPrimitiveSearchPersonIds:(NSString*)value;





- (Department*)primitiveParentDept;
- (void)setPrimitiveParentDept:(Department*)value;



- (NSMutableSet*)primitiveSearchPersons;
- (void)setPrimitiveSearchPersons:(NSMutableSet*)value;



- (NSMutableSet*)primitiveSubDepart;
- (void)setPrimitiveSubDepart:(NSMutableSet*)value;



- (NSMutableSet*)primitiveSubPerson;
- (void)setPrimitiveSubPerson:(NSMutableSet*)value;


@end
