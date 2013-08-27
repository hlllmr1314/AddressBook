//
//  AuthViewController.m
//  TongXunLu
//
//  Created by pan on 13-3-27.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import "AuthViewController.h"
#import "TokenManager.h"
#import "POAPinyin.h"
#import "CfgManager.h"
#import "SBJsonParser.h"

@interface AuthViewController ()

@end

@implementation AuthViewController

-(void)dealloc
{
    if (letterDict != nil) {
        [letterDict removeAllObjects];
        [letterDict release];
    }
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    regv = [[RegisterView alloc]initWithFrame:self.view.bounds];
    regv.delegate = self;
    [self.view addSubview:regv];
    [regv release];
    regv.verifyFiled.enabled = YES;
    regv.hidden = YES;
    
    coverImage = [[UIImageView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:coverImage];
    [coverImage release];
    coverImage.backgroundColor = [UIColor whiteColor];
    coverImage.image = [UIImage imageNamed:@"Default.png"];
    if (UI_SCREEN_HEIGHT > 480) {
        coverImage.image = [UIImage imageNamed:@"Default-568h.png"];
    }
    
    progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(50, UI_SCREEN_HEIGHT/2 +100, 220, 50)];
    [self.view addSubview:progressView];
    [progressView release];
    progressView.progress = 0;
    progressView.hidden = YES;
    
    letterDict = [[NSMutableDictionary alloc] init];
    [letterDict setObject:@"2" forKey:@"A"];
    [letterDict setObject:@"2" forKey:@"B"];
    [letterDict setObject:@"2" forKey:@"C"];
    [letterDict setObject:@"3" forKey:@"D"];
    [letterDict setObject:@"3" forKey:@"E"];
    [letterDict setObject:@"3" forKey:@"F"];
    [letterDict setObject:@"4" forKey:@"G"];
    [letterDict setObject:@"4" forKey:@"H"];
    [letterDict setObject:@"4" forKey:@"I"];
    [letterDict setObject:@"5" forKey:@"J"];
    [letterDict setObject:@"5" forKey:@"K"];
    [letterDict setObject:@"5" forKey:@"L"];
    [letterDict setObject:@"6" forKey:@"M"];
    [letterDict setObject:@"6" forKey:@"N"];
    [letterDict setObject:@"6" forKey:@"O"];
    [letterDict setObject:@"7" forKey:@"P"];
    [letterDict setObject:@"7" forKey:@"Q"];
    [letterDict setObject:@"7" forKey:@"R"];
    [letterDict setObject:@"7" forKey:@"S"];
    [letterDict setObject:@"8" forKey:@"T"];
    [letterDict setObject:@"8" forKey:@"U"];
    [letterDict setObject:@"8" forKey:@"V"];
    [letterDict setObject:@"9" forKey:@"W"];
    [letterDict setObject:@"9" forKey:@"X"];
    [letterDict setObject:@"9" forKey:@"Y"];
    [letterDict setObject:@"9" forKey:@"Z"];
    
    
    //初始化gzip,默认打开
    NSString *gzip = [CfgManager getConfig:@"gzip_switch"];
    if (gzip == nil || [gzip isEqualToString:@""]){
        [CfgManager setConfig:@"gzip_switch" detail:@"1"];
    }
    
}

-(void)displayAuthView
{
    regv.hidden = NO;
    [self.view bringSubviewToFront:regv];
    
    //    [UIView animateWithDuration:1 animations:^{
    //        coverImage.alpha = 0.3;
    //    }completion:^(BOOL finished){
    //        if (regv != nil){
    //            regv.hidden = NO;
    //            [self.view bringSubviewToFront:regv];
    //        }
    //    }];
}

-(void)registerViewDidsubmit:(NSString *)phonenum with:(NSString *)verifycode
{
    [self authCellphone:phonenum code:verifycode];
}

//小潘,这里作为调试模式入口
-(void)registerViewCancel:(NSString *)phonenum with:(NSString *)verifycode
{
//    if (DEBUG) {
//        [[TokenManager sharedInstance] setToken:TESTTOKEN];
//    }
    
    NSString *token = [TokenManager getToken];
    if (token == nil || [token isEqualToString:@""]){
        [[QAlertView sharedInstance] showAlertText:@"未检测到绑定手机，请先申请绑定!" fadeTime:2];
    }else{
        [self getAllContacts:token];
    }
    
}
-(void)registerViewResponsePhoneverifycode:(NSString *)phonenum
{
    regv.verifyFiled.enabled = YES;
    [regv verfiyButtonStartCountDown:60];
    [self getAuthCode:phonenum];
}

-(void)getAuthCode:(NSString *)phoneNumber
{
    NSString *url = [NSString stringWithFormat:@"%@auth/%@",SERVER_ADD,phoneNumber];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setTimeoutInterval:120];
    [request setHTTPMethod:@"GET"];
    
    AFHTTPRequestOperation *operation = [[[AFHTTPRequestOperation alloc] initWithRequest:request] autorelease];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *ope, id responseObject) {
        DLog(@"getAuthCode-Success: %@",ope.responseString);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"getAuthCode-Error: %@", error);
        [[QAlertView sharedInstance] showAlertText:@"网络错误请重试" fadeTime:2];
        [regv resetButtonInfo];
    }];
    [operation start];
}


-(void)authCellphone:(NSString *)phoneNumber code:(NSString *)authCode
{
    NSString *url = [NSString stringWithFormat:@"%@auth/check",SERVER_ADD];
    NSString *postString =[[[NSString alloc] initWithFormat: @"cellPhone=%@&authCode=%@",phoneNumber,authCode] autorelease];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setTimeoutInterval:120];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValue:postString forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    
    AFHTTPRequestOperation *operation = [[[AFHTTPRequestOperation alloc] initWithRequest:request] autorelease];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *ope, id responseObject) {
        DLog(@"authCellphone-Success: %@",ope.responseString);
        [[TokenManager sharedInstance] setToken:ope.responseString];
        [self getAllContacts:ope.responseString];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"authCellphone-Error: %@", error);
        [[QAlertView sharedInstance] showAlertText:@"网络错误请重试" fadeTime:2];
    }];
    [operation start];
    
}

-(void)fetchingContacts:(NSString *)token
{
    if ([CfgManager getConfig:@"updated"] && [[CfgManager getConfig:@"updated"] isEqualToString:@"1"]) {
        [[[UIApplication sharedApplication] delegate] performSelector:@selector(initTabs)];
    }else{
        
        DLog(@"fetchingContacts calling twice?");
        //progressView.hidden = NO;
        coverImage.hidden = NO;
        coverImage.alpha = 1;
        [self.view bringSubviewToFront:coverImage];
        //把绑定界面的交互给挡住
        [coverImage setUserInteractionEnabled:YES];
        if (regv != nil) [regv setHidden:YES];
        //[self.view bringSubviewToFront:progressView];
        
        
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        indicator.center = CGPointMake(UI_SCREEN_WIDTH/2, UI_SCREEN_HEIGHT/2+90);
        [indicator startAnimating];
        [coverImage addSubview:indicator];
        [indicator release];
        
        UILabel *nowreadbyteL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
        nowreadbyteL.center = CGPointMake(UI_SCREEN_WIDTH/2, UI_SCREEN_HEIGHT/2+130);
        nowreadbyteL.font = [UIFont systemFontOfSize:12];
        nowreadbyteL.text = @"正在下载数据:0KB";
        nowreadbyteL.textColor = [UIColor grayColor];
        nowreadbyteL.textAlignment = NSTextAlignmentCenter;
        nowreadbyteL.backgroundColor = [UIColor clearColor];
        [coverImage addSubview:nowreadbyteL];
        [nowreadbyteL release];
        
        NSString *url = [NSString stringWithFormat:@"%@contacts/%d",SERVER_ADD,1];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
        [request setValue:token forHTTPHeaderField:@"Token"];
        [request setValue:@"true" forHTTPHeaderField:@"gzip"];

        [request setTimeoutInterval:120];
        [request setHTTPMethod:@"GET"];
        
        DLog(@"start download json!");
        AFHTTPRequestOperation *aoperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        [aoperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *ope, id responseObject) {
            
            NSString *result = [[[NSString alloc] initWithData:ope.responseData encoding:NSUTF8StringEncoding] autorelease];
            NSData *data = [result dataUsingEncoding:NSISOLatin1StringEncoding];
            data = [data gunzippedData];
            NSString *responseData = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
            //DLog(@"responseData:%@",responseData);
            
            
            SBJsonParser *parser = [[SBJsonParser alloc]init];
            id JSON = [parser objectWithString:responseData];
            
            [indicator stopAnimating];
            [indicator removeFromSuperview];
            [nowreadbyteL removeFromSuperview];
            progressView.hidden = NO;
            [self.view bringSubviewToFront:progressView];
            
            [self initTableView:JSON];
            [parser release];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            DLog(@"getAuthCode-Error: %@", error);
        }];
        [aoperation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
            //NSLog(@"Get %lld ", totalBytesRead );
            nowreadbyteL.text = [NSString stringWithFormat:@"正在下载数据:%lldKB",totalBytesRead/1024];
            
        }];
        [aoperation start];
//        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
//            DLog(@"download json over!");
//            
//            
//            [indicator stopAnimating];
//            [indicator removeFromSuperview];
//            [nowreadbyteL removeFromSuperview];
//            
//            progressView.hidden = NO;
//            [self.view bringSubviewToFront:progressView];
//            
//            [self initTableView:JSON];
//            
//        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
//            DLog(@"getAllContacts-Error: %@", error);
//            [[QAlertView sharedInstance] showAlertText:@"网络错误请重试" fadeTime:2];
//        }];
//        
//        [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
//            //NSLog(@"Get %lld ", totalBytesRead );
//            nowreadbyteL.text = [NSString stringWithFormat:@"正在下载数据:%lldKB",totalBytesRead/1024];
//            
//        }];
//        
//        [operation start];
    }
}

-(void)getAllContacts:(NSString *)token
{
    //更新token
    [self fetchingContacts:token];
    //[self fadeCoverImageWithSelector:@selector(fetchingContacts:) withObject:token];
}

-(void)recursiveInitTableView:(NSArray *)allUsersDict db:(FMDatabase *)db superIndex:(int)superIndex index:(int)index
{
    //DLog(@"recursiveInitTableView:%d",allUsersDict.count);
    for (int i=0;i<allUsersDict.count;i++){
        NSDictionary *tempItem = [allUsersDict objectAtIndex:i];
        //判断是部门还是个人
        NSString *username = [tempItem objectForKey:@"username"];
        //DLog(@"username is %@",username);
        NSString *sql = @"";
        if (username == nil || username == [NSNull null]){ //部门
            
            for (id key in [allUsersDict objectAtIndex:i]){

                NSArray *usersDict = [[allUsersDict objectAtIndex:i] objectForKey:key];

                sql = [[[NSString alloc] initWithFormat:@"INSERT INTO `department`(deptid,departname,pid) VALUES ('%d','%@','%d');",deptIndex,key,superIndex] autorelease];
                
                deptIndex ++;
                //部门添加结束
                [self recursiveInitTableView:usersDict db:db superIndex:deptIndex-1 index:index];

                //添加部门列表
                [db executeUpdate:sql];
                //NSLog(@"sql is %@",sql);
                
            }
            
        }else{//个人
            //每个部门下面是个人，添加个人
            NSDictionary *oneUserDict = tempItem;
            //NSLog(@"key is %@",oneUserDict);
            NSString *hzName = [oneUserDict objectForKey:@"username"];
            hzName = [hzName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if ([hzName isEqualToString:@""]) continue;
            NSString *tel1 = [oneUserDict objectForKey:@"workCellPhone"];
            NSString *tel2 = [oneUserDict objectForKey:@"personalCellPhone"];
            NSString *tel3 = [oneUserDict objectForKey:@"workingPhone"];
            NSString *tel4 = [oneUserDict objectForKey:@"homePhone"];
            NSString *tel5 = [oneUserDict objectForKey:@"shortNum"];
            NSString *personID = [oneUserDict objectForKey:@"id"];
            NSArray *pyArray = [oneUserDict objectForKey:@"pinyin"];
            NSArray *pysxArray = [oneUserDict objectForKey:@"firstPinyin"];
            NSString *pyName = @"";
            NSString *pySX = @"";
            NSString *indexSearch = @"";
            NSString *phoneSearch = [[NSString alloc] initWithFormat:@"%@,%@,%@,%@,%@",tel1,tel2,tel3,tel4,tel5];
            int minArrayCount = fmin([pyArray count],[pysxArray count]);
            for (int iPy = 0;iPy<minArrayCount;iPy++){
                pyName = [pyArray objectAtIndex:iPy];
                
                pySX = [pysxArray objectAtIndex:iPy];
                pySX = [pySX uppercaseString];
                
                NSString *numberedStr = @"";
                NSString *numberedShort = @"";
                for (int ind=0;ind<pyName.length;ind++){
                    NSString *letter = [pyName substringWithRange:NSMakeRange(ind, 1)];
                    numberedStr = [numberedStr stringByAppendingFormat:@"%@",[letterDict objectForKey:[letter uppercaseString]]];
                }
                for (int ind=0;ind<pySX.length;ind++){
                    NSString *letter = [pySX substringWithRange:NSMakeRange(ind, 1)];
                    numberedShort = [numberedShort stringByAppendingFormat:@"%@",[letterDict objectForKey:[letter uppercaseString]]];
                }
                indexSearch = [[NSString alloc] initWithFormat:@"%@,%@",numberedShort,numberedStr];
                
                NSString *pysql = [[[NSString alloc] initWithFormat:@"INSERT INTO `spell_list`(index_search,index_fullspell,index_shortspell,fullspell,shortspell,aid) VALUES ('%@', '%@','%@','%@', '%@','%@');",indexSearch,numberedStr,numberedShort,pyName,pySX,personID] autorelease];
                [db executeUpdate:pysql];
            }
            /* 老的转换逻辑,现在拼音转换由服务器完成，减少app负担
             NSString *pyName = [POAPinyin quickConvert:hzName];
             NSArray *sxArr = [pyName componentsSeparatedByString:@","];
             NSString *pySX = @"";
             for (int si=0;si<sxArr.count;si++){
             if ([sxArr objectAtIndex:si] != [NSNull null]){
             NSString *sxStr = (NSString*)[sxArr objectAtIndex:si];
             if (sxStr.length >0)
             pySX = [pySX stringByAppendingFormat:@"%@",[(NSString*)[sxArr objectAtIndex:si] substringWithRange:NSMakeRange(0, 1)]];
             }
             }
             pyName = [pyName stringByReplacingOccurrencesOfString:@"," withString:@""];
             */
            
            
            NSString *email = [oneUserDict objectForKey:@"email"];
            NSString *title = [oneUserDict objectForKey:@"title"];
            
            NSString *subsql = [[[NSString alloc] initWithFormat:@"INSERT INTO `address_list`(id,fullname,workcell,privatecell,workphone,homephone,shortphone,fullspell,shortspell,title,jobID,deptID,email,index_search) VALUES ('%@','%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%d', '%d','%@','%@');",personID,hzName,tel1,tel2,tel3,tel4,tel5,pyName,pySX,title,1,superIndex,email,phoneSearch] autorelease];
            //NSLog(@"sql is %@",subsql);
            [db executeUpdate:subsql];
            insertIndex ++;
            
        }
    }
    //如果没有子节点≥
    dispatch_sync(dispatch_get_main_queue(), ^{
        progressView.progress = progressView.progress + ((float)allUsersDict.count/allCount)*0.5f;
        //DLog(@"progress:%f",progressView.progress);
    });
    
    return;
}


//linwei 多级部门解析
-(void)initTableView:(NSDictionary *)JSON
{
    dispatch_queue_t taskQ = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(taskQ, ^{
        //读取更新标志，如果为1就不再重新建库，如果为0或空就查询并建库
        //[[QAlertView sharedInstance] showAlertText:[CfgManager getConfig:@"updated"] fadeTime:2];
        if ([CfgManager getConfig:@"updated"] && [[CfgManager getConfig:@"updated"] isEqualToString:@"1"]){
            
        }else{
            DLog(@"getted data from server");
            allCount = [[JSON objectForKey:@"userCount"] intValue];
            
            //NSString *dbPath = [[NSBundle mainBundle]  pathForResource:@"tongxunludb" ofType:@"db" inDirectory:@""];
            NSString *dbPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"tongxunludb.db"];
            FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
            if (![db open]) {
                NSLog(@"Could not open db.");
            }
            
            //进行初始化的清空
            insertIndex = 1;
            deptIndex = 1;

            
            NSString *sql = @"delete from commonused_list;";
            [db executeUpdate:sql];
            
//            NSString *sql = @"delete from department;";
//            [db executeUpdate:sql];
//            
//            sql = @"delete from address_list;";
//            [db executeUpdate:sql];
//            
//            sql = @"delete from spell_list;";
//            [db executeUpdate:sql];
            
            sql = @"DROP TABLE IF EXISTS address_list";
            [db executeUpdate:sql];
            sql = @"DROP TABLE IF EXISTS department";
            [db executeUpdate:sql];
            sql = @"DROP TABLE IF EXISTS spell_list";
            [db executeUpdate:sql];
            
            sql = @"CREATE TABLE IF NOT EXISTS  spell_list (id integer  PRIMARY KEY AUTOINCREMENT DEFAULT NULL,index_search TEXT,index_shortspell varchar(255), index_fullspell TEXT,fullspell TEXT,shortspell varchar(255) ,aid integer)";
            [db executeUpdate:sql];
            sql = @"CREATE TABLE IF NOT EXISTS  `department` (`deptid` integer NOT NULL PRIMARY KEY  autoincrement,`departname` varchar(255) default NULL,`pid` integer NOT NULL default '0',`list_order` integer NOT NULL default '0')";
            [db executeUpdate:sql];
            sql = @"CREATE TABLE IF NOT EXISTS  address_list (id Integer Primary Key AUTOINCREMENT,fullname TEXT,workcell TEXT,privatecell TEXT,workphone TEXT,homephone TEXT,shortphone TEXT,fullspell TEXT,shortspell TEXT,title TEXT,jobID Integer,deptID Integer,\"email\" TEXT,index_search TEXT,bcommon integer  DEFAULT 0)";
            [db executeUpdate:sql];
            
            
            
            for (int sInd = 0;sInd<10;sInd++){
                dispatch_sync(dispatch_get_main_queue(), ^{
                    progressView.progress = 0.2*sInd/10.0f;
                });
                sql = [[NSString alloc] initWithFormat:@" DROP TABLE IF EXISTS quickt%d ",sInd];
                [db executeUpdate:sql];
                sql = [[[NSString alloc] initWithFormat:@"CREATE TABLE IF NOT EXISTS  quickt%d (roworder integer,PERSONID Integer,id Integer,name TEXT,workcell TEXT,privatecell TEXT,workphone TEXT,homephone TEXT,shortphone TEXT,fullspell TEXT,shortspell varchar(255),jobname TEXT,departname TEXT,new_index_search TEXT,deptID Integer)",sInd ] autorelease];
                [db executeUpdate:sql];
                
                for (int sInd_2=0;sInd_2<10;sInd_2++){
                    sql = [[NSString alloc] initWithFormat:@" DROP TABLE IF EXISTS quickt%d%d ",sInd,sInd_2];
                    [db executeUpdate:sql];
                    sql = [[[NSString alloc] initWithFormat:@"CREATE TABLE IF NOT EXISTS  quickt%d%d (roworder integer,PERSONID Integer,id Integer,name TEXT,workcell TEXT,privatecell TEXT,workphone TEXT,homephone TEXT,shortphone TEXT,fullspell TEXT,shortspell varchar(255),jobname TEXT,departname TEXT,new_index_search TEXT,deptID Integer )",sInd,sInd_2 ] autorelease];
                    [db executeUpdate:sql];
                    
                    for (int sInd_3=0;sInd_3<10;sInd_3++){
                        sql = [[NSString alloc] initWithFormat:@" DROP TABLE IF EXISTS quickt%d%d%d ",sInd,sInd_2,sInd_3];
                        //[db executeUpdate:sql];
                    }
                    
                }
            }
            
            NSArray *allUsersDict = [JSON objectForKey:@"allUser"];
            [db beginTransaction];
            [self recursiveInitTableView:allUsersDict db:db superIndex:0 index:0];
            //[db commit];

            //创建九宫缩写->全拼->号码 优先级索引表
            //0,1没有拼音缩写，所以不建二，三级表
            //[db beginTransaction];
            for (int sInd = 0;sInd<2;sInd++){

                sql = [[NSString alloc] initWithFormat:@"insert into quickt%d SELECT * FROM ( SELECT 1 AS roworder, a.id AS PERSONID,a.id as id, a.fullname as name,a.workcell as workcell,a.privatecell as privatecell,a.workphone as workphone,a.homephone as homephone,a.shortphone as shortphone,s.fullspell as fullspell,s.shortspell as shortspell,a.title as jobname,d.departname as departname,a.index_search||','||s.index_search  as new_index_search, a.deptid as deptid FROM department as d, address_list as a , spell_list as s  where a.index_search like '%%%d%%' and a.deptid = d.deptid and a.id = s.aid) group by id ",sInd,sInd];
                
                [db executeUpdate:sql];
            }
            
            
            for (int sInd = 2;sInd<10;sInd++){
                dispatch_sync(dispatch_get_main_queue(), ^{
                    progressView.progress =progressView.progress + 0.3/8.0f;
                });
//                sql = [[NSString alloc] initWithFormat:@" CREATE TABLE quickt%d AS SELECT * FROM ( SELECT 1 AS roworder, a.id AS PERSONID,a.id as id, a.fullname as name,a.workcell as workcell,a.privatecell as privatecell,a.workphone as workphone,a.homephone as homephone,a.shortphone as shortphone,s.fullspell as fullspell,s.shortspell as shortspell,a.title as jobname,d.departname as departname,a.index_search||','||s.index_search  as new_index_search, a.deptid as deptid FROM department as d, address_list as a , spell_list as s  where a.index_search like '%%%d%%' and a.deptid = d.deptid and a.id = s.aid union SELECT 2 AS roworder, a.id AS PERSONID,a.id as id, a.fullname as name,a.workcell as workcell,a.privatecell as privatecell,a.workphone as workphone,a.homephone as homephone,a.shortphone as shortphone,s.fullspell as fullspell,s.shortspell as shortspell,a.title as jobname,d.departname as departname,a.index_search||','||s.index_search as new_index_search ,a.deptid as deptid  FROM department as d, address_list as a , spell_list as s  where s.index_fullspell like '%%%d%%' and a.deptid = d.deptid and a.id = s.aid  union SELECT 3 AS roworder, a.id AS PERSONID,a.id as id, a.fullname as name,a.workcell as workcell,a.privatecell as privatecell,a.workphone as workphone,a.homephone as homephone,a.shortphone as shortphone,s.fullspell as fullspell,s.shortspell as shortspell,a.title as jobname,d.departname as departname,a.index_search||','||s.index_search as new_index_search ,a.deptid as deptid FROM department as d, address_list as a , spell_list as s  where s.index_shortspell like '%%%d%%' and a.deptid = d.deptid and a.id = s.aid) group by id ",sInd,sInd,sInd,sInd];
                sql = [[NSString alloc] initWithFormat:@"insert into quickt%d SELECT * FROM ( SELECT 1 AS roworder, a.id AS PERSONID,a.id as id, a.fullname as name,a.workcell as workcell,a.privatecell as privatecell,a.workphone as workphone,a.homephone as homephone,a.shortphone as shortphone,s.fullspell as fullspell,s.shortspell as shortspell,a.title as jobname,d.departname as departname,a.index_search||','||s.index_search  as new_index_search, a.deptid as deptid FROM department as d, address_list as a , spell_list as s  where a.index_search like '%%%d%%' and a.deptid = d.deptid and a.id = s.aid union SELECT 2 AS roworder, a.id AS PERSONID,a.id as id, a.fullname as name,a.workcell as workcell,a.privatecell as privatecell,a.workphone as workphone,a.homephone as homephone,a.shortphone as shortphone,s.fullspell as fullspell,s.shortspell as shortspell,a.title as jobname,d.departname as departname,a.index_search||','||s.index_search as new_index_search ,a.deptid as deptid  FROM department as d, address_list as a , spell_list as s  where s.index_fullspell like '%%%d%%' and a.deptid = d.deptid and a.id = s.aid  union SELECT 3 AS roworder, a.id AS PERSONID,a.id as id, a.fullname as name,a.workcell as workcell,a.privatecell as privatecell,a.workphone as workphone,a.homephone as homephone,a.shortphone as shortphone,s.fullspell as fullspell,s.shortspell as shortspell,a.title as jobname,d.departname as departname,a.index_search||','||s.index_search as new_index_search ,a.deptid as deptid FROM department as d, address_list as a , spell_list as s  where s.index_shortspell like '%%%d%%' and a.deptid = d.deptid and a.id = s.aid) group by id ",sInd,sInd,sInd,sInd];
                
                [db executeUpdate:sql];

                
                
                //DLog(@"sql is %@",sql);
                for (int sInd_2=2;sInd_2<10;sInd_2++){
                    
                    sql = [[NSString alloc] initWithFormat:@" insert into quickt%d%d SELECT * FROM (SELECT 1 AS roworder, a.id AS PERSONID,a.id as id, a.fullname as name,a.workcell as workcell,a.privatecell as privatecell,a.workphone as workphone,a.homephone as homephone,a.shortphone as shortphone,s.fullspell as fullspell,s.shortspell as shortspell,a.title as jobname,d.departname as departname,a.index_search||','||s.index_search as new_index_search,a.deptid as deptid  FROM department as d, address_list as a , spell_list as s  where a.index_search like '%%%d%d%%' and a.deptid = d.deptid and a.id = s.aid union SELECT 2 AS roworder, a.id AS PERSONID,a.id as id, a.fullname as name,a.workcell as workcell,a.privatecell as privatecell,a.workphone as workphone,a.homephone as homephone,a.shortphone as shortphone,s.fullspell as fullspell,s.shortspell as shortspell,a.title as jobname,d.departname as departname,a.index_search||','||s.index_search as new_index_search,a.deptid as deptid  FROM department as d, address_list as a , spell_list as s  where s.index_fullspell like '%%%d%d%%' and a.deptid = d.deptid and a.id = s.aid union SELECT 3 AS roworder, a.id AS PERSONID,a.id as id, a.fullname as name,a.workcell as workcell,a.privatecell as privatecell,a.workphone as workphone,a.homephone as homephone,a.shortphone as shortphone,s.fullspell as fullspell,s.shortspell as shortspell,a.title as jobname,d.departname as departname,a.index_search||','||s.index_search as new_index_search ,a.deptid as deptid FROM department as d, address_list as a , spell_list as s  where s.index_shortspell like '%%%d%d%%' and a.deptid = d.deptid and a.id = s.aid ) group by id",sInd,sInd_2,sInd,sInd_2,sInd,sInd_2,sInd,sInd_2];
//                    sql = [[NSString alloc] initWithFormat:@" insert into quickt%d%d SELECT * FROM (SELECT 1 AS roworder, a.id AS PERSONID,a.id as id, a.name as name,a.workcell as workcell,a.privatecell as privatecell,a.workphone as workphone,a.homephone as homephone,a.shortphone as shortphone,s.fullspell as fullspell,s.shortspell as shortspell,a.jobname as jobname,d.departname as departname,a.new_index_search as new_index_search ,a.deptid as deptid FROM department as d, quickt%d as a , spell_list as s  where a.new_index_search like '%%%d%d%%' and a.deptid = d.deptid and a.id = s.aid union SELECT 2 AS roworder, a.id AS PERSONID,a.id as id, a.name as name,a.workcell as workcell,a.privatecell as privatecell,a.workphone as workphone,a.homephone as homephone,a.shortphone as shortphone,s.fullspell as fullspell,s.shortspell as shortspell,a.jobname as jobname,d.departname as departname,a.new_index_search  as new_index_search,a.deptid as deptid FROM department as d, quickt%d as a , spell_list as s  where s.index_fullspell like '%%%d%d%%' and a.deptid = d.deptid and a.id = s.aid union SELECT 3 AS roworder, a.id AS PERSONID,a.id as id, a.name as name,a.workcell as workcell,a.privatecell as privatecell,a.workphone as workphone,a.homephone as homephone,a.shortphone as shortphone,s.fullspell as fullspell,s.shortspell as shortspell,a.jobname as jobname,d.departname as departname,a.new_index_search as new_index_search,a.deptid as deptid FROM department as d, quickt%d as a , spell_list as s  where s.index_shortspell like '%%%d%d%%' and a.deptid = d.deptid and a.id = s.aid ) group by id",sInd,sInd_2,sInd,sInd,sInd_2,sInd,sInd,sInd_2,sInd,sInd,sInd_2];
//                    

                    [db executeUpdate:sql];
                   
//                    for (int sInd_3=2;sInd_3<10;sInd_3++){
//                        sql = [[NSString alloc] initWithFormat:@" CREATE TABLE quickt%d%d%d AS SELECT * FROM (SELECT 1 AS roworder, a.id AS PERSONID,a.id as id, a.fullname as name,a.workcell as workcell,a.privatecell as privatecell,a.workphone as workphone,a.homephone as homephone,a.shortphone as shortphone,s.fullspell as fullspell,s.shortspell as shortspell,a.title as jobname,d.departname as departname,a.index_search||','||s.index_search as new_index_search FROM department as d, address_list as a , spell_list as s  where a.index_search like '%%%d%d%d%%' and a.deptid = d.deptid and a.id = s.aid union SELECT 2 AS roworder, a.id AS PERSONID,a.id as id, a.fullname as name,a.workcell as workcell,a.privatecell as privatecell,a.workphone as workphone,a.homephone as homephone,a.shortphone as shortphone,s.fullspell as fullspell,s.shortspell as shortspell,a.title as jobname,d.departname as departname,a.index_search||','||s.index_search as new_index_search FROM department as d, address_list as a , spell_list as s  where s.index_fullspell like '%%%d%d%d%%' and a.deptid = d.deptid and a.id = s.aid union SELECT 3 AS roworder, a.id AS PERSONID,a.id as id, a.fullname as name,a.workcell as workcell,a.privatecell as privatecell,a.workphone as workphone,a.homephone as homephone,a.shortphone as shortphone,s.fullspell as fullspell,s.shortspell as shortspell,a.title as jobname,d.departname as departname,a.index_search||','||s.index_search as new_index_search FROM department as d, address_list as a , spell_list as s  where s.index_shortspell like '%%%d%d%d%%' and a.deptid = d.deptid and a.id = s.aid ) group by id",sInd,sInd_2,sInd_3,sInd,sInd_2,sInd_3,sInd,sInd_2,sInd_3,sInd,sInd_2,sInd_3];
//                        //[db executeUpdate:sql];
//                    }
                    
                }
                
            }
            [db commit];
            

            [db close];

            //更新好后，设置一个更新标志存到文件中
            [CfgManager setConfig:@"updated" detail:@"1"];
            DLog(@"insert db over!");
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            [[[UIApplication sharedApplication] delegate] performSelector:@selector(initTabs)];
        });
    });
    
}

@end
