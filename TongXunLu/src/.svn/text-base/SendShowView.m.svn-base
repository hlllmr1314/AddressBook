//
//  SendShowView.m
//  TongXunLu
//
//  Created by Mac Mini on 13-7-25.
//  Copyright (c) 2013年 ShineMo. All rights reserved.
//

#import "SendShowView.h"
#import "Person.h"
#import "SendWithDeptCell.h"
#import "SendShowTableView.h"
#import "Transform3dUse.h"
#import "ShowTitleView.h"
//#import "SendShowDeptViewController.h"

@implementation SendShowView
{
    SendShowTableView *_table;
    NSArray *arrPersons;
    NSArray *arrDeparts;
    float offset;
    BOOL decelerateSelf;
    ShowTitleView *titleView;
}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        titleView = [[ShowTitleView alloc]initWithFrame:CGRectMake(0, 0, 0, 50)];
        [self addSubview:titleView];
        
        _table = [[SendShowTableView alloc]init];
        _table.delegate = self;
        _table.dataSource = self;
        self.userInteractionEnabled = YES;
        [self addSubview:_table];
        
        
        
        
    }
    return self;
}


- (void)setFrame:(CGRect)frame
{
    super.frame = frame;
    titleView.frame = CGRectMake(0, 0, frame.size.width, 50+10);
    
    _table.frame = CGRectMake(0, 50, frame.size.width, frame.size.height-50+44);
    self.layer.cornerRadius = 10.0;
}

- (void)setDept:(Department *)dept
{
    _dept = dept;
    
    
    arrPersons = [[[_dept subPerson] allObjects] sortedArrayUsingComparator:^NSComparisonResult(id a, id b){
        return [((Person *)a).id compare:((Person *)b).id];
    }];
    arrDeparts  = [_dept arrDept];
    
    titleView.labelTitle.text = _dept.name;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrPersons count] + [arrDeparts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SendWithDeptCell *cell;
    
    if (indexPath.row<[arrPersons count]) {
        
        static NSString *CellIdentifier = @"CellSendAllPerson";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell){
            cell = [[SendWithDeptCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.typeSendCell = typeSendCellPerson;
            cell.typeSendCellWidth = typeSendCellWidthSub;
        }
        Person *person = (Person *)arrPersons[indexPath.row];
        cell.labelName.text = person.username;
        if (person.virtualCellPhone.length) {
            cell.labelPhone.text = person.virtualCellPhone;
        }else{
            cell.labelPhone.text = person.workCellPhone;
        }
        
        cell.labelJob.text = person.title;
        return cell;
    }
    
    if (indexPath.row - [arrPersons count] <[arrDeparts count]) {
        static NSString *CellIdentifier = @"CellSendAllDept";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell){
            cell = [[SendWithDeptCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.typeSendCell = typeSendCellDept;
            cell.typeSendCellWidth = typeSendCellWidthSub;
        }
        Department *department = (Department *)arrDeparts[indexPath.row - [arrPersons count]];
        cell.labelName.text = department.name;
        cell.labelJob.text = [NSString stringWithFormat:@"%d", [department.searchPersons count]];
        return cell;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // NSLog(@"contentOffset%f,offset%f",scrollView.contentOffset.y,offset);
    if (decelerateSelf) {
        return;
    }
    if (scrollView.contentOffset.y<0) {
        offset-=scrollView.contentOffset.y;
        if (offset>self.frame.size.height) {
            offset = self.frame.size.height;
        }
        self.layer.transform = CATransform3DMakeTranslation(0,offset,0);
        scrollView.contentOffset = CGPointMake(0, 0);
    }else if(offset>0){
       
        offset-=scrollView.contentOffset.y;
        if (offset<0) {
            offset = 0;
        }
        self.layer.transform = CATransform3DMakeTranslation(0,offset,0);
        scrollView.contentOffset = CGPointMake(0, 0);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    decelerateSelf = NO;
    if (offset>50) {
        [self.delegate removeOne:(UIViewController *)[self nextResponder]];
        //        [UIView animateWithDuration:0.5 animations:^{
        //            self.layer.transform = CATransform3DMakeTranslation(0,self.frame.size.height,0);
        //            _upperView.layer.transform = CATransform3DTranslate([Transform3dUse skewedIdentitiyTransformWithZDistance:1000], 0, 0, 0);
        //        } completion:^(BOOL finished) {
        //             [self removeFromSuperview];
        //            [((UIViewController *)[self nextResponder]) removeFromParentViewController];
        //        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            self.layer.transform = CATransform3DMakeTranslation(0,0,0);
        } completion:^(BOOL finished) {
            
        }];
    }
    
    
    offset = 0;

}



- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
//    decelerateSelf = decelerate;
    if(decelerate)return;
    if (offset>50) {
        [self.delegate removeOne:(UIViewController *)[self nextResponder]];
        //        [UIView animateWithDuration:0.5 animations:^{
        //            self.layer.transform = CATransform3DMakeTranslation(0,self.frame.size.height,0);
        //            _upperView.layer.transform = CATransform3DTranslate([Transform3dUse skewedIdentitiyTransformWithZDistance:1000], 0, 0, 0);
        //        } completion:^(BOOL finished) {
        //             [self removeFromSuperview];
        //            [((UIViewController *)[self nextResponder]) removeFromParentViewController];
        //        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            self.layer.transform = CATransform3DMakeTranslation(0,0,0);
        } completion:^(BOOL finished) {
            
        }];
    }
    
    
    offset = 0;
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    decelerateSelf = YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row<[arrPersons count]) {
        return;
    }
    
    if (indexPath.row - [arrPersons count] <[arrDeparts count]) {
        
        //sendShowViewConPro.dept = (Department *)arrDeparts[indexPath.row - [arrPersons count]];
        [self.delegate addOne:(Department *)arrDeparts[indexPath.row - [arrPersons count]]];
    }
}

@end





