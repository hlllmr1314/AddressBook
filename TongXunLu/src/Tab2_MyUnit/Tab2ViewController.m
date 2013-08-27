//
//  Tab2ViewController.m
//  TongXunLu
//
//  Created by Pan on 13-4-4.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import "Tab2ViewController.h"

@interface Tab2ViewController ()

@end

@implementation Tab2ViewController
@synthesize departmentID;

-(NSString *)getSQLWithKey:(NSString *)keyname
{
    NSString *search_keyword = [NSString stringWithFormat:@"'%%%@%%'",nowSearchText];
    NSString *returnstr = @"";
    if ([keyname isEqualToString:@"sql_selectCount"]) {
        NSPredicate * pred  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[0-9]+"];
        if ([pred evaluateWithObject:nowSearchText]) {
            returnstr = [[NSString alloc]initWithFormat:@"SELECT count(*) as total from (SELECT a.id from department as d ,address_list as a , spell_list as s where  d.deptid = '%@' and a.deptid = d.deptid and a.id = s.aid  and (a.index_search like %@ or s.index_search like %@) group by a.id)",self.departmentID,search_keyword,search_keyword];
            
        }else{
            search_keyword = [super transferNumber2String:nowSearchText];
            returnstr = [[NSString alloc]initWithFormat:@"SELECT count(*) as total from (SELECT s.aid from spell_list as s,department as d where d.deptid = '%@' and s.aid=a.id and (s.fullspell GLOB '*%@*' or s.shortspell GLOB '*%@*') group by s.aid)",self.departmentID,search_keyword,search_keyword];
        }
    }
    if ([keyname isEqualToString:@"sql_filterABC"]) {
        search_keyword = [self transferNumber2String:nowSearchText];
        returnstr = [[NSString alloc] initWithFormat:@"SELECT a.id AS PERSONID,a.id, a.fullname as name,a.workcell,a.privatecell,a.workphone,a.homephone,a.shortphone,s.fullspell,s.shortspell,a.title as jobname,d.departname,a.index_search||','||s.index_search as new_index_search FROM department as d, address_list as a , spell_list as s  where d.deptid = '%@' and  (s.shortspell GLOB '*%@*' or s.fullspell GLOB '*%@*') and a.deptid = d.deptid and a.id = s.aid group by a.id order by a.id asc ", self.departmentID,search_keyword,search_keyword];
    }
    if ([keyname isEqualToString:@"sql_filterNumber"]) {
        NSPredicate * pred  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @".*[A-Za-z]+.*"];
        if ([pred evaluateWithObject:search_keyword]) {
            search_keyword = [self transferNumber2String:nowSearchText];
           returnstr = [[NSString alloc] initWithFormat:@"SELECT a.id AS PERSONID,a.id, a.fullname as name,a.workcell,a.privatecell,a.workphone,a.homephone,a.shortphone,s.fullspell,s.shortspell,a.title as jobname,d.departname,a.index_search||','||s.index_search as new_index_search FROM department as d, address_list as a , spell_list as s  where d.deptid = '%@' and (s.shortspell GLOB '*%@*' or s.fullspell GLOB '*%@*') and a.deptid = d.deptid and a.id = s.aid group by a.id order by a.id asc",self.departmentID, search_keyword,search_keyword];
        }else{
            NSPredicate * predZero  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @".*0+.*"];
            NSPredicate * predOne  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @".*1+.*"];
            NSPredicate * predNumber  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[2-9]+"];
            //部门搜索
            if ([predZero evaluateWithObject:nowSearchText]){
                returnstr = [[NSString alloc] initWithFormat:@"SELECT a.id AS PERSONID,a.id as id, a.fullname as name,a.workcell as workcell,a.privatecell as privatecell,a.workphone as workphone,a.homephone as homephone,a.shortphone as shortphone,s.fullspell as fullspell,s.shortspell as shortspell,a.title as jobname,d.departname as departname,a.index_search||','||s.index_search as new_index_search from quickt0 as t,department as d, address_list as a,spell_list as s where d.deptid=%@ and a.deptid=d.deptid and t.id = a.id and t.sid = s.id and t.index_search like %@ order by roworder desc,a.id limit %d,%d",self.departmentID,search_keyword,self.searchStartPos,LIST_MAX_LENGTH];
            }else if ([predOne evaluateWithObject:nowSearchText]){
                returnstr = [[NSString alloc] initWithFormat:@"SELECT a.id AS PERSONID,a.id as id, a.fullname as name,a.workcell as workcell,a.privatecell as privatecell,a.workphone as workphone,a.homephone as homephone,a.shortphone as shortphone,s.fullspell as fullspell,s.shortspell as shortspell,a.title as jobname,d.departname as departname,a.index_search||','||s.index_search as new_index_search from quickt1 as t,department as d, address_list as a,spell_list as s where d.deptid=%@ and a.deptid=d.deptid and t.id = a.id and t.sid = s.id and t.index_search like %@ order by roworder desc,a.id limit %d,%d",self.departmentID,search_keyword,self.searchStartPos,LIST_MAX_LENGTH];
            }else if ([predNumber evaluateWithObject:nowSearchText])
                
            {

                if ([nowSearchText length]> CACHE_TABLE_LEVEL){
                    returnstr = [[NSString alloc] initWithFormat:@"SELECT a.id AS PERSONID,a.id as id, a.fullname as name,a.workcell as workcell,a.privatecell as privatecell,a.workphone as workphone,a.homephone as homephone,a.shortphone as shortphone,s.fullspell as fullspell,s.shortspell as shortspell,a.title as jobname,d.departname as departname,a.index_search||','||s.index_search as new_index_search from quickt%@ as t,department as d,address_list as a,spell_list as s where d.deptid=%@ and a.deptid=d.deptid and  (t.index_search like %@ or s.index_search like %@) and t.id = a.id and t.sid = s.id  group by t.id order by roworder desc,a.id asc limit %d,%d",[nowSearchText substringToIndex:CACHE_TABLE_LEVEL],self.departmentID,search_keyword,search_keyword,self.searchStartPos,LIST_MAX_LENGTH];
                }
                else{
                    
                    returnstr = [[NSString alloc] initWithFormat:@"SELECT a.id AS PERSONID,a.id as id, a.fullname as name,a.workcell as workcell,a.privatecell as privatecell,a.workphone as workphone,a.homephone as homephone,a.shortphone as shortphone,s.fullspell as fullspell,s.shortspell as shortspell,a.title as jobname,d.departname as departname,a.index_search||','||s.index_search as new_index_search from quickt%@ as t,address_list as a,department as d,spell_list as s where d.deptid=%@ and a.deptid=d.deptid and a.id = t.id and t.sid = s.id group by t.id order by roworder desc,t.id asc limit %d,%d",nowSearchText,self.departmentID,self.searchStartPos,LIST_MAX_LENGTH];
                    
                    
                }
            }else{
                returnstr = [[NSString alloc] initWithFormat:@"SELECT 1 AS roworder, a.id AS PERSONID,a.id as id, a.fullname as name,a.workcell as workcell,a.privatecell as privatecell,a.workphone as workphone,a.homephone as homephone,a.shortphone as shortphone,s.fullspell as fullspell,s.shortspell as shortspell,a.title as jobname,d.departname as departname,a.index_search||','||s.index_search as new_index_search FROM department as d, address_list as a , spell_list as s  where d.deptid=%@ and a.index_search like %@ and a.deptid = d.deptid and a.id = s.aid union SELECT 2 AS roworder, a.id AS PERSONID,a.id as id, a.fullname as name,a.workcell as workcell,a.privatecell as privatecell,a.workphone as workphone,a.homephone as homephone,a.shortphone as shortphone,s.fullspell as fullspell,s.shortspell as shortspell,a.title as jobname,d.departname as departname,a.index_search||','||s.index_search as new_index_search  FROM department as d, address_list as a , spell_list as s  where d.deptid=%@ and  s.index_fullspell like %@ and a.deptid = d.deptid and a.id = s.aid  union SELECT 3 AS roworder, a.id AS PERSONID,a.id as id, a.fullname as name,a.workcell as workcell,a.privatecell as privatecell,a.workphone as workphone,a.homephone as homephone,a.shortphone as shortphone,s.fullspell as fullspell,s.shortspell as shortspell,a.title as jobname,d.departname as departname,a.index_search||','||s.index_search as new_index_search  FROM department as d, address_list as a , spell_list as s  where  d.deptid=%@ and s.index_shortspell like %@ and a.deptid = d.deptid and a.id = s.aid order by roworder desc,id asc limit %d,%d",self.departmentID,search_keyword,self.departmentID,search_keyword,self.departmentID,search_keyword,self.searchStartPos,LIST_MAX_LENGTH];
            }
        

        }

    }
    
    DLog(@"sql is %@",returnstr);
    return returnstr;
}

@end
