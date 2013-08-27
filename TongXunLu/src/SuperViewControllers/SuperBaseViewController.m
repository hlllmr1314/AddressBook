//
//  SuperBaseViewController.m
//  TongXunLu
//
//  Created by Pan on 13-4-3.
//  Copyright (c) 2013年 QuanMai. All rights reserved.
//

#import "SuperBaseViewController.h"
#import "SearchResultCell.h"
#import "UtilGetViews.h"
#import "SendAllViewController.h"
#import "Person.h"

@interface SuperBaseViewController ()

@end

@implementation SuperBaseViewController
{
    UIBarButtonItem *_leftBarBut;
    UIBarButtonItem *_leftBarButOld;
}
@synthesize db;
@synthesize tableView, scrollViewH, searchBar;
@synthesize unitsArray, mutipleChoosedMap;
@synthesize multipleChoosed, multipleChooseEnable;
@synthesize sendMsgArray;


- (id)init
{
    self = [super init];
    if (self) {
        NSString *dbPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"tongxunludb.db"];
        self.db = [[FMDatabase alloc] initWithPath:dbPath];
        if (![db open]) {
            NSLog(@"Could not open db.");
        }
        
        
        self.unitsArray = [[NSMutableArray alloc] initWithCapacity:100];
        self.sendMsgArray = [[NSMutableArray alloc]init];
        self.mutipleChoosedMap = [[NSMutableDictionary alloc]initWithCapacity:50];
        
        UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0, 64, 30)];
        [rightButton setImage:[UIImage imageNamed:@"btn_sendgroupmsg"] forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(sendMessageMutipleChoose:) forControlEvents:UIControlEventTouchUpInside];
        sendGroupMsg = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
       
        
        rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0, 64, 30)];
        [rightButton setImage:[UIImage imageNamed:@"wancheng"] forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(sendMessageMutipleChoose:) forControlEvents:UIControlEventTouchUpInside];
        sendGroupMsg_Finished = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
       
        
        self.navigationItem.rightBarButtonItem = nil;
        self.multipleChooseEnable = YES;
        
        
        
    }
    return self;
}

-(void)setGroupSendMSGBtnShow:(BOOL)show
{
    if (show ) {
        
        [self.mutipleChoosedMap removeAllObjects];
        self.multipleChoosed = NO;
        self.navigationItem.rightBarButtonItem = sendGroupMsg;
    }else
    {
        self.navigationItem.rightBarButtonItem = nil;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSIndexPath *selected = [self.tableView indexPathForSelectedRow];
    if(selected) [self.tableView deselectRowAtIndexPath:selected animated:YES];
    
    self.searchBar.text = @"";
    [self.searchBar resignFirstResponder];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.scrollViewH = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 46-46)];
    [self.view addSubview:scrollViewH];
   
    scrollViewH.scrollEnabled = NO;
    
    self.searchBar = [[CUISearchBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];
    searchBar.backgroundImage = [UIImage imageNamed:@"search-bg.png"];
	searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
	searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
	searchBar.keyboardType = UIKeyboardTypeNamePhonePad;
    searchBar.placeholder = @"手机/名字/座机";
    searchBar.delegate = self;
    
   
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, scrollViewH.frame.size.height - 44)];
    [tableView addSubview:searchBar];
    
    self.tableView.contentInset = UIEdgeInsetsMake(CGRectGetHeight(searchBar.bounds), 0, 0, 0);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(CGRectGetHeight(searchBar.bounds), 0, 0, 0);
    
    [scrollViewH addSubview:tableView];
    
	tableView.delegate = self;
    tableView.dataSource = self;
    
}

#pragma -----------------------------
#pragma - tableView delegate --------
#pragma -----------------------------

#pragma mark - Table view data source
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (scrollView.contentOffset.y < -CGRectGetHeight(searchBar.bounds)) {
        searchBar.layer.zPosition = 0; // Make sure the search bar is below the section index titles control when scrolling up
    } else {
        searchBar.layer.zPosition = 1; // Make sure the search bar is above the section headers when scrolling down
    }
    
    CGRect searchBarFrame = searchBar.frame;
    searchBarFrame.origin.y = MAX(scrollView.contentOffset.y, -CGRectGetHeight(searchBarFrame));
    
    searchBar.frame = searchBarFrame;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView
{
	return 1;
}

-(CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.multipleChooseEnable && self.multipleChoosed) {
        return self.sendMsgArray.count;
    }
    return self.unitsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCellStyle style =  UITableViewCellStyleDefault;
    UITableViewCell *cell = nil;
    
    if (self.multipleChooseEnable && self.multipleChoosed) {
        //多选状态
        cell = [aTableView dequeueReusableCellWithIdentifier:@"sendMSGCell"];
        if (!cell) {
            cell = [[SearchResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sendMSGCell"];
        }
        ((SearchResultCell *)cell).multipleBtn.hidden = NO;
        ((SearchResultCell *)cell).headImage.hidden = YES;
        
        NSArray *currentArray = self.sendMsgArray;
        NSDictionary *currentObj = [[currentArray objectAtIndex:indexPath.row] objectForKey:@"obj"];
        NSString *key = [[currentArray objectAtIndex:indexPath.row] objectForKey:@"kname"];
        
        ((SearchResultCell *)cell).nameL.text = [currentObj objectForKey:@"name"];
        ((SearchResultCell *)cell).titleL.text = [currentObj objectForKey:@"title"];
        ((SearchResultCell *)cell).numberL.text = [currentObj objectForKey:key];
        ((SearchResultCell *)cell).index = indexPath.row;
        
        UIButton *button = ((SearchResultCell *)cell).multipleBtn;
        if (button.imageView.image == nil) {
            [button setImage:[UIImage imageNamed:@"mutiple_unchoosed.png"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"mutiple_choosed.png"] forState:UIControlStateSelected];
            button.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 275);
            
            [button addTarget:self action:@selector(mutipleChoose:) forControlEvents:UIControlEventTouchUpInside];
        }
        ((SearchResultCell *)cell).multipleBtn.selected = [self.mutipleChoosedMap objectForKey:[NSNumber numberWithInt:indexPath.row]] != nil;
        
    }else
    {
        cell = [aTableView dequeueReusableCellWithIdentifier:@"BaseCell"];
        
        if (!cell){
            cell = [[CustomCell alloc] initWithStyle:style reuseIdentifier:@"BaseCell"];
        }
        ((CustomCell *)cell).cImageView.hidden = NO;
        ((CustomCell *)cell).multipleBtn.hidden = YES;
        
        NSArray *currentArray = self.unitsArray;
        NSDictionary *currentObj = [currentArray objectAtIndex:indexPath.row];
        
        ((CustomCell *)cell).cLabel1.text = [currentObj objectForKey:@"name"];
        ((CustomCell *)cell).cLabel2.text = [currentObj objectForKey:@"title"];
        ((CustomCell *)cell).cImageView.image = [UIImage imageNamed:@"touxiang.png"];
        ((CustomCell *)cell).index = indexPath.row;
        //((CustomCell *)cell).multipleBtn.selected = [self.mutipleChoosedMap objectForKey:[NSNumber numberWithInt:indexPath.row]] != nil;
        
    }
    return cell;
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma - nonatomic property
-(void)setMultipleChoosed:(BOOL)choosed
{
    if (self.multipleChooseEnable) {
        if (multipleChoosed != choosed) {
            multipleChoosed = choosed;
            [self.tableView reloadData];
        }
    }
}

-(void)mutipleChoose:(UIButton *)button
{
    button.selected = !button.selected;
    int index = ((SearchResultCell *)button.superview.superview).index;
    
    if (button.selected) {
        [self.mutipleChoosedMap setObject:@"" forKey:[NSNumber numberWithInt:index]];
    }else
    {
        [self.mutipleChoosedMap removeObjectForKey:[NSNumber numberWithInt:index]];
    }
}

-(void)sendMessageMutipleChoose:(id)sender
{
    UINavigationController *navPro = (UINavigationController *)[[UtilGetViews sharedGetViews] viewConFromId:@"nacSendAll"];
//    ((SendAllViewController *)navPro.childViewControllers[0]).arrAllPersons = [Person objectArrayByPredicate:nil sortDescriptors:nil];
    //((SendAllViewController *)navPro.childViewControllers[0]).arrParam = self.sendMsgArray;
    [self presentModalViewController:navPro animated:YES];
    return;
    self.multipleChoosed = !self.multipleChoosed;
    
    if (!self.multipleChoosed) {
        
        if (self.mutipleChoosedMap.allKeys.count >0) {
            NSMutableArray *smsRecipients = [[NSMutableArray alloc]initWithCapacity:5];
            
            for (NSNumber *index in self.mutipleChoosedMap.allKeys) {
                NSDictionary *currentObj = [[self.sendMsgArray objectAtIndex:[index intValue]] objectForKey:@"obj"];
                NSString *key = [[self.sendMsgArray objectAtIndex:[index intValue]] objectForKey:@"kname"];
                [smsRecipients addObject:[currentObj objectForKey:key]];
                
                //NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:[rs resultDictionary],@"obj",@"fullspell",@"kname", nil];
                
            }
            DLog(@"smsRecipients:%@",smsRecipients);
            
            MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
            picker.messageComposeDelegate = self;
            picker.navigationBar.tintColor = [UIColor colorWithRed:24.0/255.0 green:38.0/255.0 blue:37.0/255.0 alpha:1];
            picker.recipients = smsRecipients;
            [self presentModalViewController:picker animated:YES];
        
        }
        [self.mutipleChoosedMap removeAllObjects];
        self.navigationItem.rightBarButtonItem = sendGroupMsg;
        
        self.navigationItem.leftBarButtonItem = _leftBarButOld;

       
    }else
    {
        _leftBarButOld = self.navigationItem.leftBarButtonItem;
        
        if (!_leftBarBut) {
            UIButton *leftBarButPro = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];

            [leftBarButPro setBackgroundImage:[UIImage imageNamed:@"seleAll"] forState:UIControlStateNormal];
            [leftBarButPro setBackgroundImage:[UIImage imageNamed:@"seleAll"] forState:UIControlStateHighlighted];
            leftBarButPro.selected = YES;
            [leftBarButPro addTarget:self action:@selector(memSelectAll:) forControlEvents:UIControlEventTouchUpInside];
            _leftBarBut = [[UIBarButtonItem alloc]initWithCustomView:leftBarButPro];
           
        }
        self.navigationItem.leftBarButtonItem = _leftBarBut;
        self.navigationItem.rightBarButtonItem = sendGroupMsg_Finished;
    }
}

- (void)memSelectAll:(id)sender
{
    UIButton *but = (UIButton *)sender;
    if (but.selected) {
        but.selected = NO;
        [but setBackgroundImage:[UIImage imageNamed:@"diseleAll"] forState:UIControlStateNormal];
        [but setBackgroundImage:[UIImage imageNamed:@"diseleAll"] forState:UIControlStateHighlighted];
        for (int i=0; i<[self.sendMsgArray count]; i++) {
            [self.mutipleChoosedMap setObject:@"" forKey:[NSNumber numberWithInt:i]];
        }
    }else{
        but.selected = YES;
        [but setBackgroundImage:[UIImage imageNamed:@"seleAll"] forState:UIControlStateNormal];
        [but setBackgroundImage:[UIImage imageNamed:@"seleAll"] forState:UIControlStateHighlighted];
        [self.mutipleChoosedMap removeAllObjects];
    }
    [self.tableView reloadData];
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissModalViewControllerAnimated:NO];
    //[controller dismissModalViewControllerAnimated:NO];
}

@end
