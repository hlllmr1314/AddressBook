//
//  SearchIndex.m
//  TongXunLu
//
//  Created by Mac Mini on 13-5-21.
//  Copyright (c) 2013年 ShineMo. All rights reserved.
//

#import "SearchIndex.h"
#import "Person.h"
#import "Department.h"

#import "Search2PersonViewController.h"

@implementation SearchIndex

@synthesize orgDataVersionsStr = _orgDataVersionsStr;
//@synthesize dicNum = _dicNum;
//@synthesize arrPhone = _arrPhone;
//@synthesize arrPinyin = _arrPinyin;
//@synthesize memoPersons = _memoPersons;
static NSDictionary *dicPinyin;

CGFloat BNRTimeBlock (void (^block)(void)) {
    mach_timebase_info_data_t info;
    if (mach_timebase_info(&info) != KERN_SUCCESS) return -1.0;
    
    uint64_t start = mach_absolute_time ();
    block ();
    uint64_t end = mach_absolute_time ();
    uint64_t elapsed = end - start;
    
    uint64_t nanos = elapsed * info.numer / info.denom;
    return (CGFloat)nanos / NSEC_PER_SEC;
    
}

+(SearchIndex *)sharedIndexs
{
    static SearchIndex *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[SearchIndex alloc] init];
    });
    
    return sharedInstance;
}

- (id)init
{
    if (self = [super init]) {
        dicPinyin = @{@"a":@"2",@"b":@"2",@"c":@"2",@"2":@"2",
                      @"d":@"3",@"e":@"3",@"f":@"3",@"3":@"3",
                      @"g":@"4",@"h":@"4",@"i":@"4",@"4":@"4",
                      @"j":@"5",@"k":@"5",@"l":@"5",@"5":@"5",
                      @"m":@"6",@"n":@"6",@"o":@"6",@"6":@"6",
                      @"p":@"7",@"q":@"7",@"r":@"7",@"s":@"7",@"7":@"7",
                      @"t":@"8",@"u":@"8",@"v":@"8",@"8":@"8",
                      @"w":@"9",@"x":@"9",@"y":@"9",@"z":@"9",@"9":@"9",
                      @"0":@"0",@"1":@"1"};
    }
    return self;
}
//
//- (NSMutableDictionary *)dicNum
//{
//    if (!_dicNum) {
//        _dicNum = [[NSUserDefaults standardUserDefaults] objectForKey:@"SearchMap"];
//    }
//    return _dicNum;
//}
//
//- (void)saveDicNum
//{
//    [[NSUserDefaults standardUserDefaults] setObject:_dicNum forKey:@"SearchMap"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}
//
////- (void)insertPerson:(Person *)person
////{
////    if (!_dicNum) {
////        //  _dicNum = @{@"2":nil,@"3":nil,@"4":nil,@"5":nil,@"6":nil,@"7":nil,@"8":nil,@"9":nil};
////    }
////    NSString *strPro0 = [self convertToNum:person.pinyin];
////    NSString *strPro1 = [strPro0 substringWithRange:NSMakeRange(0, 1)];
////    if(!_dicNum[strPro1]){
////        _dicNum[strPro1] = [[NSMutableArray alloc]initWithCapacity:2000];
////    }
////    NameTree *nameTree = [[NameTree alloc]init];
////    nameTree.userId = person.id;
////    nameTree.num = strPro0;
////    nameTree.deptId = person.depart.id;
////    [_dicNum[strPro1] addObject:nameTree];
////    
////}
//
- (NSString *)convertToNum:(NSString *)pinyin
{
    
    NSMutableString *strPro = [[NSMutableString alloc]initWithCapacity:pinyin.length];
    for (int i=0; i<pinyin.length; i++) {
        NSString *strPro2 =  dicPinyin[[[pinyin substringWithRange:NSMakeRange(i, 1)] lowercaseString]];
        if (strPro2) {
            [strPro appendString:strPro2];
        }
    }
    return strPro;
}
//
- (NSString *)dataFilePath {
    if (!_dataFilePath) {
         NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        _dataFilePath = [paths objectAtIndex:0];
    }
    return _dataFilePath;   
}

- (void)setOrgDataVersionsStr:(NSString *)orgDataVersionsStr
{
   
    [[NSUserDefaults standardUserDefaults] setObject:orgDataVersionsStr forKey:@"orgDataVersions"];
    [[NSUserDefaults standardUserDefaults] synchronize];
   //[orgDataVersions writeToFile:[self.dataFilePath stringByAppendingPathComponent:@"orgDataVersions.plist"] atomically:NO];
    _orgDataVersionsStr = orgDataVersionsStr;
}

- (NSString *)orgDataVersionsStr
{
    if (!_orgDataVersionsStr) {
        _orgDataVersionsStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"orgDataVersions"];
    }
    return _orgDataVersionsStr;
}

- (NSString *)appVersion
{
    if (!_appVersion) {
        _appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    }
    return _appVersion;
}

//- (NSString *)productId
//{
//    if (!_productId) {
//        _productId = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleIdentifierKey];
//    }
//    return _productId;
//}
////
//- (void)setArrPinyin:(NSArray *)arrPinyin
//{
//    _arrPinyin = arrPinyin;
//    CGFloat time =  BNRTimeBlock(^{
//         [_arrPinyin writeToFile:[[self dataFilePath] stringByAppendingPathComponent:@"_arrPinyin.plist"] atomically:YES];
//     //    NSData *data =  [NSKeyedArchiver archivedDataWithRootObject:_arrPinyin];
////        NSMutableData *data = [NSMutableData data];
////        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
////        [archiver setOutputFormat:NSPropertyListBinaryFormat_v1_0];
////        [archiver encodeObject:_arrPinyin forKey:@"_arrPinyin"];
////        [archiver finishEncoding];
//      //  [data writeToFile:[[self dataFilePath] stringByAppendingPathComponent:@"_arrPinyin.dat"]  atomically:YES];
//        
//    });
//     NSLog(@"timePinyinWrite%f",time);
//    //[NSKeyedArchiver archiveRootObject:_arrPinyin toFile:[[self dataFilePath] stringByAppendingPathComponent:@"addressBook.archive.kArrPinyin"]];
//}
//
//- (NSArray *)arrPinyin
//{
//    
//    if (!_arrPinyin) {
//        _arrPinyin = [NSArray arrayWithContentsOfFile:[[self dataFilePath] stringByAppendingPathComponent:@"_arrPinyin.plist"]];
//      //  [NSKeyedUnarchiver unarchiveObjectWithFile:[[self dataFilePath] stringByAppendingPathComponent:@"addressBook.archive.kArrPinyin"]];
//    }
//    return _arrPinyin;
//}
//
//- (NSArray *)idsFromName:(int)num{
//    return [((NSString *)self.arrPinyin[num]) componentsSeparatedByString:@","];
//}
//
//- (NSArray *)idsFromPhone:(int)num{
//    return [((NSString *)self.arrPhone[num/100][num%100/10][num%10]) componentsSeparatedByString:@","];
//}
//
//- (void)setArrPhone:(NSArray *)arrPhone
//{
//    _arrPhone = arrPhone;
//    CGFloat time =  BNRTimeBlock(^{
//    [_arrPhone writeToFile:[[self dataFilePath] stringByAppendingPathComponent:@"_arrPhone.plist"] atomically:YES];
//  //      NSData *data =  [NSKeyedArchiver archivedDataWithRootObject:_arrPhone];
////        NSMutableData *data = [NSMutableData data];
////        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
////        [archiver setOutputFormat:NSPropertyListBinaryFormat_v1_0];
////        [archiver encodeObject:_arrPhone forKey:@"_arrPhone"];
////        [archiver finishEncoding];
//     //   [data writeToFile:[[self dataFilePath] stringByAppendingPathComponent:@"_arrPhone.dat"]  atomically:YES];
//        
//    });
//    NSLog(@"timePhoneWrite%f",time);
//    //[NSKeyedArchiver archiveRootObject:_arrPhone toFile:[[self dataFilePath] stringByAppendingPathComponent:@"addressBook.archive.kArrPhone"]];
//    //    [[NSUserDefaults standardUserDefaults] setObject:dicIndexPhone forKey:@"kDicIndexPhone"];
//    //    [[NSUserDefaults standardUserDefaults] synchronize];
//}
//
//- (NSArray *)arrPhone
//{
//    if (!_arrPhone) {
//        _arrPhone = [NSArray arrayWithContentsOfFile:[[self dataFilePath] stringByAppendingPathComponent:@"_arrPhone.plist"]];
//        //_arrPhone = [NSKeyedUnarchiver unarchiveObjectWithFile:[[self dataFilePath] stringByAppendingPathComponent:@"addressBook.archive.kArrPhone"]];
//    }
//    return _arrPhone;
//}
////
////- (void)setMemoPersons:(NSDictionary *)memoPersons
////{
////    _memoPersons = memoPersons;
////    [NSKeyedArchiver archiveRootObject:memoPersons toFile:[[self dataFilePath] stringByAppendingPathComponent:@"addressBook.archive.kMemoPersons"]];
////}
////
////- (NSDictionary *)memoPersons
////{
////    if (!_memoPersons) {
////        _memoPersons = [NSKeyedUnarchiver unarchiveObjectWithFile:[[self dataFilePath] stringByAppendingPathComponent:@"addressBook.archive.kMemoPersons"]];
////    }
////    return _memoPersons;
////}
//
////- (NSArray *)objIds:(NSString *)num{
////    NSMutableArray *arrayPro = [[NSMutableArray alloc]initWithCapacity:[self.memoPersons[num] count]];
////    for (int i=0; i<[self.memoPersons[num] count]; i++) {
////      [arrayPro addObject:[[[SHMData sharedData]persistentStoreCoordinator] managedObjectIDForURIRepresentation:self.memoPersons[num][i]]];
////    }
////    return arrayPro;
////}
//
//#pragma mark - init Arrs
//- (void)initArrs{
//  CGFloat time =  BNRTimeBlock(^{
//      
//    if (!_arrPinyin) {
//       // NSData *data = [NSData dataWithContentsOfFile:[[self dataFilePath] stringByAppendingPathComponent:@"_arrPinyin.dat"]];
//       // _arrPinyin = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//      //   NSData * firstObject = [archive objectAtIndex:0];
//        
//        _arrPinyin =  [NSArray arrayWithContentsOfFile:[[self dataFilePath] stringByAppendingPathComponent:@"_arrPinyin.plist"]];
//        //[NSKeyedUnarchiver unarchiveObjectWithFile:[[self dataFilePath] stringByAppendingPathComponent:@"addressBook.archive.kArrPinyin"]];
//    }
//  });
//    NSLog(@"timePinYin%f",time);
//     CGFloat timePhone =  BNRTimeBlock(^{
//    if (!_arrPhone) {
//      //  NSData *data = [NSData dataWithContentsOfFile:[[self dataFilePath] stringByAppendingPathComponent:@"_arrPhone.dat"]];
//      //  _arrPhone = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//        _arrPhone = [NSArray arrayWithContentsOfFile:[[self dataFilePath] stringByAppendingPathComponent:@"_arrPhone.plist"]];
//        //[NSKeyedUnarchiver unarchiveObjectWithFile:[[self dataFilePath] stringByAppendingPathComponent:@"addressBook.archive.kArrPhone"]];
//    }
//     });
//    NSLog(@"timePhone%f",timePhone);
//}
//
//#pragma mark - idsFrom element
//static int fromIndex;
//static int nameIndex;

//- (NSString *)pinyinToScan:(NSString *)pinyin
//{
//    NSScanner *scanner = [NSScanner scannerWithString:pinyin];
////    NSMutableString *strippedString = [NSMutableString
////                                       stringWithCapacity:phone.length];
//    NSCharacterSet *upper = [NSCharacterSet
//                               uppercaseLetterCharacterSet];
//    
//    while ([scanner isAtEnd] == NO) {
//        NSString *buffer;
//        if ([scanner scanCharactersFromSet:upper intoString:&buffer]) {
//            return [pinyin substringFromIndex:scanner.scanLocation];
//            //[strippedString appendString:buffer];
//            
//        } 
//    }
//    return nil;
//    
//}
//
//- (NSArray *)subArrFromPinYin:(NSString *)pinyin
//{
//    NSString *strPro = [self pinyinToScan: pinyin];
//    NSMutableArray *arrPro = [[NSMutableArray alloc]initWithCapacity:3];
//    while (strPro) {
//        strPro = [self pinyinToScan:[strPro substringFromIndex:1]];
//        if (strPro) {
//           
//            [arrPro addObject:strPro];
//            strPro = [pinyin substringFromIndex:1];
//        }
//    }
//    return arrPro;
//}

//
//- (NSArray *)idsFromOne:(NSString *)index deptId:(NSString *)deptId
//{
//    __block  NSArray *arrIndex;
//    __block  int firstNum;
//    __block  NSMutableArray *arrPro;
//    
//        firstNum = [[index substringToIndex:1] intValue];
//        arrIndex = _arrPinyin[firstNum];
//        arrPro = [[NSMutableArray alloc]initWithCapacity:1500];
//        
//   
//  
//    
//   
//        for (NSData *data in arrIndex) {
//            SearchElement *elePro = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//            if ([arrPro count]>1500) {
//                return arrPro;                
//            }
//            if ([deptId isEqualToString:@"1"]|| [[NSString stringWithFormat:@"%lld",elePro.departId] hasPrefix:deptId]) {
//                if ([[NSString stringWithFormat:@"%d",elePro.firstPinyinNum] hasPrefix:index]) {
//                    [arrPro addObject:[NSString stringWithFormat:@"%d",elePro.personId]];
//                }
//            }
//        }
//        
//        if (index.length<3) {
//            return arrPro;
//        }
//        
//        int firstPhone = [[index substringToIndex:3] intValue];
//        NSArray *arrIndexPhone = _arrPhone[firstPhone/100][firstPhone%100/10][firstPhone%10];
//        for (NSData *data in arrIndexPhone) {
//            SearchElementPhone *eleProPhone = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//            if ([arrPro count]>1500) {
//                return arrPro;
//            }
//            if ([deptId isEqualToString:@"1"]|| [[NSString stringWithFormat:@"%lld",eleProPhone.departId] hasPrefix:deptId]) {
//                if (index.length==3||[[NSString stringWithFormat:@"%lld",eleProPhone.phone] rangeOfString:index].location != NSNotFound) {
//                    [arrPro addObject:[NSString stringWithFormat:@"%d",eleProPhone.personId]];
//                }
//            }
//        }
//    
//  
//    return arrPro;
//}

//- (NSArray *)nextArrFromOne
//{
//    if (fromIndex == -1) {
//        return nil;
//    }
//    NSMutableArray *arrPro = [[NSMutableArray alloc]initWithCapacity:30];
//    for (int i=fromIndex; i<[_arrPinyin[nameIndex] count]; i++) {
//        SearchElement *elePro = _arrPinyin[nameIndex][i];
//        if (i>=fromIndex+30) {
//            fromIndex = i;
//            return arrPro;
//        }
//        
//        [arrPro addObject:[NSString stringWithFormat:@"%d",elePro.personId]];
//        
//    }
//    fromIndex = -1;
//    return arrPro;
//}
//
//- (NSArray *)idsFromTow:(int)index
//{
//    nameIndex = index;
//    NSMutableArray *arrPro = [[NSMutableArray alloc]initWithCapacity:30];
//    for (int i=0; i<[_arrPinyin[index] count]; i++) {
//        SearchElement *elePro = _arrPinyin[index][i];
//        if (i>=30) {
//            fromIndex = i;
//            return arrPro;
//        }
//        
//        [arrPro addObject:[NSString stringWithFormat:@"%d",elePro.personId]];
//        
//    }
//    fromIndex = -1;
//    return arrPro;
//}


#pragma mark - pinyinStr_index

- (NSDictionary *)userNameStr_index:(Person *)person searchText:(NSString *)searchText
{
    NSMutableDictionary *dicPro = [[NSMutableDictionary alloc]initWithCapacity:2];
    NSMutableArray *arrPro = [[NSMutableArray alloc]initWithCapacity:3];
    if ([[NSPredicate predicateWithFormat:@"username CONTAINS %@",searchText] evaluateWithObject:person]) {
        NSRange rang = [person.username rangeOfString:searchText];        
        for (int i=0; i<rang.length; i++) {            
            [arrPro addObject:[NSString stringWithFormat:@"%d",rang.location+i]];            
        }
        dicPro[@"str"] = person.username;
        dicPro[@"arr"] = arrPro;
        return dicPro;
    }
    return dicPro;
}
- (NSDictionary *)pinyinNotIntStr_index:(Person *)person searchText:(NSString *)searchText
{
    NSMutableDictionary *dicPro = [[NSMutableDictionary alloc]initWithCapacity:2];
    NSMutableArray *arrPro = [[NSMutableArray alloc]initWithCapacity:10];
    if ([[NSPredicate predicateWithFormat:@"firstPinyin CONTAINS[cd] %@",searchText] evaluateWithObject:person]) {
        NSRange rang = [person.firstPinyin.lowercaseString rangeOfString:searchText];
        int local = -1;
        for (int i=0; i<rang.length; i++) {
            NSString *strPro = [person.firstPinyin substringWithRange:NSMakeRange(rang.location+i, 1)];
            local =  [person.pinyin rangeOfString:[strPro capitalizedString] options:NSLiteralSearch range:NSMakeRange(local+1, person.pinyin.length-local-1)].location;
            [arrPro addObject:[NSString stringWithFormat:@"%d",local]];
            
        }
        dicPro[@"str"] = person.pinyin;
        dicPro[@"arr"] = arrPro;
        return dicPro;
    }
    if ([[NSPredicate predicateWithFormat:@"firstPinyin1 CONTAINS[cd] %@",searchText] evaluateWithObject:person]) {
        NSRange rang = [person.firstPinyin1.lowercaseString rangeOfString:searchText];
        int local = -1;
        for (int i=0; i<rang.length; i++) {
            NSString *strPro = [person.firstPinyin1 substringWithRange:NSMakeRange(rang.location+i, 1)];
            local =  [person.pinyin1 rangeOfString:[strPro capitalizedString] options:NSLiteralSearch range:NSMakeRange(local+1, person.pinyin1.length-local-1)].location;
            [arrPro addObject:[NSString stringWithFormat:@"%d",local]];
            
        }
        dicPro[@"str"] = person.pinyin1;
        dicPro[@"arr"] = arrPro;
        return dicPro;
    }
    if ([[NSPredicate predicateWithFormat:@"pinyin CONTAINS[cd] %@",searchText] evaluateWithObject:person]) {
        NSRange rang = [person.pinyin.lowercaseString rangeOfString:searchText];
        for (int i=0; i<rang.length; i++) {
            
            [arrPro addObject:[NSString stringWithFormat:@"%d",rang.location+i]];
        }
        dicPro[@"str"] = person.pinyin;
        dicPro[@"arr"] = arrPro;
        return dicPro;
    }
    if ([[NSPredicate predicateWithFormat:@"pinyin1 CONTAINS[cd] %@",searchText] evaluateWithObject:person]) {
        NSRange rang = [person.pinyin1.lowercaseString rangeOfString:searchText];
        for (int i=0; i<rang.length; i++) {
            
            [arrPro addObject:[NSString stringWithFormat:@"%d",rang.location+i]];
        }
        dicPro[@"str"] = person.pinyin1;
        dicPro[@"arr"] = arrPro;
        return dicPro;
    }
    dicPro[@"str"] = person.pinyin;
    dicPro[@"arr"] = arrPro;
    return dicPro;    
}

- (NSDictionary *)pinyinStr_index:(Person *)person searchText:(NSString *)searchText
{
    NSMutableDictionary *dicPro = [[NSMutableDictionary alloc]initWithCapacity:2];
    NSMutableArray *arrPro = [[NSMutableArray alloc]initWithCapacity:10];
    if ([[NSPredicate predicateWithFormat:@"firstPinyinNum CONTAINS %@",searchText] evaluateWithObject:person]) {
        NSRange rang = [person.firstPinyinNum rangeOfString:searchText];
         int local = -1;
        for (int i=0; i<rang.length; i++) {
            NSString *strPro = [person.firstPinyin substringWithRange:NSMakeRange(rang.location+i, 1)];
            local =  [person.pinyin rangeOfString:strPro options:NSLiteralSearch range:NSMakeRange(local+1, person.pinyin.length-local-1)].location;
            [arrPro addObject:[NSString stringWithFormat:@"%d",local]];
            
        }
        dicPro[@"str"] = person.pinyin;
        dicPro[@"arr"] = arrPro;
        return dicPro;
    }
    if ([[NSPredicate predicateWithFormat:@"firstPinyinNum1 CONTAINS %@",searchText] evaluateWithObject:person]) {
        NSRange rang = [person.firstPinyinNum1 rangeOfString:searchText];
         int local = -1;
        for (int i=0; i<rang.length; i++) {
            NSString *strPro = [person.firstPinyin1 substringWithRange:NSMakeRange(rang.location+i, 1)];
            local =  [person.pinyin1 rangeOfString:strPro options:NSLiteralSearch range:NSMakeRange(local+1, person.pinyin1.length-local-1)].location;
            [arrPro addObject:[NSString stringWithFormat:@"%d",local]];
           // [arrPro addObject:[NSString stringWithFormat:@"%d",[person.pinyin1 rangeOfString:strPro].location]];
        }
        dicPro[@"str"] = person.pinyin1;
        dicPro[@"arr"] = arrPro;
        return dicPro;
    }
    if ([[NSPredicate predicateWithFormat:@"firstPinyinNum2 CONTAINS %@",searchText] evaluateWithObject:person]) {
        NSRange rang = [person.firstPinyinNum2 rangeOfString:searchText];
        int local = -1;
        for (int i=0; i<rang.length; i++) {
            NSString *strPro = [person.firstPinyin2 substringWithRange:NSMakeRange(rang.location+i, 1)];
          //  NSString *location = [NSString stringWithFormat:@"%d",[person.pinyin2 rangeOfString:strPro].location];
            local =  [person.pinyin2 rangeOfString:strPro options:NSLiteralSearch range:NSMakeRange(local+1, person.pinyin2.length-local-1)].location;
            [arrPro addObject:[NSString stringWithFormat:@"%d",local]];
               
                
           
        }
        dicPro[@"str"] = person.pinyin2;
        dicPro[@"arr"] = arrPro;
        return dicPro;
    }
    
    if ([[NSPredicate predicateWithFormat:@"pinyinNum CONTAINS %@",searchText] evaluateWithObject:person]) {
        NSRange rang = [person.pinyinNum rangeOfString:searchText];
        for (int i=0; i<rang.length; i++) {
            
            [arrPro addObject:[NSString stringWithFormat:@"%d",rang.location+i]];
        }
        dicPro[@"str"] = person.pinyin;
        dicPro[@"arr"] = arrPro;
        return dicPro;
    }
    if ([[NSPredicate predicateWithFormat:@"pinyinNum1 CONTAINS %@",searchText] evaluateWithObject:person]) {
        NSRange rang = [person.pinyinNum1 rangeOfString:searchText];
        for (int i=0; i<rang.length; i++) {
            
            [arrPro addObject:[NSString stringWithFormat:@"%d",rang.location+i]];
        }
        dicPro[@"str"] = person.pinyin1;
        dicPro[@"arr"] = arrPro;
        return dicPro;
    }
    if ([[NSPredicate predicateWithFormat:@"pinyinNum2 CONTAINS %@",searchText] evaluateWithObject:person]) {
        NSRange rang = [person.pinyinNum2 rangeOfString:searchText];
        for (int i=0; i<rang.length; i++) {
            
            [arrPro addObject:[NSString stringWithFormat:@"%d",rang.location+i]];
        }
        dicPro[@"str"] = person.pinyin2;
        dicPro[@"arr"] = arrPro;
        return dicPro;
    }
    dicPro[@"str"] = person.pinyin;
    dicPro[@"arr"] = arrPro;
    return dicPro;
}

#pragma mark - phoneStr_index

- (NSDictionary *)phoneStr_index:(Person *)person searchText:(NSString *)searchText
{
    NSMutableDictionary *dicPro = [[NSMutableDictionary alloc]initWithCapacity:2];
    NSMutableArray *arrPro = [[NSMutableArray alloc]initWithCapacity:10];
    if (searchText.length<3) {
        
        dicPro[@"str"] = [NSString stringWithFormat:@"%d个电话",[[person arrAllDicPhones] count]];
        dicPro[@"arr"] = arrPro;
        return dicPro;
    }
    
    if ([[NSPredicate predicateWithFormat:@"homePhone CONTAINS %@",searchText] evaluateWithObject:person]) {
        
        NSRange rang = [person.homePhone rangeOfString:searchText];
        for (int i=0; i<rang.length; i++) {
            [arrPro addObject:[NSString stringWithFormat:@"%d",rang.location+i]];
        }
        dicPro[@"str"] = person.homePhone;
        dicPro[@"arr"] = arrPro;
        return dicPro;
    }
    if ([[NSPredicate predicateWithFormat:@"personalCellPhone CONTAINS %@",searchText] evaluateWithObject:person]) {
        
        NSRange rang = [person.personalCellPhone rangeOfString:searchText];
        for (int i=0; i<rang.length; i++) {
            [arrPro addObject:[NSString stringWithFormat:@"%d",rang.location+i]];
        }
        dicPro[@"str"] = person.personalCellPhone;
        dicPro[@"arr"] = arrPro;
        return dicPro;
    }
    if ([[NSPredicate predicateWithFormat:@"shortNum CONTAINS %@",searchText] evaluateWithObject:person]) {
        
        NSRange rang = [person.shortNum rangeOfString:searchText];
        for (int i=0; i<rang.length; i++) {
            [arrPro addObject:[NSString stringWithFormat:@"%d",rang.location+i]];
        }
        dicPro[@"str"] = person.shortNum;
        dicPro[@"arr"] = arrPro;
        return dicPro;
    }
    if ([[NSPredicate predicateWithFormat:@"shortNum2 CONTAINS %@",searchText] evaluateWithObject:person]) {
        
        NSRange rang = [person.shortNum2 rangeOfString:searchText];
        for (int i=0; i<rang.length; i++) {
            [arrPro addObject:[NSString stringWithFormat:@"%d",rang.location+i]];
        }
        dicPro[@"str"] = person.shortNum2;
        dicPro[@"arr"] = arrPro;
        return dicPro;
    }
    
    if ([[NSPredicate predicateWithFormat:@"virtualCellPhone CONTAINS %@",searchText] evaluateWithObject:person]) {
        
        NSRange rang = [person.virtualCellPhone rangeOfString:searchText];
        for (int i=0; i<rang.length; i++) {
            [arrPro addObject:[NSString stringWithFormat:@"%d",rang.location+i]];
        }
        dicPro[@"str"] = person.virtualCellPhone;
        dicPro[@"arr"] = arrPro;
        return dicPro;
    }
    
    if ([[NSPredicate predicateWithFormat:@"workCellPhone CONTAINS %@",searchText] evaluateWithObject:person]) {
        
        NSRange rang = [person.workCellPhone rangeOfString:searchText];
        for (int i=0; i<rang.length; i++) {
            [arrPro addObject:[NSString stringWithFormat:@"%d",rang.location+i]];
        }
        dicPro[@"str"] = person.workCellPhone;
        dicPro[@"arr"] = arrPro;
        return dicPro;
    }
    
    if ([[NSPredicate predicateWithFormat:@"workingPhone CONTAINS %@",searchText] evaluateWithObject:person]) {
        
        NSRange rang = [person.workingPhone rangeOfString:searchText];
        for (int i=0; i<rang.length; i++) {
            [arrPro addObject:[NSString stringWithFormat:@"%d",rang.location+i]];
        }
        dicPro[@"str"] = person.workingPhone;
        dicPro[@"arr"] = arrPro;
        return dicPro;
    }
    
    if ([[NSPredicate predicateWithFormat:@"workPhone2 CONTAINS %@",searchText] evaluateWithObject:person]) {
        
        NSRange rang = [person.workPhone2 rangeOfString:searchText];
        for (int i=0; i<rang.length; i++) {
            [arrPro addObject:[NSString stringWithFormat:@"%d",rang.location+i]];
        }
        dicPro[@"str"] = person.workPhone2;
        dicPro[@"arr"] = arrPro;
        return dicPro;
    }
    
    dicPro[@"str"] = [NSString stringWithFormat:@"%d个电话",[[person arrAllDicPhones] count]];
    dicPro[@"arr"] = arrPro;
    return dicPro;
}

@end
