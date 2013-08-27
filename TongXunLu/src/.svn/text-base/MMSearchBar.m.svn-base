//
//  MMSearchBar.m
//  TongXunLu
//
//  Created by Mac Mini on 13-7-18.
//  Copyright (c) 2013年 ShineMo. All rights reserved.
//

#import "MMSearchBar.h"
#import "KeyBoardJustNum.h"

@implementation MMSearchBar
{
     UITextView *searchField;
    UIButton *btn;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
       // [self setTranslucent:YES];
    }
    return self;
}



- (void)layoutSubviews {
    
    [super layoutSubviews];
    return;
    
    if(self.keyboard==nil)
    {
        
        self.keyboard =[[KeyBoardJustNum alloc]init];
//        self.keyboard.frame = CGRectMake(0, 0, 320, 100);
    }
    
    
   
    NSUInteger numViews = [self.subviews count];
    for(int i = 0; i < numViews; i++) {
        if([[self.subviews objectAtIndex:i] isKindOfClass:[UITextField class]]) {
            if (!searchField) {
                 searchField = [self.subviews objectAtIndex:i];
            }
            if (!btn) {
                btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(80, 0, 100, 30);
                [btn setTitle:@"changeKeyType" forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                btn.backgroundColor = [UIColor whiteColor];
                [btn addTarget:self action:@selector(changeKeyBoard) forControlEvents:UIControlEventTouchUpInside];
                searchField.inputAccessoryView = btn;
            }
//           
//           
//            if (_searchKeyboardtype == SearchKeyboardtypeDefault) {
//                
//                [searchField setInputView:nil];
//                
//                continue;
//            }
//            [searchField setInputView:self.keyboard];
//            continue;
        }
    }
    
    [super layoutSubviews];
    
}

- (void)changeKeyBoard
{
    if (_searchKeyboardtype == SearchKeyboardtypeDefault) {
        _searchKeyboardtype = SearchKeyboardtypeMyView;
        searchField.inputView = self.keyboard;
    }else{
        _searchKeyboardtype = SearchKeyboardtypeDefault;
        [searchField setInputView:nil];
    }
    [searchField resignFirstResponder];
   // [self layoutSubviews];
    [searchField becomeFirstResponder];
}

- (void)setSearchKeyboardtype:(SearchKeyboardtype)searchKeyboardtype
{
    _searchKeyboardtype = searchKeyboardtype;
//    
//    UITextField *txfSearchField = [self valueForKey:@"_searchField"];   
//    UITextField *textField = [[UITextField alloc]initWithFrame:txfSearchField.frame];
//     [txfSearchField removeFromSuperview];
//    [textField setBackgroundColor:[UIColor whiteColor]];
//    //[textField setLeftView:UITextFieldViewModeNever];
//    [textField setBorderStyle:UITextBorderStyleRoundedRect];
//    textField.layer.borderWidth = 0.0f;
//    textField.layer.cornerRadius = 10.0f;
//    if (searchKeyboardtype == SearchKeyboardtypeMyView) {
//        textField.inputView = [KeyboardView sharedKeyBoard];
//    }
//    
//    [self setValue:textField forKey:@"_searchField"];
//    [self addSubview:textField];
//    [textField becomeFirstResponder];
}

@end
