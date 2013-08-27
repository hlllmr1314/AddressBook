//
//  DepartmentDetailView.m
//  TongXunLu
//
//  Created by pan on 13-3-27.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import "DepartmentDetailView.h"
#import "CfgManager.h"
#import "NetClient+ToPath.h"
#import "BaiduMobStat.h"
#import "MBProgressHUD.h"

@implementation DepartmentDetailView
{
    MBProgressHUD *hud;
}
@synthesize dict,delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIButton *setBtn = [[UIButton alloc]initWithFrame:CGRectMake(50, 120, frame.size.width-100, 55)];
        [setBtn setImage:[UIImage imageNamed:@"sheweibenbumen.png"] forState:UIControlStateNormal];
        [setBtn setImage:[UIImage imageNamed:@"quxiaobenbumen.png"] forState:UIControlStateSelected];
        [self addSubview:setBtn];
       
        [setBtn addTarget:self action:@selector(sheweibenbumen:) forControlEvents:UIControlEventTouchUpInside];
        setBtn.imageView.contentMode = UIViewContentModeCenter;
        setBtn.tag = 889;
    }
    return self;
}

-(void)didMoveToWindow
{
    [super didMoveToWindow];
    
    if ( _dept && [[CfgManager getConfig:@"departmentID"] isEqualToString:_dept.id]) {
         ((UIButton *)[self viewWithTag:889]).selected = YES;
    }else{
        ((UIButton *)[self viewWithTag:889]).selected = NO;
    }
}
-(void)updateButtonStatus:(BOOL)bStatus
{
    UIButton *setBtn = (UIButton *)[self viewWithTag:889];
    setBtn.selected = bStatus;
}

- (NSString *)string4Set
{
    NSMutableString *strToSet = [[NSMutableString alloc] initWithCapacity:3];
    if (!_dept.name.length) {
        [strToSet appendString:@"TOPDEPT"];
    }else{
        if (!_dept.parentDept.name.length) {
            [strToSet appendString:_dept.name];
        }else{
            if (!_dept.parentDept.parentDept.name.length) {
                [strToSet appendFormat:@"%@--%@",_dept.parentDept.name,_dept.name];
            }else{
                if (!_dept.parentDept.parentDept.parentDept.name.length) {
                    [strToSet appendFormat:@"%@--%@--%@",_dept.parentDept.parentDept.name,_dept.parentDept.name,_dept.name];
                }else{
                    if (!_dept.parentDept.parentDept.parentDept.parentDept.name.length) {
                        [strToSet appendFormat:@"%@--%@--%@--%@",_dept.parentDept.parentDept.parentDept.name,_dept.parentDept.parentDept.name,_dept.parentDept.name,_dept.name];
                    }else{
                        if (!_dept.parentDept.parentDept.parentDept.parentDept.parentDept.name.length) {
                            [strToSet appendFormat:@"%@--%@--%@--%@--%@",_dept.parentDept.parentDept.parentDept.parentDept.name,_dept.parentDept.parentDept.parentDept.name,_dept.parentDept.parentDept.name,_dept.parentDept.name,_dept.name];
                        }
                    }
                }
            }
        }
    }
    return strToSet;
}

-(void)sheweibenbumen:(UIButton *)btn
{
    DLog(@"设为本部门:%@",self.departmentID);
    hud = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
    if (!btn.selected) {       
         [[BaiduMobStat defaultStat] logEvent:@"点击" eventLabel:@"设置本部门"];
        NSString *str4Set = [self string4Set];
        
        [[NetClient sharedClient] doPath:@"post" path:@"contacts/frequentDept" parameters:@{@"frequentDept":str4Set} success:^(NSMutableDictionary *dic) {
            [hud hide:YES];
            [CfgManager setConfig:@"departmentID" detail:_dept.id];
            [[QAlertView sharedInstance] showAlertText:@"设置本部门成功！" fadeTime:2];
            btn.selected = !btn.selected;
            if ([self.delegate respondsToSelector:@selector(departmentOnSet)]){
                [self.delegate departmentOnSet];
            }
        } failure:^(NSMutableDictionary *dic) {
            [hud hide:YES];
            [[QAlertView sharedInstance] showAlertText:@"设置本部门失败！" fadeTime:2];
        } withToken:YES toJson:NO isNotForm:NO parameterEncoding:AFFormURLParameterEncoding];
//
        
//        [CfgManager setConfig:@"departmentID" detail:_dept.id];
//        [[QAlertView sharedInstance] showAlertText:@"设置本部门成功！" fadeTime:2];
        
    }else
    {
        [[BaiduMobStat defaultStat] logEvent:@"点击" eventLabel:@"取消设置本部门"];        
        [[NetClient sharedClient] doPath:@"post" path:@"contacts/unfrequentDept" parameters:nil success:^(NSMutableDictionary *dic) {
            [hud hide:YES];
            
            [CfgManager setConfig:@"departmentID" detail:@""];
            [[QAlertView sharedInstance] showAlertText:@"取消成功！" fadeTime:2];
            if ([self.delegate respondsToSelector:@selector(departmentOnCancel)]){
                [self.delegate departmentOnCancel];
            }           
            btn.selected = !btn.selected;            
        } failure:^(NSMutableDictionary *dic) {
            [hud hide:YES];
            [[QAlertView sharedInstance] showAlertText:@"取消失败！" fadeTime:2];
        } withToken:YES toJson:NO isNotForm:NO parameterEncoding:AFFormURLParameterEncoding];        
        
    }
    

}

- (void)drawRect:(CGRect)rect
{
    if (self.dict == nil)   return;
    
}

@end
