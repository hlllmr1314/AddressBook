//
//  SearchResultCell.m
//  TongXunLu
//
//  Created by pan on 13-3-22.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import "SearchResultCell.h"

@implementation SearchResultCell
@synthesize multipleBtn, index;
@synthesize headImage;

@synthesize nameL, spellL, numberL, titleL;

-(ColorbleLabel *)sytled:(ColorbleLabel *)label
{
    label.backgroundColor = [UIColor clearColor];
    label.textColor = UIColorFromRGB(0x949494);
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentLeft;
    
    return label;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        headImage = [[UIImageView alloc]initWithFrame:CGRectMake(11, 9, 36, 36)];
        headImage.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:headImage];
               
        nameL = [[ColorbleLabel alloc]initWithFrame:CGRectMake(58, 10, 100, 14)];
        spellL = [[ColorbleLabel alloc]initWithFrame:CGRectMake(157, 10, 151, 14)];
        titleL = [[ColorbleLabel alloc]initWithFrame:CGRectMake(157, 30, 151, 14)];
        numberL = [[ColorbleLabel alloc]initWithFrame:CGRectMake(58, 30, 100, 14)];

        [self sytled:nameL];
        [self sytled:spellL];
        [self sytled:titleL];
        [self sytled:numberL];
        
        nameL.textColor = [UIColor blackColor];
        spellL.textAlignment = NSTextAlignmentRight;
        titleL.textAlignment = NSTextAlignmentRight;
        
        [self.contentView addSubview:nameL];
        [self.contentView addSubview:spellL];
        [self.contentView addSubview:titleL];
        [self.contentView addSubview:numberL];
        
       

        multipleBtn = [[UIButton alloc]initWithFrame:self.contentView.bounds];
        multipleBtn.hidden = YES;
        [self.contentView addSubview:multipleBtn];
       
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    headImage.frame = CGRectMake(11, 9, 36, 36);
    nameL.frame = CGRectMake(58, 10, 100, 16);
    spellL.frame = CGRectMake(157, 10, 151, 16);
    titleL.frame = CGRectMake(157, 30, 151, 16);
    numberL.frame = CGRectMake(58, 30, 100, 16);
    multipleBtn.frame = self.contentView.bounds;
}

-(void)refreshSearchResultCellWithDict:(NSDictionary *)dict keyword:(NSString *)keyword regex:(NSString *)regex
{
    //DLog(@"RRkeyword:%@",keyword);
    //DLog(@"SearchResultCellDict:%@",dict);
    headImage.image = [UIImage imageNamed:@"touxiang.png"];
    nameL.text = [dict objectForKey:@"name"];
    titleL.text = [dict objectForKey:@"departname"];
    spellL.text = [dict objectForKey:@"fullspell"];
    
    if ([dict objectForKey:@"matchnumber"] != nil) {
        NSPredicate * pred  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[a-z]+"];
        if ([pred evaluateWithObject:[dict objectForKey:@"matchnumber"]]){
            numberL.text = [dict objectForKey:[dict objectForKey:@"matchnumber"]];
            [numberL ColorRegex:regex withColor:UIColorFromRGB(0xff7800)];
        }else{
            numberL.text = [dict objectForKey:@"matchnumber"];
        }
        
    }else if ([keyword isEqualToString:@"workcell"] || [keyword isEqualToString:@"privatecell"]  ||[keyword isEqualToString:@"workphone"]  ||[keyword isEqualToString:@"homephone"]  || [keyword isEqualToString:@"shortphone"]  ) {
        numberL.text = [dict objectForKey:keyword];
    }else
    {
        numberL.text = [dict objectForKey:@"workcell"];
    }

    if (![regex isEqualToString:@""] && ![regex isEqual:[NSNull null]]) {
        if ([dict objectForKey:@"matchnumber"] == nil) {
            [numberL ColorRegex:regex withColor:UIColorFromRGB(0xff7800)];
        }else if ([[dict objectForKey:@"matchnumber"] hasPrefix:@"A"]){
            numberL.text =[[dict objectForKey:@"matchnumber"] substringFromIndex:1];
           [numberL ColorRegex:regex withColor:UIColorFromRGB(0xff7800)];

        }
        
        //尝试染色名字label
        NSPredicate * pred  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",[NSString stringWithFormat:@".*%@.*",regex]];
        NSString *shortspell = [dict objectForKey:@"shortspell"];
        if ([pred evaluateWithObject:shortspell]){
            NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionCaseInsensitive error:nil];
            NSRange regexRange =[expression rangeOfFirstMatchInString:shortspell options:NSMatchingCompleted range:NSMakeRange(0, shortspell.length)];
            [spellL ColorRegex:regex byKeyword:[shortspell substringWithRange:regexRange] withColor:UIColorFromRGB(0xff7800)];

        }
        else
        {
            [spellL ColorRegex:regex withColor:UIColorFromRGB(0xff7800)];
        }
    }
}

//-(NSString *)getMathNumber:(NSDictionary *)dict  regex:(NSString *)regex
//{
//    NSPredicate * pred  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",[NSString stringWithFormat:@".*%@.*",regex]];
//
//    NSArray *keys = [NSArray arrayWithObjects:@"workcell",@"privatecell",@"workphone",@"homephone",@"shortphone", nil];
//    for (NSString *keyname in keys) {
//        NSString *nowvalue = [dict objectForKey:keyname];
//        if ([pred evaluateWithObject:nowvalue]) {
//            return nowvalue;
//        }
//    }
//    return [dict objectForKey:@"workcell"];
//}

@end
