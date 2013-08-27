//
//  LableColor.h
//  TongXunLu
//
//  Created by Mac Mini on 13-5-20.
//  Copyright (c) 2013年 ShineMo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    alignmentRight,
    alignmentLeft,
}alignment;
@interface LableColor : UILabel

@property(nonatomic,strong)NSArray *matchPos;
- (void)setText:(NSString *)text matchPos:(NSArray *)matchPos;
@property(nonatomic,assign)alignment alignment;
@end
