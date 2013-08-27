//
//  Search2ViewController.h
//  TongXunLu
//
//  Created by Mac Mini on 13-5-13.
//  Copyright (c) 2013年 ShineMo. All rights reserved.
//

#import "CustomViewController.h"
#import "KeyboardView.h"

@interface Search2ViewController : CustomViewController<KeyboardViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic ,strong)NSArray *unitsArray;
@end
