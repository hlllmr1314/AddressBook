#import "Person.h"


@interface Person ()

// Private interface goes here.

@end


@implementation Person
@synthesize isSelect = _isSelect;


// Custom logic goes here.


- (int)numPhone
{
    int i=0;
    if (self.homePhone.length) {
        i++;
    }
    if (self.personalCellPhone.length) {
        i++;
    }
    if (self.shortNum.length) {
        i++;
    }
    if (self.virtualCellPhone.length) {
       i++;
    }
    if (self.workCellPhone.length) {
        i++;
    }
    if (self.workingPhone.length) {
        i++;
    }
    return i;
}


- (NSArray *)arrAllDicPhones
{
    NSMutableArray *arrPro = [[NSMutableArray alloc]initWithCapacity:8];
    if (self.workCellPhone.length) {
        [arrPro addObject:@{@"工作手机":self.workCellPhone}];
        //_dicAllPhone[@"工作手机"] = self.workCellPhone;
    }
    if (self.personalCellPhone.length) {
        [arrPro addObject:@{@"私人手机":self.personalCellPhone}];
       // _dicAllPhone[@"私人手机"] = self.personalCellPhone;
    }
    if (self.workPhone2.length) {
        if (self.workingPhone.length) {
            [arrPro addObject:@{@"固定电话1":self.workingPhone}];
            //_dicAllPhone[@"工作电话"] = self.workingPhone;
        }
        [arrPro addObject:@{@"固定电话2":self.workPhone2}];
    }else if(self.workingPhone.length){
        [arrPro addObject:@{@"固定电话":self.workingPhone}];
    }
    
    if (self.homePhone.length) {
        [arrPro addObject:@{@"住宅电话":self.homePhone}];
        //_dicAllPhone[@"住宅电话"] = self.homePhone;
    }
    if (self.shortNum2.length){
        if (self.shortNum.length) {
             [arrPro addObject:@{@"固话虚拟网1":self.shortNum}];
           // _dicAllPhone[@"分机号1"] = self.shortNum;
        }
        [arrPro addObject:@{@"固话虚拟网2":self.shortNum2}];
    }else if (self.shortNum.length) {
        [arrPro addObject:@{@"固话虚拟网":self.shortNum}];
        // _dicAllPhone[@"分机号1"] = self.shortNum;
    }
    
    
    if (self.virtualCellPhone.length) {
        [arrPro addObject:@{@"手机虚拟网":self.virtualCellPhone}];
        //_dicAllPhone[@"虚拟网"] = self.virtualCellPhone;
    }
    
    if (self.email.length) {
        [arrPro addObject:@{@"E-mail":self.email}];
        //_dicAllPhone[@"E-mail"] = self.email;
    }
    return arrPro;
    
}



@end
