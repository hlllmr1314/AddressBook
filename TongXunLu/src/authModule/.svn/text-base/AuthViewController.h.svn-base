//
//  AuthViewController.h
//  TongXunLu
//
//  Created by pan on 13-3-27.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterView.h"

@interface AuthViewController : UIViewController <RegisterViewDelegate>
{
    RegisterView *regv;
    NSMutableData *receivedData;
    
    UIImageView *coverImage;
    NSMutableDictionary *letterDict;
    
    UIProgressView *progressView;
    NSString *sqlInitInsert;
    int allCount;
    int insertIndex;
    int deptIndex;
}
-(void)displayAuthView;
-(void)getAllContacts:(NSString *)token;
@end
