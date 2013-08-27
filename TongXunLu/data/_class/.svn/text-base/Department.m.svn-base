#import "Department.h"
#import "NSManagedObject+SHM.h"
#import "Person.h"
#import "SearchIndex.h"
#import "CfgManager.h"

@interface Department ()

// Private interface goes here.

@end


@implementation Department







@synthesize personIds = _personIds;

@synthesize arrDept = _arrDept;
static NSMutableArray *arrPinyin;
static NSMutableArray *arrPhone;

static int allCount;
+ (void)saveFromJsonParent:(NSDictionary *)dicJson processBlock:(void(^)(int count,int allCount))processBlock
{
    
    
   
    allCount = [dicJson[@"userCount"] integerValue];
//    if ([dicJson[@"allUser"] count]==1) {
//        dicJson = dicJson[@"allUser"][0];
//        Department *d1Pro = [Department newObject2];
//        d1Pro.level = @"0";
//        d1Pro.id = @"1";
//        for (int i = 0; i< [dicJson count]; i++) {
//            Department *d2Pro = [Department newObject2];
//            d2Pro.level = @"1";
//            d2Pro.name = dicJson.allKeys[i];
//            
//            d2Pro.id = [NSString stringWithFormat:@"%@%@",d1Pro.id,[self stringAdd0:i]];
//            
//            //NSLog(@"%@,%@",d2Pro.name,d2Pro.id);
//            [self saveFromJson:dicJson.allValues[i] level:2 toDepart:d2Pro];
//            [d1Pro.subDepartSet addObject:d2Pro];
//            [d1Pro addPersonID:d2Pro.personIds];
//            [d1Pro savePersonIds];
//         //   [d1Pro.searchPersonsSet addObjectsFromArray:[d2Pro.searchPersons allObjects]];
//        }
//    }else{
        NSArray * dicArr = dicJson[@"allUser"];
        Department *d1Pro = [Department newObject2];
        d1Pro.level = @"0";
        d1Pro.id = @"1";
        [self saveFromJson:dicArr level:1 toDepart:d1Pro];
        
//    }
    
    
    Department *d2Pro = [Department newObject2];
    d2Pro.level = @"-1";
    d2Pro.id = @"0";
    NSArray *arrFrequentUsers = dicJson[@"frequentUsers"];
    NSString *strFrequentDept = dicJson[@"frequentDept"];
    if (dicJson[@"orgDataVersions"]) {
        [SearchIndex sharedIndexs].orgDataVersionsStr = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:dicJson[@"orgDataVersions"] options:NSJSONReadingMutableContainers error:nil] encoding:NSUTF8StringEncoding];
    }
    
    if ([arrFrequentUsers count]>0) {
       // Department *deptFrequent0 = [Department objectByID:[NSNumber numberWithInt:0] thread:ContentThreadPrivate];
       
        for (int i=0; i<[arrFrequentUsers count]; i++) {
            NSArray *arrPro = [Person objectArrayByPredicate:[NSPredicate predicateWithFormat:@"workCellPhone = %@", arrFrequentUsers[i]] sortDescriptors:nil offSet:0 limit:1 thread:1];
            Person *personFrequent;
            if (arrPro&&[arrPro count]==1) {
                personFrequent = arrPro[0];
            }
            
            if (!personFrequent) {
                continue;
            }
            personFrequent.chanyongValue = YES;
            [d2Pro.searchPersonsSet addObject:personFrequent];
        }
    }
    
    if (strFrequentDept) {
        if ([strFrequentDept isEqualToString:@"TOPDEPT"]) {
            [CfgManager setConfig:@"departmentID" detail:@"1"];
        }else{
            NSArray *arrFrequentDept = [strFrequentDept componentsSeparatedByString:@"--"];
            Department *frequentDeptPro;
            for (int i=0; i<[arrFrequentDept count]; i++) {
                if (i == 0) {
                    NSArray *arrPro = [Department objectArrayByPredicate:[NSPredicate predicateWithFormat:@"name = %@", arrFrequentDept[i]] sortDescriptors:nil offSet:0 limit:1 thread:1];
                    if (!arrPro||[arrPro count]!=1) {
                        break;
                    }
                    frequentDeptPro = arrPro[0];
                    continue;
                }
                if (!frequentDeptPro) {
                    break;
                }
                frequentDeptPro = [Department frequentWhereDept:arrFrequentDept[i] superDept:frequentDeptPro];
            }
            [CfgManager setConfig:@"departmentID" detail:frequentDeptPro.id];
        }
       
    }
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0),^{
//        [self sortArrPinyin];
//        [self sortArrPhone];
//        [SearchIndex sharedIndexs].arrPinyin = arrPinyin;
//        [SearchIndex sharedIndexs].arrPhone = arrPhone;
//        arrPinyin = nil;
//        arrPhone = nil;
//    });
    [[[SHMData sharedData] contextWithOtherThread] save:NULL];


}

+ (Department *)frequentWhereDept:(NSString *)frequentWhereName superDept:(Department *)superDept
{
    NSArray *arrPro = [Department objectArrayByPredicate:[NSPredicate predicateWithFormat:@"name = %@ and parentDept = %@",frequentWhereName,superDept] sortDescriptors:nil offSet:0 limit:1 thread:1];
    if (!arrPro||[arrPro count]!=1) {
        return nil;
    }
    return arrPro[0];
}

+ (NSString *)stringAdd0:(int)i
{
    if (i<10) {
        return [NSString stringWithFormat:@"00%d",i];
    }
    if (i<100) {
        return [NSString stringWithFormat:@"0%d",i];
    }
    return [NSString stringWithFormat:@"%d",i];
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

+ (void)saveFromJson:(NSArray *)dicArr level:(int)level toDepart:(Department *)depart {
    
    for (int i=0;i<[dicArr count];i++) {
        NSDictionary *depart0 = dicArr[i];
        if (!depart0[@"id"]) {
            Department *d3Pro = [Department newObject2];
            d3Pro.level = [NSString stringWithFormat:@"%d",level];
            d3Pro.name = depart0.allKeys[0];
            d3Pro.id = [NSString stringWithFormat:@"%@%@",depart.id,[self stringAdd0:i]];
            
            [self saveFromJson:depart0.allValues[0] level:level+1 toDepart:d3Pro];
            [depart.subDepartSet addObject:d3Pro];
            [depart addPersonID:d3Pro.personIds];
          
            [depart.searchPersonsSet addObjectsFromArray:[d3Pro.searchPersons allObjects]];
        }
        
        if (depart0[@"id"]) {
            Person *person = [Person newObject2];
           
            person.id = depart0[@"id"];
           
                
            person.username = depart0[@"username"];
          //   NSLog(@"%@,%@",person.id,person.username);
            person.email = depart0[@"email"];
            person.title = depart0[@"title"];
            
            person.workCellPhone = [depart0[@"workCellPhone"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
            person.virtualCellPhone = [depart0[@"virtualCellPhone"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
            person.personalCellPhone = [depart0[@"personalCellPhone"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
           
            person.workingPhone = [depart0[@"workingPhone"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
           person.workPhone2 = [depart0[@"workPhone2"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
            person.homePhone = [depart0[@"homePhone"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
            person.shortNum = [depart0[@"shortNum"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
            person.shortNum2 = [depart0[@"shortNum2"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//            [self addSearchPhone:person phone:person.virtualCellPhone deptId:depart.id];
//            [self addSearchPhone:person phone:person.workCellPhone deptId:depart.id];
//            [self addSearchPhone:person phone:person.personalCellPhone deptId:depart.id];
//            [self addSearchPhone:person phone:person.workingPhone deptId:depart.id];
//            [self addSearchPhone:person phone:person.workPhone2 deptId:depart.id];
//            [self addSearchPhone:person phone:person.homePhone deptId:depart.id];
//            [self addSearchPhone:person phone:person.shortNum deptId:depart.id];
//            [self addSearchPhone:person phone:person.shortNum2 deptId:depart.id];
            for (int i=0; i<MIN([depart0[@"firstPinyin"] count], 3); i++) {
                if (i==0) {
                    person.firstPinyin = depart0[@"firstPinyin"][i];
                    person.firstPinyinNum = [[SearchIndex sharedIndexs]convertToNum:person.firstPinyin];
                    person.pinyin = depart0[@"pinyin"][i];
                    person.pinyinNum = [[SearchIndex sharedIndexs]convertToNum:person.pinyin];
                    
                  //  [self addSearchPinyin:person.id deptId:depart.id firstPinyinNum:person.firstPinyinNum pinyinNum:person.pinyinNum];
                 //   [self addSearchPhone:person phone:person.pinyinNum deptId:depart.id];
//                    NSArray *arrPro = [[SearchIndex sharedIndexs] subArrFromPinYin:person.pinyin];
//                    for (int i=1; i<MIN([arrPro count], 3) ; i++) {
//                        
//                        [self addSearchPinyin:person.id deptId:depart.id firstPinyinNum:[person.firstPinyinNum substringFromIndex:i] pinyinNum:[[SearchIndex sharedIndexs]convertToNum:arrPro[i]]];
//                    }
                    
                }
                if (i==1) {
                    person.firstPinyin1 = depart0[@"firstPinyin"][i];
                    person.firstPinyinNum1 = [[SearchIndex sharedIndexs]convertToNum:person.firstPinyin1];
                    person.pinyin1 = depart0[@"pinyin"][i];
                    person.pinyinNum1 = [[SearchIndex sharedIndexs]convertToNum:person.pinyin1];
                    
                //    [self addSearchPinyin:person.id deptId:depart.id firstPinyinNum:person.firstPinyinNum1 pinyinNum:person.pinyinNum1];
                //    [self addSearchPhone:person phone:person.pinyinNum1 deptId:depart.id];
//                    NSArray *arrPro = [[SearchIndex sharedIndexs] subArrFromPinYin:person.pinyin1];
//                    for (int i=1; i<MIN([arrPro count], 3) ; i++) {                        
//                        
//                        [self addSearchPinyin:person.id deptId:depart.id firstPinyinNum:[person.firstPinyinNum1 substringFromIndex:i] pinyinNum:[[SearchIndex sharedIndexs]convertToNum:arrPro[i]]];
//                    }
                    
                }
                if (i==2) {
                    person.firstPinyin2 = depart0[@"firstPinyin"][i];
                    person.firstPinyinNum2 = [[SearchIndex sharedIndexs]convertToNum:person.firstPinyin2];
                    person.pinyin2 = depart0[@"pinyin"][i];
                    person.pinyinNum2 = [[SearchIndex sharedIndexs]convertToNum:person.pinyin2];
               //    [self addSearchPinyin:person.id deptId:depart.id firstPinyinNum:person.firstPinyinNum2 pinyinNum:person.pinyinNum2];
                 //   [self addSearchPhone:person phone:person.pinyinNum2 deptId:depart.id];
//                    NSArray *arrPro = [[SearchIndex sharedIndexs] subArrFromPinYin:person.pinyin2];
//                    for (int i=1; i<MIN([arrPro count], 3) ; i++) {
//                        
//                        [self addSearchPinyin:person.id deptId:depart.id firstPinyinNum:[person.firstPinyinNum2 substringFromIndex:i] pinyinNum:[[SearchIndex sharedIndexs]convertToNum:arrPro[i]]];
//                    }
                    
                }
            }
            [self pinyin4SearchAdd:person];
            [self phoneNum4SearchAdd:person];
            [depart.searchPersonsSet addObject:person];
            [depart.subPersonSet addObject:person];
            [depart addPersonID:person.id];
        }
        [depart savePersonIds];         
    }
   [[NSNotificationCenter defaultCenter] postNotificationName:@"processView" object:nil userInfo:@{@"process":[NSString stringWithFormat:@"%f",(float)[depart.subPerson count]/(float)allCount]}];
    
 

}

+ (void)pinyin4SearchAdd:(Person *)person
{
    NSMutableString *strMut = [[NSMutableString alloc]initWithCapacity:4];
    
    if (person.firstPinyin.length) {
        [strMut appendFormat:strMut.length?@",%@":@"%@",[person.firstPinyin lowercaseString]];
    }
    if (person.pinyin.length) {
        [strMut appendFormat:strMut.length?@",%@":@"%@",[person.pinyin lowercaseString]];
    }
    if (person.firstPinyin1.length) {
        [strMut appendFormat:strMut.length?@",%@":@"%@",[person.firstPinyin1 lowercaseString]];
    }
    if (person.pinyin1.length) {
        [strMut appendFormat:strMut.length?@",%@":@"%@",[person.pinyin1 lowercaseString]];
    }
    person.pinyin4Search = strMut;
}

+ (void)phoneNum4SearchAdd:(Person *)person
{
    NSMutableString *strMut = [[NSMutableString alloc]initWithCapacity:7];
    if (person.workCellPhone.length) {
        [strMut appendFormat:strMut.length?@",%@":@"%@",person.workCellPhone];
    }
    if (person.virtualCellPhone.length) {
        [strMut appendFormat:strMut.length?@",%@":@"%@",person.virtualCellPhone];
    }
    if (person.personalCellPhone.length) {
        [strMut appendFormat:strMut.length?@",%@":@"%@",person.personalCellPhone];
    }
    if (person.workingPhone.length) {
        [strMut appendFormat:strMut.length?@",%@":@"%@",person.workingPhone];
    }
    if (person.workPhone2.length) {
        [strMut appendFormat:strMut.length?@",%@":@"%@",person.workPhone2];
    }
    if (person.homePhone.length) {
        [strMut appendFormat:strMut.length?@",%@":@"%@",person.homePhone];
    }
    if (person.shortNum.length) {
        [strMut appendFormat:strMut.length?@",%@":@"%@",person.shortNum];
    }
    if (person.shortNum2.length) {
        [strMut appendFormat:strMut.length?@",%@":@"%@",person.shortNum2];
    }
    if (person.firstPinyinNum.length) {
        [strMut appendFormat:strMut.length?@",%@":@"%@",person.firstPinyinNum];
    }
    if (person.pinyinNum.length) {
        [strMut appendFormat:strMut.length?@",%@":@"%@",person.pinyinNum];
    }
    if (person.firstPinyinNum1.length) {
        [strMut appendFormat:strMut.length?@",%@":@"%@",person.firstPinyinNum1];
    }
    if (person.pinyinNum1.length) {
        [strMut appendFormat:strMut.length?@",%@":@"%@",person.pinyinNum1];
    }
    person.phoneNum4Search = strMut;
}



+ (void)utilAddPersonId:(int)index personId:(NSString *)personId{
    if (!personId.length) {
        return;
    }
    if (!((NSString *)arrPinyin[index]).length) {
        arrPinyin[index]  = [[NSMutableString alloc]initWithCapacity:5000];
        [arrPinyin[index] appendString:personId] ;
        return;
    }
    [arrPinyin[index] appendFormat:@",%@",personId];
}
//#pragma mark - addSearchPinyin element
//+ (void)sortArrPinyin
//{
//    for (int i=0; i<[arrPinyin count]; i++) {
//        arrPinyin[i] = [arrPinyin[i] sortedArrayUsingComparator:^NSComparisonResult(id a, id b){
//            int personId = [(SearchElement *)[NSKeyedUnarchiver unarchiveObjectWithData:a] personId];
//            int personId2 = [(SearchElement *)[NSKeyedUnarchiver unarchiveObjectWithData:b] personId];
//            if (personId>personId2) {
//                return  NSOrderedAscending;
//            }
//            return  NSOrderedDescending;
//        }];
//    }
//}
//
//+ (void)addSearchPinyin:(NSString *)personId deptId:(NSString *)deptId firstPinyinNum:(NSString *)firstPinyinNum pinyinNum:(NSString *)pinyinNum
//{
//    return;
//    if (!arrPinyin) {
//        arrPinyin = [[NSMutableArray alloc]initWithCapacity:10];
//        for (int i=0; i<10; i++) {
//            arrPinyin[i] = [[NSMutableArray alloc]initWithCapacity:8000];
//        }
//    }
//    if (!firstPinyinNum.length) {
//        return;
//    }
//    for (int i=0; i< firstPinyinNum.length-1; i++) {
//        NSString *strPro = [firstPinyinNum substringWithRange:NSMakeRange(i, 1)];
//        [self utilAddPerson:[strPro intValue] personId:personId deptId:deptId firstPinyinNum:firstPinyinNum pinyinNum:pinyinNum];     
//    }
//}
//
//+ (void)utilAddPerson:(int)index personId:(NSString *)personId deptId:(NSString *)deptId firstPinyinNum:(NSString *)firstPinyinNum pinyinNum:(NSString *)pinyinNum
//{
//    
//    SearchElement *element = [[SearchElement alloc]init];
//    element.personId = [personId intValue];
//    element.firstPinyinNum = [firstPinyinNum longLongValue];
//    
//    element.departId = [deptId longLongValue];
//    [arrPinyin[index] addObject:[NSKeyedArchiver archivedDataWithRootObject:element]];
//}
//




#pragma mark - addSearchPhone element
+ (NSString *)phoneToScan:(NSString *)phone
{
    NSScanner *scanner = [NSScanner scannerWithString:phone];
    NSMutableString *strippedString = [NSMutableString
                                       stringWithCapacity:phone.length];
    NSCharacterSet *numbers = [NSCharacterSet
                               characterSetWithCharactersInString:@"0123456789"];
    
    while ([scanner isAtEnd] == NO) {
        NSString *buffer;
        if ([scanner scanCharactersFromSet:numbers intoString:&buffer]) {
            
            [strippedString appendString:buffer];
            
        } else {
            [scanner setScanLocation:([scanner scanLocation] + 1)];
        }
    }
    return strippedString;
    
}
//
//+ (void)addSearchPhone:(Person *)person phone:(NSString *)phone deptId:(NSString *)deptId
//{
//    return;
//        if (!phone.length) {
//            return;
//        }
//       NSString *phone1 = [self phoneToScan:phone];
//        if (!phone1.length) {
//            return;
//        }       
//        if (!arrPhone) {
//            arrPhone = [[NSMutableArray alloc]initWithCapacity:10];
//            for (int i=0; i<10; i++) {
//                arrPhone[i] = [[NSMutableArray alloc]initWithCapacity:10];
//                for (int j=0; j<10; j++) {
//                    arrPhone[i][j] = [[NSMutableArray alloc]initWithCapacity:10];
//                    for (int k=0; k<10; k++) {
//                        arrPhone[i][j][k] = [[NSMutableArray alloc]initWithCapacity:2000];
//                    }
//                }
//            }
//        }
//        
//        if (phone1.length>=3&&phone1.length<=20) {
//            for (int i=0; i<phone1.length-2; i++) {
//                NSString *strPro = [phone1 substringWithRange:NSMakeRange(i, 3)];
//                [self utilAddPersonIdPhone:[strPro integerValue] personId:person.id phone:phone1 deptId:deptId];
//            }
//        }
//}

//+ (void)utilAddPersonIdPhone:(int)index personId:(NSString *)personId phone:(NSString *)phone deptId:(NSString *)deptId{
//    if (!personId.length) {
//        return;
//    }
//    
//    SearchElementPhone *element = [[SearchElementPhone alloc]init];
//    element.personId = [personId intValue];
//    
//    element.departId = [deptId longLongValue];
//    
//    if (phone.length<=20) {
//        element.phone = [phone longLongValue] ;
//    }
//   
//    [arrPhone[index/100][index%100/10][index%10] addObject:[NSKeyedArchiver archivedDataWithRootObject:element]];
//}
//
//+ (void)sortArrPhone
//{
//    for (int i=0; i<[arrPhone count]; i++) {
//        for (int j=0; j<[arrPhone[i] count]; j++) {
//            for (int k=0; k<[arrPhone[i][j] count]; k++) {
//                arrPhone[i][j][k] = [arrPhone[i][j][k] sortedArrayUsingComparator:^NSComparisonResult(id a, id b){
//                    int personId = [(SearchElementPhone *) [NSKeyedUnarchiver unarchiveObjectWithData:a] personId];
//                    int personId2 = [(SearchElementPhone *)[NSKeyedUnarchiver unarchiveObjectWithData:b] personId];
//                    if (personId>personId2) {
//                        return  NSOrderedAscending;
//                    }
//                    return  NSOrderedDescending;
//                }];
//            }
//        }
//        
//    }
//}

#pragma mark - addToSearchPerson




- (void)addToSearchPerson:(NSString *)num personId:(NSString *)personId
{
        
}
//- (NSArray *)subAllPersons
//{
//    
//    NSMutableArray *arrPro = [[NSMutableArray alloc]initWithCapacity:3000/([self.level floatValue]+1)];
//    for (Person *person in [self.subPerson allObjects]) {
//        [arrPro addObject:person];
//    }
//    for (Department *department in [self.subDepart allObjects]) {
//        [arrPro addObjectsFromArray:[department subAllPersons]];
//    }
//    return arrPro;
//}
//
//
//
- (NSArray *)arrDept
{
    if (!_arrDept) {
        NSSortDescriptor *sortNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"id" ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortNameDescriptor, nil];
        _arrDept = [self.subDepart sortedArrayUsingDescriptors:sortDescriptors];
    }    
    return _arrDept;
}

@end















