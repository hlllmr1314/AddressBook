//
//  ShowTitleView.m
//  TongXunLu
//
//  Created by Mac Mini on 13-7-26.
//  Copyright (c) 2013年 ShineMo. All rights reserved.
//

#import "ShowTitleView.h"

@implementation ShowTitleView
{
    //UIControl *control;
    CGPoint gestureStartPoint;
    int oneTime;
    CGPoint centerSuper;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        _labelTitle.backgroundColor = [UIColor clearColor];
        _labelTitle.textAlignment = UITextAlignmentCenter;
        _labelTitle.font = [UIFont systemFontOfSize:13.0];
        _labelTitle.numberOfLines = 2;
        [self addSubview:_labelTitle];
        self.backgroundColor = [UIColor grayColor];
        self.layer.cornerRadius = 10.0;
        
//        control = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
//        [control addTarget:self action:@selector(drag:withEvent:) forControlEvents:UIControlEventTouchDragInside];
//        
//        [self addSubview:control];
        
        _btnClose = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_btnClose setTitle:@"关闭" forState:UIControlStateNormal];
        _btnClose.frame = CGRectMake(10, 10, 50, 26);
        _btnClose.titleLabel.font = [UIFont systemFontOfSize:13.0];
        [self addSubview:_btnClose];
        
        _btnReturn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_btnReturn setTitle:@"主界面" forState:UIControlStateNormal];
        _btnReturn.titleLabel.font = [UIFont systemFontOfSize:13.0];
        [self addSubview:_btnReturn];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    super.frame = frame;
    _labelTitle.frame = CGRectMake(frame.size.width/2-80, 10, 160, 30);
    _btnReturn.frame = CGRectMake(frame.size.width-10-50, 10, 50, 26);
   // control.frame = frame;
}



//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    
//    UITouch *touch = [touches anyObject];
//    
//    gestureStartPoint = [touch locationInView:self.superview];//开始触摸
//    oneTime = 0;
//    centerSuper = self.superview.center;
//     NSLog(@"gestureStartPointY%f",gestureStartPoint.y);
//}
//
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    
//    
//    
//    
//        UITouch *touch = [touches anyObject];
//       // CGPoint currentPosition0 = [touch previousLocationInView:self.superview];
//        CGPoint currentPosition = [touch locationInView:self.superview];
//        
//        CGFloat deltaX = gestureStartPoint.x - currentPosition.x;
//        NSLog(@"deltaX%f",deltaX);
//        CGFloat deltaY = gestureStartPoint.y - currentPosition.y;
//        NSLog(@"deltaY%f",deltaY);
//       
//        //self.superview.center = CGPointMake(centerSuper.x - deltaX, centerSuper.y - deltaY);
//        self.superview.layer.transform = CATransform3DMakeTranslation(0,-deltaY,0);
//    
//   
//}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
