#import "SearchPerson.h"
#import "NSManagedObject+SHM.h"

@interface SearchPerson ()

// Private interface goes here.

@end


@implementation SearchPerson
@synthesize personIds = _personIds;
// Custom logic goes here.
+ (NSArray *)oneNumPersons:(NSString *)num deptId:(NSString *)deptId
{
    if([deptId isEqual:@"1"])
    {
       return [self objectArrayByPredicate:[NSPredicate predicateWithFormat:@"shortNum = %@", num] sortDescriptors:nil];
    }
    deptId = [NSString stringWithFormat:@"%@*",deptId];
     return [self objectArrayByPredicate:[NSPredicate predicateWithFormat:@"shortNum = %@ and person.depart like %@", num,deptId] sortDescriptors:nil];
   // if(deptId ise)
        
}

- (void)addPersonID:(NSString *)personID
{
    if (!personID.length) {        
        return;
    }
    if (!_personIds) {
        _personIds = [[NSMutableString alloc]initWithCapacity:20];
        [_personIds appendString:personID];
    }else{
        [_personIds appendFormat:@",%@",personID]; //=  [NSString stringWithFormat:@"%@,%@",_personIds,personID];
    }
}

- (void)savePersonIds{
    self.searchPersonIds = _personIds;
}


@end
