//
//  Tab3SearchResultViewController.m
//  TongXunLu
//
//  Created by Pan on 13-4-3.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import "Tab3SearchResultViewController.h"


@interface Tab3SearchResultViewController ()

@end

@implementation Tab3SearchResultViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)createLazyDBCache
{
    
}

- (NSString *)getQuicktableName
{
    NSString *tableName;
    if ([nowSearchText length]> CACHE_TABLE_LEVEL){
        tableName = [NSString stringWithFormat:@"quickt%@",[nowSearchText substringToIndex:CACHE_TABLE_LEVEL]];
    }else{
        tableName = [NSString stringWithFormat:@"quickt%@",nowSearchText];
    }
    return tableName;
}

- (NSString *)getSQLWithKey:(NSString *)keyname
{
    NSString *search_keyword = [NSString stringWithFormat:@"'%%%@%%'",nowSearchText];
    NSString *returnstr = @"";
    
    if ([keyname isEqualToString:@"sql_selectCount"]){
        //linwei, 考虑到有查多次的情况，需用[0-9]+来匹配
        NSPredicate * pred  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[2-9]+"];
        NSPredicate * predZero  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @".*0+.*"];
        NSPredicate * predOne  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @".*1+.*"];
        NSPredicate * predLetter  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"\\w+.*[0-9]+"];
        if ([predZero evaluateWithObject:nowSearchText]){
            if ([self.departmentID isEqualToString:@""]){
                returnstr = [[NSString alloc] initWithFormat:@"SELECT count(a.id) from quickt0 as a where a.index_search like %@",search_keyword];
            }else{
                returnstr = [[NSString alloc] initWithFormat:@"SELECT count(a.id) from quickt0 as t, address_list as a,department as d where d.deptid=%@ and a.deptid=d.deptid and t.id = a.id and t.index_search like %@",self.departmentID,search_keyword];
            }
        }else if ([predOne evaluateWithObject:nowSearchText]){
            if ([self.departmentID isEqualToString:@""]){
                returnstr = [[NSString alloc] initWithFormat:@"SELECT count(a.id) from quickt1 as a where a.index_search like %@",search_keyword];
            }else{
                returnstr = [[NSString alloc] initWithFormat:@"SELECT count(a.id) from quickt1 as t, address_list as a,department as d where d.deptid=%@ and a.deptid=d.deptid and t.id = a.id and t.index_search like %@",self.departmentID,search_keyword];
            }
        }
        else if ([pred evaluateWithObject:nowSearchText]||[predLetter evaluateWithObject:nowSearchText]) {
            
            
            NSString *tableName = [self getQuicktableName];
            if ([self.departmentID isEqualToString:@""]){
                if ([nowSearchText length]> CACHE_TABLE_LEVEL){
                    returnstr = [[NSString alloc] initWithFormat:@"SELECT count(*) as total FROM (SELECT t.id from %@ as t,spell_list as s where (t.index_search like %@ or s.index_search like %@) and t.sid = s.id group by t.id)",tableName,search_keyword,search_keyword];
                }
                else{
                    returnstr = [[NSString alloc] initWithFormat:@"SELECT count(id) as total FROM (SELECT a.id from %@ as a GROUP BY a.id)",tableName];
                }
            }else{
               returnstr = [[NSString alloc]initWithFormat:@"SELECT count(*) as total from (SELECT a.id from address_list as a,department as d, spell_list as s where d.deptid=%@ and (a.index_search like %@ or s.index_search like %@) and a.deptid=d.deptid and a.id = s.aid group by a.id )",self.departmentID,search_keyword,search_keyword];
            }
            
            
        }else{
            search_keyword = [super transferNumber2String:nowSearchText];
            if ([self.departmentID isEqualToString:@""]){
                returnstr = [[NSString alloc]initWithFormat:@"SELECT count(*) as total from (SELECT s.id from spell_list as s where s.fullspell GLOB '*%@*' or  s.shortspell GLOB '*%@*' group by aid)",search_keyword,search_keyword];
            }else{
                returnstr = [[NSString alloc]initWithFormat:@"SELECT count(*) as total from (SELECT s.id from spell_list as s,address_list as a where a.deptid=%@ and a.id = s.aid and (s.fullspell GLOB '*%@*' or  s.shortspell GLOB '*%@*') group by aid)",self.departmentID,search_keyword,search_keyword];
            }
        }
        
    }else if ([keyname isEqualToString:@"sql_filterABC"]) {
        search_keyword = [super transferNumber2String:nowSearchText];
        if ([self.departmentID isEqualToString:@""]){
            returnstr = [[NSString alloc]initWithFormat:@"SELECT a.id AS PERSONID,a.id, a.fullname as name,a.workcell,a.privatecell,a.workphone,a.homephone,a.shortphone,s.fullspell,s.shortspell,a.email,a.title as jobname,d.departname,a.index_search||','||s.index_search as new_index_search FROM address_list as a ,spell_list as s, department as d where (s.fullspell GLOB '*%@*' or s.shortspell GLOB '*%@*') and a.deptid = d.deptid and a.id = s.aid group by a.id order by a.id asc limit %d,%d", search_keyword, search_keyword,self.searchStartPos,LIST_MAX_LENGTH];
        }else{
            returnstr = [[NSString alloc]initWithFormat:@"SELECT a.id AS PERSONID,a.id, a.fullname as name,a.workcell,a.privatecell,a.workphone,a.homephone,a.shortphone,s.fullspell,s.shortspell,a.email,a.title as jobname,d.departname,a.index_search||','||s.index_search as new_index_search FROM address_list as a ,spell_list as s, department as d where d.deptid=%@ and (s.fullspell GLOB '*%@*' or s.shortspell GLOB '*%@*') and a.deptid = d.deptid and a.id = s.aid  group by a.id  order by a.id asc limit %d,%d",self.departmentID, search_keyword, search_keyword,self.searchStartPos,LIST_MAX_LENGTH];
        }
        
        
    }else if ([keyname isEqualToString:@"sql_filterNumber"]) {
        
        NSString *tableName = [self getQuicktableName];
        NSPredicate * pred  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[2-9]+"];
        NSPredicate * predZero  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @".*0+.*"];
        NSPredicate * predOne  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @".*1+.*"];
        
        
        if ([self.departmentID isEqualToString:@""]){
            if ([predZero evaluateWithObject:nowSearchText]){
                    returnstr = [[NSString alloc] initWithFormat:@"SELECT a.id AS PERSONID,a.id as id, a.fullname as name,a.workcell as workcell,a.privatecell as privatecell,a.workphone as workphone,a.homephone as homephone,a.shortphone as shortphone,s.fullspell as fullspell,s.shortspell as shortspell,a.title as jobname,d.departname as departname,a.index_search||','||s.index_search as new_index_search from %@ as t,department as d,address_list as a,spell_list as s where t.index_search like %@ and a.id = t.id and s.id =t.sid and a.deptid = d.deptid order by roworder desc,id asc limit %d,%d",@"quickt0",search_keyword,self.searchStartPos,LIST_MAX_LENGTH];
            }else if ([predOne evaluateWithObject:nowSearchText]){
                    returnstr = [[NSString alloc] initWithFormat:@"SELECT a.id AS PERSONID,a.id as id, a.fullname as name,a.workcell as workcell,a.privatecell as privatecell,a.workphone as workphone,a.homephone as homephone,a.shortphone as shortphone,s.fullspell as fullspell,s.shortspell as shortspell,a.title as jobname,d.departname as departname,a.index_search||','||s.index_search as new_index_search from %@ as t,department as d,address_list as a,spell_list as s where t.index_search like %@ and a.id = t.id and s.id =t.sid and a.deptid = d.deptid order by roworder desc,id asc limit %d,%d",@"quickt1",search_keyword,self.searchStartPos,LIST_MAX_LENGTH];
            }else if ([pred evaluateWithObject:nowSearchText]){
                if ([nowSearchText length]> CACHE_TABLE_LEVEL){
                    //完整结果表
//                    returnstr = [[[NSString alloc] initWithFormat:@"SELECT * from %@ as a where a.new_index_search like %@ order by roworder desc,id asc limit %d,%d",tableName,search_keyword,self.searchStartPos,LIST_MAX_LENGTH] autorelease];
                    returnstr = [[NSString alloc] initWithFormat:@"SELECT a.id AS PERSONID,a.id as id, a.fullname as name,a.workcell as workcell,a.privatecell as privatecell,a.workphone as workphone,a.homephone as homephone,a.shortphone as shortphone,s.fullspell as fullspell,s.shortspell as shortspell,a.title as jobname,d.departname as departname,a.index_search||','||s.index_search as new_index_search from %@ as t,spell_list as s,department as d,address_list as a where (t.index_search like %@ or s.index_search like %@) and t.id =a.id and t.sid =s.id  and a.deptid = d.deptid group by t.id order by roworder desc,id asc limit %d,%d",tableName,search_keyword,search_keyword,self.searchStartPos,LIST_MAX_LENGTH];
                }
                else{
                    NSString *groupby = @" group by id ";
                    if ([nowSearchText length] == 1){
                        groupby = @" ";
                    }
                    returnstr = [[NSString alloc] initWithFormat:@"SELECT a.id AS PERSONID,a.id as id, a.fullname as name,a.workcell as workcell,a.privatecell as privatecell,a.workphone as workphone,a.homephone as homephone,a.shortphone as shortphone,s.fullspell as fullspell,s.shortspell as shortspell,a.title as jobname,d.departname as departname,a.index_search||','||s.index_search as new_index_search from %@ as t,department as d,address_list as a,spell_list as s where t.id =a.id and t.sid =s.id and a.deptid = d.deptid %@ order by roworder desc,id asc limit %d,%d",tableName,groupby,self.searchStartPos,LIST_MAX_LENGTH];
                    
                }
            }else{
                returnstr = [[NSString alloc] initWithFormat:@"SELECT 1 AS roworder, a.id AS PERSONID,a.id as id, a.fullname as name,a.workcell as workcell,a.privatecell as privatecell,a.workphone as workphone,a.homephone as homephone,a.shortphone as shortphone,s.fullspell as fullspell,s.shortspell as shortspell,a.title as jobname,d.departname as departname,a.index_search||','||s.index_search as new_index_search FROM department as d, address_list as a , spell_list as s  where a.index_search like %@ and a.deptid = d.deptid and a.id = s.aid union SELECT 2 AS roworder, a.id AS PERSONID,a.id as id, a.fullname as name,a.workcell as workcell,a.privatecell as privatecell,a.workphone as workphone,a.homephone as homephone,a.shortphone as shortphone,s.fullspell as fullspell,s.shortspell as shortspell,a.title as jobname,d.departname as departname,a.index_search||','||s.index_search as new_index_search  FROM department as d, address_list as a , spell_list as s  where s.index_fullspell like %@ and a.deptid = d.deptid and a.id = s.aid  union SELECT 3 AS roworder, a.id AS PERSONID,a.id as id, a.fullname as name,a.workcell as workcell,a.privatecell as privatecell,a.workphone as workphone,a.homephone as homephone,a.shortphone as shortphone,s.fullspell as fullspell,s.shortspell as shortspell,a.title as jobname,d.departname as departname,a.index_search||','||s.index_search as new_index_search  FROM department as d, address_list as a , spell_list as s  where s.index_shortspell like %@ and a.deptid = d.deptid and a.id = s.aid order by roworder desc,id asc limit %d,%d",search_keyword,search_keyword,search_keyword,self.searchStartPos,LIST_MAX_LENGTH];
            }


        }else{
            //部门搜索
            if ([predZero evaluateWithObject:nowSearchText]){
                    returnstr = [[NSString alloc] initWithFormat:@"SELECT a.id AS PERSONID,a.id as id, a.fullname as name,a.workcell as workcell,a.privatecell as privatecell,a.workphone as workphone,a.homephone as homephone,a.shortphone as shortphone,s.fullspell as fullspell,s.shortspell as shortspell,a.title as jobname,d.departname as departname,a.index_search||','||s.index_search as new_index_search from quickt0 as t,department as d, address_list as a,spell_list as s where d.deptid=%@ and a.deptid=d.deptid and t.id = a.id and t.sid = s.id and t.index_search like %@ order by roworder desc,a.id limit %d,%d",self.departmentID,search_keyword,self.searchStartPos,LIST_MAX_LENGTH];
            }else if ([predOne evaluateWithObject:nowSearchText]){
                returnstr = [[NSString alloc] initWithFormat:@"SELECT a.id AS PERSONID,a.id as id, a.fullname as name,a.workcell as workcell,a.privatecell as privatecell,a.workphone as workphone,a.homephone as homephone,a.shortphone as shortphone,s.fullspell as fullspell,s.shortspell as shortspell,a.title as jobname,d.departname as departname,a.index_search||','||s.index_search as new_index_search from quickt1 as t,department as d, address_list as a,spell_list as s where d.deptid=%@ and a.deptid=d.deptid and t.id = a.id and t.sid = s.id and t.index_search like %@ order by roworder desc,a.id limit %d,%d",self.departmentID,search_keyword,self.searchStartPos,LIST_MAX_LENGTH];
            }else if ([pred evaluateWithObject:nowSearchText]){
                if ([nowSearchText length]> CACHE_TABLE_LEVEL){
                    returnstr = [[NSString alloc] initWithFormat:@"SELECT a.id AS PERSONID,a.id as id, a.fullname as name,a.workcell as workcell,a.privatecell as privatecell,a.workphone as workphone,a.homephone as homephone,a.shortphone as shortphone,s.fullspell as fullspell,s.shortspell as shortspell,a.title as jobname,d.departname as departname,a.index_search||','||s.index_search as new_index_search from %@ as t,department as d,address_list as a,spell_list as s where d.deptid=%@ and a.deptid=d.deptid and  (t.index_search like %@ or s.index_search like %@) and t.id = a.id and t.sid = s.id  group by t.id order by roworder desc,a.id asc limit %d,%d",tableName,self.departmentID,search_keyword,search_keyword,self.searchStartPos,LIST_MAX_LENGTH];
                }
                else{
                    
                    returnstr = [[NSString alloc] initWithFormat:@"SELECT a.id AS PERSONID,a.id as id, a.fullname as name,a.workcell as workcell,a.privatecell as privatecell,a.workphone as workphone,a.homephone as homephone,a.shortphone as shortphone,s.fullspell as fullspell,s.shortspell as shortspell,a.title as jobname,d.departname as departname,a.index_search||','||s.index_search as new_index_search from %@ as t,address_list as a,department as d,spell_list as s where d.deptid=%@ and a.deptid=d.deptid and a.id = t.id and t.sid = s.id group by t.id order by roworder desc,t.id asc limit %d,%d",tableName,self.departmentID,self.searchStartPos,LIST_MAX_LENGTH];
                    
                    
                }
            }else{
                        returnstr = [[NSString alloc] initWithFormat:@"SELECT 1 AS roworder, a.id AS PERSONID,a.id as id, a.fullname as name,a.workcell as workcell,a.privatecell as privatecell,a.workphone as workphone,a.homephone as homephone,a.shortphone as shortphone,s.fullspell as fullspell,s.shortspell as shortspell,a.title as jobname,d.departname as departname,a.index_search||','||s.index_search as new_index_search FROM department as d, address_list as a , spell_list as s  where d.deptid=%@ and a.index_search like %@ and a.deptid = d.deptid and a.id = s.aid union SELECT 2 AS roworder, a.id AS PERSONID,a.id as id, a.fullname as name,a.workcell as workcell,a.privatecell as privatecell,a.workphone as workphone,a.homephone as homephone,a.shortphone as shortphone,s.fullspell as fullspell,s.shortspell as shortspell,a.title as jobname,d.departname as departname,a.index_search||','||s.index_search as new_index_search  FROM department as d, address_list as a , spell_list as s  where d.deptid=%@ and  s.index_fullspell like %@ and a.deptid = d.deptid and a.id = s.aid  union SELECT 3 AS roworder, a.id AS PERSONID,a.id as id, a.fullname as name,a.workcell as workcell,a.privatecell as privatecell,a.workphone as workphone,a.homephone as homephone,a.shortphone as shortphone,s.fullspell as fullspell,s.shortspell as shortspell,a.title as jobname,d.departname as departname,a.index_search||','||s.index_search as new_index_search  FROM department as d, address_list as a , spell_list as s  where  d.deptid=%@ and s.index_shortspell like %@ and a.deptid = d.deptid and a.id = s.aid order by roworder desc,id asc limit %d,%d",self.departmentID,search_keyword,self.departmentID,search_keyword,self.departmentID,search_keyword,self.searchStartPos,LIST_MAX_LENGTH];
            }
        }
    }
    DLog(@"returnstr is %@",returnstr);
    return returnstr;
}

@end
