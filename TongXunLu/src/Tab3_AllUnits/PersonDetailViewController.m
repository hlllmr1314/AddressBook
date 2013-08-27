//
//  PersonDetailViewController.m
//  TongXunLu
//
//  Created by Pan on 13-3-18.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import "PersonDetailViewController.h"
#import "NetClient+ToPath.h"
#import "Department.h"
#import "QAlertView.h"
#import "MBProgressHUD.h"

@interface PersonDetailViewController ()

@end

@implementation PersonDetailViewController
{
    MBProgressHUD *hud;
}
@synthesize _dict;
@synthesize btnSheweichangyong;
@synthesize cancelWithPopBack;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"个人信息";
        
        
        btnSheweichangyong = [[UIButton alloc] initWithFrame:CGRectMake(0,0, 64, 30)];
        //设为常用图片
        [btnSheweichangyong setImage:[UIImage imageNamed:@"sheweichangyong"] forState:UIControlStateNormal];
        //取消常用图片
        [btnSheweichangyong setImage:[UIImage imageNamed:@"quxiaochangyong"] forState:UIControlStateSelected];
        [btnSheweichangyong addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
        personDetailUIView = [[PersonDetailUIView alloc] init];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btnSheweichangyong];
        //[btnSheweichangyong release];
        self.navigationItem.rightBarButtonItem = rightItem;
        
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    personDetailUIView.frame = self.view.bounds;
    [self.view addSubview:personDetailUIView];
    
    personDetailUIView.vController = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(contextDidSave:)
                                                 name:NSManagedObjectContextDidSaveNotification
                                               object:nil];

}

- (void)viewDidAppear:(BOOL)animated
{
   
    [super viewDidAppear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     [_thread == ContentThreadMain?[[SHMData sharedData] context]:[[SHMData sharedData] contextWithOtherThread] refreshObject:_person mergeChanges:YES];
    [_thread == ContentThreadMain?[[SHMData sharedData] context]:[[SHMData sharedData] contextWithOtherThread] refreshObject:[Department objectByID:[NSNumber numberWithInt:0] thread:_thread] mergeChanges:YES];
    if (_person.chanyongValue) {
        btnSheweichangyong.selected = YES;
    }else{
        btnSheweichangyong.selected = NO;
    }
    
}
#pragma mark - coreData other thread
//- (void)setThread:(ContentThread)thread
//{
//    
//}

- (void)contextDidSave:(NSNotification *)notification
{
    
    SEL selector = @selector(mergeChangesFromContextDidSaveNotification:);
    [_thread == ContentThreadMain?[[SHMData sharedData] context]:[[SHMData sharedData] contextWithOtherThread] performSelectorOnMainThread:selector withObject:notification waitUntilDone:YES];
    
}

- (void)viewDidUnload
{
    personDetailUIView = nil;
    btnSheweichangyong = nil;
    _dict = nil;
    btnSheweichangyong = nil;
    _person = nil;
    _cancelChanyongBlock = nil;
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSManagedObjectContextDidSaveNotification object:nil];
}

- (void)setChangeyongUI:(Department *)department
{
    [department.searchPersonsSet addObject:_person];
    _person.chanyongValue = YES;
    [[SHMData sharedData] saveContext:_thread];
    [_thread == ContentThreadMain?[[SHMData sharedData] context]:[[SHMData sharedData] contextWithOtherThread] refreshObject:_person mergeChanges:YES];
    [[QAlertView sharedInstance] showAlertText:@"设置成功" fadeTime:2];
}

- (void)cancelChangyongUI:(Department *)department
{
    [department.searchPersonsSet removeObject:_person];
    _person.chanyongValue = NO;
    [[SHMData sharedData] saveContext:_thread];
    [_thread == ContentThreadMain?[[SHMData sharedData] context]:[[SHMData sharedData] contextWithOtherThread] refreshObject:_person mergeChanges:YES];
    [[QAlertView sharedInstance] showAlertText:@"取消成功" fadeTime:2];    
    if (_cancelChanyongBlock) {
        _cancelChanyongBlock();
    }
}

-(void)rightAction:(UIButton *)button
{
    Department *deptChanyong = [Department objectByID:[NSNumber numberWithInt:0] thread:_thread];
    
    if (button.selected){
        if (!_person.workCellPhone.length) {
            [self cancelChangyongUI:deptChanyong];
            button.selected = NO;
            return;
        }
        hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
        
        [[NetClient sharedClient] doPath:@"post" path:@"contacts/unfrequentUser" parameters:@{@"frequentPhone":_person.workCellPhone} success:^(NSMutableDictionary *dic) {
            [hud hide:YES];
            [self cancelChangyongUI:deptChanyong];
            button.selected = NO;
        } failure:^(NSMutableDictionary *dic) {
            [hud hide:YES];
            [[QAlertView sharedInstance] showAlertText:@"取消失败" fadeTime:2];
        } withToken:YES toJson:NO isNotForm:NO parameterEncoding:AFFormURLParameterEncoding];
              
    }else{
        
        if (!_person.workCellPhone.length) {
            [self setChangeyongUI:deptChanyong];
             button.selected = YES;
            return;
        }
         hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
        [[NetClient sharedClient] doPath:@"post" path:@"contacts/frequentUser" parameters:@{@"frequentPhone":_person.workCellPhone} success:^(NSMutableDictionary *dic) {
            [hud hide:YES];
            [self setChangeyongUI:deptChanyong];
            button.selected = YES;
        } failure:^(NSMutableDictionary *dic) {
            [hud hide:YES];
            [[QAlertView sharedInstance] showAlertText:@"设置失败" fadeTime:2];
        } withToken:YES toJson:NO isNotForm:NO parameterEncoding:AFFormURLParameterEncoding];
             
    }
    
    return;
    //发送网络请求设置常用
    //这里将本地和网络分开，是为了防止演示时服务器连不能，而不能展示常用列表,目前服务器接口尚有错
    //发布时应改成先网络，成功后再本地
    /*
     Method=POST
     URL=www.aa.com/api/contacts/ frequent
     Header:
     Token:xxxxxxxxxxx
     
     Form:
//     userId:xxx
//     */
//    NSString *url = [NSString stringWithFormat:@"%@contacts/frequent",SERVER_ADD];
//    NSDictionary *sendDict = [NSDictionary dictionaryWithObjectsAndKeys:[_dict objectForKey:@"id"],@"userId", nil];
//    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:url]];
//    
//    [httpClient postPath:@"" parameters:sendDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"Request Successful, response '%@'", responseStr);
//        //[[QAlertView sharedInstance] showAlertText:@"网络错误请重试" fadeTime:2];
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        DLog(@"authCellphone-Error: %@", error);
//        //[[QAlertView sharedInstance] showAlertText:@"网络错误请重试" fadeTime:2];
//    }];
    
}

- (void)setPerson:(Person *)person
{
    _person = person;
    personDetailUIView.person = person;
}
//
//-(void)updateFrequentContactsInLocal
//{
//    //设为常用
//    NSString *dbPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"tongxunludb.db"];
//    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
//    if (![db open]) {
//        NSLog(@"Could not open db.");
//        return;
//    }
//    
//    //先检查是不是已经插入了，如果没有再插，如果有就不插了
//    NSString *sql = [[NSString alloc] initWithFormat:@"select count(*) from commonused_list where id= '%@';",[_dict objectForKey:@"id"]];
//    FMResultSet *rs = [db executeQuery:sql];
//    int resCount = 0;
//    if ([rs next])
//        resCount = [rs intForColumnIndex:0];
//    DLog(@"result %d,sql:%@",resCount,sql);
//    if (resCount == 0){
//        sql = [[NSString alloc] initWithFormat:@"INSERT INTO commonused_list VALUES ('%@');",[_dict objectForKey:@"id"]];
//        DLog(@"result %d,sql:%@",resCount,sql);
//        if([db executeUpdate:sql])
//        {
//             
//            sql = [[NSString alloc] initWithFormat:@"UPDATE address_list set bcommon=1 WHERE id = '%@';",[_dict objectForKey:@"id"]];
//            [db executeUpdate:sql];
//            DLog(@"设置成功");
//            [[QAlertView sharedInstance] showAlertText:@"设置成功!" fadeTime:2];
//        }else
//        {
//            [[QAlertView sharedInstance] showAlertText:@"设置失败!" fadeTime:2];
//        }
//    }else{
//        [[QAlertView sharedInstance] showAlertText:@"已经存在!" fadeTime:2];
//    }
//    [db close];
//  
//
//}
//
//-(void)deleteCommonusedByID:(int)cid
//{
//    NSString *dbPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"tongxunludb.db"];
//    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
//    if (![db open]) {
//        NSLog(@"Could not open db.");
//        return;
//    }
//    
//    //NSString *sql = [[[NSString alloc] initWithFormat:@"UPDATE address_list set bcommon=0 WHERE id = '%d'",cid] autorelease];
//    NSString *sql = [[NSString alloc] initWithFormat:@"DELETE FROM commonused_list WHERE id = '%d';",cid];
//    DLog(@"deleted %d\nsql:%@",cid,sql);
//    if([db executeUpdate:sql])
//    {
//        
//        sql = [[NSString alloc] initWithFormat:@"UPDATE address_list set bcommon=0 WHERE id = '%d';",cid];
//        [db executeUpdate:sql];
//        [[QAlertView sharedInstance] showAlertText:@"操作成功!" fadeTime:2];
//    }
//    [db close];
//   
//}

-(void)loadPersonDetailWithDict:(NSDictionary *)dict
{
    self._dict = dict;
    [personDetailUIView refreshView:dict];
}

@end