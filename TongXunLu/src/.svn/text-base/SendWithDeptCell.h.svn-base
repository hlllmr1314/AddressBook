//
//  SendWithDeptCell.h
//  TongXunLu
//
//  Created by Mac Mini on 13-7-25.
//  Copyright (c) 2013年 ShineMo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    typeSendCellPerson,
    typeSendCellDept,
    typeSendCellSel,
} typeSendCell;

typedef enum {
    typeSendCellWidthTop,
    typeSendCellWidthSub,
} typeSendCellWidth;

@protocol SendWithDeptCellDelegate <NSObject>

- (void)selBtnAct:(NSIndexPath *)indexPath;

@end

@interface SendWithDeptCell : UITableViewCell
@property(nonatomic,strong)UILabel *labelName;
@property(nonatomic,strong)UILabel *labelPhone;
@property(nonatomic,strong)UILabel *labelJob;
@property(nonatomic,strong)UIButton *butSel;
@property(nonatomic,assign)typeSendCell typeSendCell;
@property(nonatomic,assign)typeSendCellWidth typeSendCellWidth;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,strong)id<SendWithDeptCellDelegate> cellDelegate;
@end
