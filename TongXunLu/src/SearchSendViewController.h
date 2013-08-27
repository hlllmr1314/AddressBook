//
//  SearchSendViewController.h
//  TongXunLu
//
//  Created by Mac Mini on 13-5-30.
//  Copyright (c) 2013年 ShineMo. All rights reserved.
//

#import "Super2ViewController.h"
#import "Search2PersonViewController.h"
@interface SearchSendViewController : Search2PersonViewController
@property (nonatomic,strong)NSMutableArray *arrSelect;
@property (nonatomic,strong)void(^submit)(NSMutableArray *arrSelect);
@end
