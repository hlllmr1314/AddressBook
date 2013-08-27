//
//  PersonDetailUIView.m
//  TongXunLu
//
//  Created by pan on 13-3-19.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import "PersonDetailUIView.h"
#import "Department.h"
#import "PersonDetailCell.h"
#import "NetClient+ToPath.h"

@implementation PersonDetailUIView
{
    NSArray *arrAllDicPhones;
}
@synthesize _dict;
@synthesize vController;

#define STAG_PHONE 889
#define STAG_MAIL 1200



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(0xe1e0de);
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(9, 92, 320-18, 240)];
        
        [self addSubview:_tableView];
       
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.separatorColor = [UIColor lightGrayColor];
        _tableView.scrollEnabled = NO;
        _tableView.layer.cornerRadius = 8;
        _tableView.layer.masksToBounds = YES;
        _tableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _tableView.layer.borderWidth = 1.0f;
    }
    return self;
}



- (void)drawRect:(CGRect)rect
{
   
    if (_person == nil) return;
    
    [[UIImage imageNamed:@"touxiang.png"] drawInRect:CGRectMake(18, 13, 67, 67)];

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 1.0f, 1.0f, 1.0f, 1.0f);
    CGContextSetShadowWithColor (context, CGSizeMake(1.0f, 1.0f), 1.0f, [UIColor whiteColor].CGColor);
    
    [[UIColor blackColor] set];
    [_person.username drawAtPoint:CGPointMake(102, 18) withFont:[UIFont boldSystemFontOfSize:16]];
    
    [UIColorFromRGB(0x7a7a7a) set];
    [[NSString stringWithFormat:@"职位：%@",_person.title] drawAtPoint:CGPointMake(102, 43) withFont:[UIFont systemFontOfSize:14]];
    [[NSString stringWithFormat:@"所属单位：%@",_person.depart.name] drawAtPoint:CGPointMake(102, 62) withFont:[UIFont systemFontOfSize:14]];
    
};

-(void)refreshView:(NSDictionary *)dict
{
    DLog(@"%@",dict);
//    self._dict = dict;
//    [self setNeedsDisplay];
//    
//    [_infoArray removeAllObjects];
//    
//    NSArray *keys = [NSArray arrayWithObjects:@"workcell",@"privatecell",@"workphone",@"homephone",@"shortphone",@"email", nil];
//    for (int i=0; i< keys.count; i++) {
//        NSString *string = [_dict objectForKey:[keys objectAtIndex:i]];
//        if (string == nil || [string isEqual:[NSNull null]]) string = @"";
//        [_infoArray addObject:string];
//    }
//    [self removeNil];
//    [_tableView reloadData];
}

- (void)setPerson:(Person *)person
{
    _person = person;
    arrAllDicPhones = [person arrAllDicPhones];
//    _dict = [[NSMutableDictionary alloc]initWithCapacity:2];
//    _dict[@"jobname"] = person.title;
//    _dict[@"departname"] = person.depart.name;
//    _dict[@"name"] = person.username;
//    dicParam = [person dicPhones];
    CGRect rectPro = _tableView.frame;
    rectPro.size.height = 40*arrAllDicPhones.count;
    _tableView.frame = rectPro;
    //[self setNeedsDisplay];
}

#pragma - tableView delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return [arrAllDicPhones count];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSString *value = [arrAllDicPhones[indexPath.row] allValues][0];
    NSString *tel;
   
    if (![[arrAllDicPhones[indexPath.row] allKeys][0] isEqualToString:@"E-mail"]){       
        [[NetClient sharedClient] doPath:@"post" path:@"system/stats" parameters:@{@"stats_type":@"outgoing_phone_call",@"data":[NetClient strFromDic:@{@"outgoing":[arrAllDicPhones[indexPath.row] allValues][0]}] } success:^(NSMutableDictionary *dic) {
          
        } failure:^(NSMutableDictionary *dic) {
            
        } withToken:YES toJson:NO isNotForm:NO parameterEncoding:AFFormURLParameterEncoding];
        tel = [NSString stringWithFormat:@"telprompt://%@",value];
    }else{
        tel = [NSString stringWithFormat:@"mailto:%@",value];
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tel]];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    PersonDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[PersonDetailCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
        cell.textLabel.textColor = UIColorFromRGB(0x7a7a7a);
        cell.textLabel.textAlignment = UITextAlignmentLeft;
        cell.textLabel.font =  [UIFont systemFontOfSize:14];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    }
    NSString *title = [arrAllDicPhones[indexPath.row] allKeys][0];
    NSString *value = [arrAllDicPhones[indexPath.row] allValues][0];
    cell.textLabel.text = title;
    cell.detailTextLabel.text = value;
    if (![title isEqualToString:@""]&&([title isEqualToString:@"工作手机"]||[title isEqualToString:@"私人手机"]||[title isEqualToString:@"手机虚拟网"])) {
        cell.imageMsg = [UIImage imageNamed:@"duanxin"];
        cell.singleTap = ^{
            MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
            picker.messageComposeDelegate = self;
            picker.navigationBar.tintColor = [UIColor colorWithRed:24.0/255.0 green:38.0/255.0 blue:37.0/255.0 alpha:1];
            picker.recipients = @[value];
            if (vController) {
                [vController presentModalViewController:picker animated:YES];
            }    
        };
    }else{
        cell.imageMsg = nil;
    }
    
    return cell;
    
//    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        cell.backgroundColor = [UIColor whiteColor];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.customSubviewFrames = YES;
//        
//        float cellHeight = [self tableView:tableView heightForRowAtIndexPath:indexPath];
//        cell.cLabel1.frame = CGRectMake(15, 0, 70, cellHeight);
//        cell.cLabel1.textColor = UIColorFromRGB(0x7a7a7a);
//        cell.cLabel1.font = [UIFont systemFontOfSize:14];
//        
//        UITapGestureRecognizer* singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
//        singleRecognizer.numberOfTapsRequired = 1;
//        cell.cLabel2.frame = CGRectMake(92, 0, 150, cellHeight);
//        cell.cLabel2.textAlignment = NSTextAlignmentLeft;
//        cell.cLabel2.textColor = [UIColor blackColor];
//        cell.cLabel2.font = [UIFont systemFontOfSize:14];
//        [cell.cLabel2 addGestureRecognizer:singleRecognizer];
//        
//        
//        if (indexPath.row == 5) {
//            cell.cLabel2.frame = CGRectMake(92, 0, 200, cellHeight);
//        }
//        
//        float imageHeight = cellHeight - 2*7;
//        singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
//        singleRecognizer.numberOfTapsRequired = 1;
//        //cell.cImageView.frame = CGRectMake(tableView.frame.size.width - imageHeight- 10, 7, imageHeight+10, cell.frame.size.height);
//        cell.cImageView.frame = CGRectMake(tableView.frame.size.width - imageHeight- 15, -2, imageHeight+10, cell.frame.size.height);
//        [cell.cImageView addGestureRecognizer:singleRecognizer];
//       
//    }
//    
//    cell.cLabel1.text = [arrAllDicPhones[indexPath.row] allKeys][0];
//    cell.cLabel2.text = [arrAllDicPhones[indexPath.row] allValues][0];
//    cell.cLabel2.tag = STAG_PHONE + indexPath.row;
//    cell.cImageView.tag = STAG_MAIL + indexPath.row;
//    [cell.cImageView setBackgroundColor:[UIColor clearColor]];
//    [cell.cImageView setContentMode:UIViewContentModeCenter];
//    if (![cell.cLabel2.text isEqualToString:@""]&&([cell.cLabel1.text isEqualToString:@"工作手机"]||[cell.cLabel1.text isEqualToString:@"私人手机"]||[cell.cLabel1.text isEqualToString:@"手机虚拟网"])) {
//        cell.cImageView.userInteractionEnabled = YES;
//        cell.cImageView.image = [UIImage imageNamed:@"duanxin"];
//    }
////    if (![cell.cLabel2.text isEqualToString:@""] && (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 4)) {
////        cell.cImageView.userInteractionEnabled = YES;
////        cell.cImageView.image = [UIImage imageNamed:@"duanxin"];
////    }
//        else{
//        cell.cImageView.userInteractionEnabled = NO;
//        cell.cImageView.image = nil;
//    }
//    
//    return cell;
}
//
//-(void)singleTap:(UITapGestureRecognizer *)recognizer
//{
//    
//    UIView *v = recognizer.view;
//    v.transform = CGAffineTransformMakeScale(1, 1);
//    [UIView animateWithDuration:0.15 animations:^{
//        v.transform = CGAffineTransformMakeScale(1.2, 1.2);
//    }completion:^(BOOL finish){
//        [UIView animateWithDuration:0.12 animations:^{
//            v.transform = CGAffineTransformMakeScale(1, 1);
//        }];
//    }];
//    
//    if ([v isKindOfClass:[UILabel class]]) {
//       
//        int index = v.tag - STAG_PHONE;
//        NSString *tel;
//        if (![[arrAllDicPhones[index] allKeys][0] isEqualToString:@"E-mail"]){
//            DLog(@"STAG_PHONE:%d,%@",index,[_infoArray objectAtIndex:index]);
//            tel = [NSString stringWithFormat:@"telprompt://%@",[arrAllDicPhones[index] allValues][0]];
//        }else{
//            tel = [NSString stringWithFormat:@"mailto:%@",[arrAllDicPhones[index] allValues][0]];
//        }
//        DLog(@"index:%d   x:%@",index, tel);
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tel]];
//    }
//    if ([v isKindOfClass:[UIImageView class]]) {
//        int index = v.tag - STAG_MAIL;
//        DLog(@"STAG_sms:%d,%@",index,[_infoArray objectAtIndex:index]);
//        
//        MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
//        picker.messageComposeDelegate = self;
//        picker.navigationBar.tintColor = [UIColor colorWithRed:24.0/255.0 green:38.0/255.0 blue:37.0/255.0 alpha:1];        picker.recipients = [NSArray arrayWithObject:[arrAllDicPhones[index] allValues][0]];
//        if (vController) {
//            [vController presentModalViewController:picker animated:YES];
//           
//        }
//
//        //NSString *tel = [NSString stringWithFormat:@"sms:%@",[_infoArray objectAtIndex:index]];
//        //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:tel]];
//    }
//}



-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [vController dismissModalViewControllerAnimated:YES];
}

@end
