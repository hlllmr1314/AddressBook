//
//  PersonIndex.m
//  TongXunLu
//
//  Created by Mac Mini on 13-5-25.
//  Copyright (c) 2013年 ShineMo. All rights reserved.
//

#import "PersonIndex.h"
#import "Department.h"
@implementation PersonIndex
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.id forKey:@"idValue"];
    [aCoder encodeObject:_pinyinNum forKey:@"_pinyinNum"];
    [aCoder encodeObject:_pinyinNum1 forKey:@"_pinyinNum1"];
    [aCoder encodeObject:_pinyinNum2 forKey:@"_pinyinNum2"];
    [aCoder encodeObject:_firstPinyinNum forKey:@"_firstPinyinNum"];
    [aCoder encodeObject:_firstPinyinNum1 forKey:@"_firstPinyinNum1"];
    [aCoder encodeObject:_firstPinyinNum2 forKey:@"_firstPinyinNum2"];
    [aCoder encodeObject:_workCellPhone forKey:@"_workCellPhone"];
    [aCoder encodeObject:_virtualCellPhone forKey:@"_virtualCellPhone"];
    [aCoder encodeObject:_personalCellPhone forKey:@"_personalCellPhone"];
    [aCoder encodeObject:_workingPhone forKey:@"_workingPhone"];
    [aCoder encodeObject:_workPhone2 forKey:@"_workPhone2"];
    [aCoder encodeObject:_homePhone forKey:@"_homePhone"];
    [aCoder encodeObject:_shortNum forKey:@"_shortNum"];
    [aCoder encodeObject:_shortNum2 forKey:@"_shortNum2"];
    
    [aCoder encodeObject:_chanyong forKey:@"_chanyong"];
    [aCoder encodeObject:_deptId forKey:@"_deptId"];
}

- (id)initWithCoder:(NSCoder *)decoder{
    if(self =[super init]){
        self.id = [decoder decodeObjectForKey:@"idValue"];
        _pinyinNum = [decoder decodeObjectForKey:@"_pinyinNum"];
        _pinyinNum1 = [decoder decodeObjectForKey:@"_pinyinNum1"];
        _pinyinNum2 = [decoder decodeObjectForKey:@"_pinyinNum2"];
        _firstPinyinNum =[decoder decodeObjectForKey:@"_firstPinyinNum"];
        _firstPinyinNum1 =[decoder decodeObjectForKey:@"_firstPinyinNum1"];
        _firstPinyinNum2 =[decoder decodeObjectForKey:@"_firstPinyinNum2"];
        _workCellPhone =[decoder decodeObjectForKey:@"_workCellPhone"];
        _virtualCellPhone =[decoder decodeObjectForKey:@"_virtualCellPhone"];
        _personalCellPhone =[decoder decodeObjectForKey:@"_personalCellPhone"];
        _workingPhone =[decoder decodeObjectForKey:@"_workingPhone"];
        _workPhone2 =[decoder decodeObjectForKey:@"_workPhone2"];
        _homePhone =[decoder decodeObjectForKey:@"_homePhone"];
        _shortNum =[decoder decodeObjectForKey:@"_shortNum"];
        _shortNum2 =[decoder decodeObjectForKey:@"_shortNum2"];
        
        _chanyong =[decoder decodeObjectForKey:@"_chanyong"];
        _deptId =[decoder decodeObjectForKey:@"_deptId"];
    }
    return self;
}

- (void)setPerson:(Person *)person
{
    _id = person.id;
    _pinyinNum = person.pinyinNum;
    _pinyinNum1 = person.pinyinNum1;
    _pinyinNum2 = person.pinyinNum2;
    _firstPinyinNum = person.firstPinyinNum;
    _firstPinyinNum1 =person.firstPinyinNum1;
    _firstPinyinNum2 =person.firstPinyinNum2;
    _workCellPhone =person.workCellPhone;
    _virtualCellPhone =person.virtualCellPhone;
    _personalCellPhone =person.personalCellPhone;
    _workingPhone =person.workingPhone;
    _workPhone2 =person.workPhone2;
    _homePhone =person.homePhone;
    _shortNum =person.shortNum;
    _shortNum2 =person.shortNum2;
    
    _chanyong =person.chanyong;
    _deptId = person.depart.id;
}



@end
