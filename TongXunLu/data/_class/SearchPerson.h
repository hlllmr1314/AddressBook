#import "_SearchPerson.h"

@interface SearchPerson : _SearchPerson {}
// Custom logic goes here.
@property(nonatomic,strong)NSMutableString *personIds;
+ (NSArray *)oneNumPersons:(NSString *)num deptId:(NSString *)deptId;
- (void)addPersonID:(NSString *)personID;
- (void)savePersonIds;
@end
