//
//  BookShelf.m
//  General Engine
//
//  Created by QuanMai on 11-12-7.
//  Copyright 2011年 QuanMai Tech. All rights reserved.
//

#import "PreferenceList.h"


#define DEST_PATH	[NSHomeDirectory() stringByAppendingString:@"/Documents/"]
#define NEWSLIST_PATH @"extra/app_index.php"

extern AppDelegate *del;

@implementation PreferenceList
@synthesize tableView;
@synthesize updateList;
@synthesize HostDefault;
@synthesize jsonDic;
@synthesize savePath;
@synthesize updateItem;
@synthesize overlay;
@synthesize progressView;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        updateList = [[NSMutableArray alloc] init];
        updateCount = 0;
        currentDidSelectedIndex = 0;
        bDownloading = 0;
        pageNumber = 1;
        _reloading = NO;

        // self set
        
        tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.frame.size.height-20.0f) style:UITableViewStyleGrouped];
        
    
        self.tableView.delegate = self;
        self.tableView.dataSource = self;

        /*
         UIImageView *iv = [[UIImageView alloc] initWithImage:[ImageHelper imageNamed:@"update_bg.png"]];
         iv.frame = CGRectMake(0.0f, 0.0f, 1024.0f, 768.0f);
         
         [self addSubview:iv];
         [iv release];
         */
         [self addSubview:tableView];
         
         
        /*
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.frame.size.width, self.tableView.bounds.size.height)];
		view.delegate = self;
		[self.tableView addSubview:view];
		_refreshHeaderView = view;
		[view release];        
        */
        
        
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
        
        HostDefault = [defaults stringForKey:@"hostKey"]; 
        

    }
    return self;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //return @"Test Header";
    if(section == 0){
        return @"系统设置";
    }else if (section == 1){
        return @"联系我们";
    }else if (section == 2){
        return @"关于我们";
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView 
{ 
	return 3; 
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section 
{
	if (section == 0) return 1;
	else if (section == 1) return 1;
    else if (section == 2) return 2;
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	StandardTableViewCell *cell = nil;
	
	if (indexPath.section == 0)
	{
		cell = [tView dequeueReusableCellWithIdentifier:@"SwitchCell"];
		if (!cell)
			cell = [[[NSBundle mainBundle] loadNibNamed:@"switchcell" owner:self options:nil] lastObject];
        if(indexPath.row == 0){
            [(UILabel *)[cell viewWithTag:101] setText:@"昵称设置"];
            //(UITextField *)[cell viewWithTag:102] set
            UITextField *tempField = (UITextField *)[cell viewWithTag:102];
            [tempField setDelegate:self];
            tempField.returnKeyType = UIReturnKeyDone;
            tempField.clearsOnBeginEditing = YES;
            tempField.placeholder = @"输入昵称";
            tempField.tag = 21;
        }else if (indexPath.row == 1){
            [(UILabel *)[cell viewWithTag:101] setText:@"文字大小"];
            UITextField *tempField = (UITextField *)[cell viewWithTag:102];
            [tempField setDelegate:self];
            tempField.returnKeyType = UIReturnKeyDone;
            tempField.clearsOnBeginEditing = YES;
            tempField.placeholder = @"文字大小";
            tempField.tag = 22;
        }
		
	} 
    else if (indexPath.section == 1)
    {
        if(indexPath.row == 0){
           	cell = (StandardTableViewCell *)[tView dequeueReusableCellWithIdentifier:@"BaseCell"];
            /*
            cell = [tView dequeueReusableCellWithIdentifier:@"SwitchCell"];
            if (!cell)
                cell = [[[NSBundle mainBundle] loadNibNamed:@"switchcell" owner:self options:nil] lastObject];
            */
            
            if (!cell){ 
                
                cell = [[[StandardTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"BaseCell"] autorelease];
                //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.editingAccessoryType = UITableViewCellAccessoryNone;
            }
            cell.titleLabel.text = @"意见反馈";
            
        }
    }
	else if (indexPath.section == 2)
	{
		if (indexPath.row == 0)
		{
			cell = [tView dequeueReusableCellWithIdentifier:@"LibertyCell"];
			if (!cell)
				cell = [[[NSBundle mainBundle] loadNibNamed:@"libertycell" owner:self options:nil] lastObject];
		}
		else if (indexPath.row == 1)
		{
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SubtitleCell"] autorelease];
			cell.textLabel.text = @"";
			cell.detailTextLabel.text = @"股票百晓生 All rights reserved.";
		}
	}
	
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 0) return 80.0f;
    else if (indexPath.section == 1) return  60.0f;
	else if (indexPath.section == 2)
	{
		if (indexPath.row == 0) return 340.0f;
		if (indexPath.row == 1) return 40.0f;
	}
    
	return 0.0f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    currentDidSelectedIndex = indexPath.row;
    /*
    if (indexPath.row != updateList.count ){
        [[self.superview nextResponder] didSelectRow:[((UpdateObject *)[updateList objectAtIndex:indexPath.row]).identity intValue]];
    }else{
        [self pageMore];
    }
     */
    if (indexPath.section == 1 && indexPath.row == 0){ 
        if ([self.viewDelegate respondsToSelector:@selector(basicPageView:didSelection:)]){
            [self.viewDelegate basicPageView:self didSelection:0];
            
        }
    }
}


-(void)updateItemAction:(UIButton *) button
{
    NSLog(@"update item");
    [self actionProgress];
    
    int updateIndex = button.tag - 40;
    
    //NSLog(@"did %@",((UpdateObject *)[updateList objectAtIndex:indexPath.row]).title);
    NSString *url = ((UpdateObject *)[updateList objectAtIndex:updateIndex]).url;
    NSString *requestStr = [NSString stringWithFormat:@"http://%@/app_getUpdate.php?%@",HostDefault,url];
    NSString *returnData = [self requestToServer:nil par:requestStr];
    
    //[FileManager writePathFile:@"updateDict" content:@"ddd"];
    
    
    //遍历内存中的数组，重新整合更新管理文件
    NSString *dataStrLocal = [FileManager readFileInBothPath:@"imageDict" type:@"txt"];
    NSDictionary *dictLocal = [[dataStrLocal JSONValue] objectForKey:@"contents"];
    
    NSString *dictStr = @"{\"contents\":[";
    
    for(id key in dictLocal){
        dictStr = [dictStr stringByAppendingFormat:@"{\"title\":\"%@\",\"id\":\"%@\",\"url\":\"%@\",\"preview\":\"%@\"},",[key objectForKey:@"title"],[key objectForKey:@"id"],
                   [key objectForKey:@"url"],[key objectForKey:@"preview"]];
    }
    
    
    dictStr = [dictStr stringByAppendingFormat:@"{\"title\":\"%@\",\"id\":\"%@\",\"url\":\"%@\",\"preview\":\"%@\"}",((UpdateObject *)[updateList objectAtIndex:updateIndex]).title,((UpdateObject *)[updateList objectAtIndex:updateIndex]).identity,
               ((UpdateObject *)[updateList objectAtIndex:updateIndex]).url,((UpdateObject *)[updateList objectAtIndex:updateIndex]).preview];
    
    dictStr = [dictStr stringByAppendingString:@"]}"];  
    
    [FileManager writeFileInPath:@"imageDict.txt" content:dictStr];
    
    
    
    //下载需要更新的文件
    NSDictionary *updateDict = [returnData JSONValue];
    [self action:updateDict];
    
    
    
    //将更新过后的item 状态设为1
    ((UpdateObject *)[updateList objectAtIndex:updateIndex]).bUpdated = 1;
    [tableView reloadData];
}

-(void)pageInit
{

}

-(void)pageRefresh
{
    //在这里初始化链接，查询是否有更新的内容
    //考虑是在这里查询还是放到框架顶层
    NSString *requestStr = [NSString stringWithFormat:@"http://%@/%@?type=get&product=meiguiyuan&udid=%@",HostDefault,NEWSLIST_PATH,@"1"];
    NSString *returnData = [self requestToServer:nil par:requestStr];
    
    [updateList removeAllObjects];
    //updateList = [[NSMutableArray alloc] init];
    if(![returnData isEqualToString:@"null"]){
        
        [self initUpdateList:returnData];
        
        
        [self doneLoadingTableViewData];
        
    }

}
-(void)pageMore
         {
             pageNumber ++;
             //在这里初始化链接，查询是否有更新的内容
             //考虑是在这里查询还是放到框架顶层
             NSString *requestStr = [NSString stringWithFormat:@"http://%@/%@?type=get&p=%d",HostDefault,NEWSLIST_PATH,pageNumber];
             NSString *returnData = [self requestToServer:nil par:requestStr];
             
             //[updateList removeAllObjects];
             //updateList = [[NSMutableArray alloc] init];
             if(![returnData isEqualToString:@"null"]){
                 
                 [self initUpdateList:returnData];
                 
                 
                 [self doneLoadingTableViewData];
                 
             }
             
         }


-(void)initUpdateList:(NSString *) listStr
{
    //jsonDic = [listStr JSONValue];
    
    NSDictionary *dict = [listStr JSONValue];
    self.jsonDic = dict;
    //[dict release];
    
    NSArray *contents = [jsonDic objectForKey:@"contents"];
    NSLog(@"contents count %d",[contents count]);
    
    //获取更新列表，然后比对本地文件，判断哪些需要更新
    NSMutableArray *tempLocal = [[NSMutableArray alloc] init];
    //读取图片，尝试从文件中获得路径
    NSString *dataStrLocal = [FileManager readFileInBothPath:@"imageDict" type:@"txt"];
    NSDictionary *dictLocal = [[dataStrLocal JSONValue] objectForKey:@"contents"];
    
    
    for (id key in dictLocal)
    {
        [tempLocal addObject:[key objectForKey:@"id"]];
    }
    
    NSLog(@"tempLocal length is %d",[tempLocal count]);
    
    NSMutableArray *tempUpdateList = [[NSMutableArray alloc] init];
    
    for(int i=0;i<[contents count];i++){
        UpdateObject *temObj = [[UpdateObject alloc] init];
        temObj.url = [[contents objectAtIndex:i] objectForKey:@"url"];
        temObj.title = [[contents objectAtIndex:i] objectForKey:@"title"];
        temObj.preview = [[contents objectAtIndex:i] objectForKey:@"preview"];
        temObj.identity = [[contents objectAtIndex:i] objectForKey:@"id"];
        temObj.lastDate = [[contents objectAtIndex:i] objectForKey:@"date"];
        temObj.hit = [[contents objectAtIndex:i] objectForKey:@"hit"];
        [tempUpdateList addObject:temObj];
        [temObj release];
    }
    
        int compareCount = [tempUpdateList count];
        int i= 0;
        int bRemoved = 0;
        while ([tempUpdateList count]>0 && compareCount > 0){
            bRemoved = 0;
            NSLog(@"updateList value %@ count %d",((UpdateObject *)[tempUpdateList objectAtIndex:i]).identity,[tempUpdateList count]);
            //NSLog(@"update object title %@",((UpdateObject *)[tempUpdateList objectAtIndex:i]).title);
            for (int j=0;j<[tempLocal count];j++){
                if([((UpdateObject *)[tempUpdateList objectAtIndex:i]).identity isEqualToString:[tempLocal objectAtIndex:j]]){
                     
                    [updateList addObject:[tempUpdateList objectAtIndex:i]];
                    ((UpdateObject *)[tempUpdateList objectAtIndex:i]).bUpdated = 1;
                    NSLog(@"%@ count i %d",[tempLocal objectAtIndex:j],i);
                    bRemoved = 1;
                    [tempUpdateList removeObjectAtIndex:i];
                    break;
                }
            }
            if(bRemoved == 0)
                i++;
            compareCount --;
        }
 

    [tempLocal release];
    
    //将更新过的和没更新过的进行重新排序
    for(i=0;i<[tempUpdateList count];i++){
        if(((UpdateObject *)[tempUpdateList objectAtIndex:i]).bUpdated == 0){
            [updateList addObject:[tempUpdateList objectAtIndex:i]];
        }
    }
    
    [tempUpdateList release];
    
    if([updateList count] == 0){
        [self showErrorMsg:@"已是最新版本"];
    }
    
    //因为引入了EGORefreshHeader,所以这里不调用reloadData
    //[tableView reloadData];
    
}
- (NSString *)requestToServer:(NSString *)modalID par:(NSString *)req
{	
	NSString * reqTemp;
	if ( req == nil ) 
	{
		reqTemp = [NSString stringWithFormat:@"GWModalID=%@",modalID];
	}
	else
	{
		reqTemp = [NSString stringWithFormat:@"GWModalID=%@%@",modalID,req];
	}
	NSLog(@"requestToServer->reqTemp: %@",reqTemp);
	
	NSString * reqLen = [NSString stringWithFormat:@"%d",[reqTemp length]];
    NSString * requestStr;
    requestStr = req;
    //requestStr = [NSString stringWithFormat:@"http://%@/updateList.php?type=get&product=meiguiyuan&udid=%@",@"222.73.186.131",@"1"];
	//NSString * requestStr = [NSString stringWithFormat:@"http://%@/PrintMenu?type=1",HostDefault];
	NSLog(@"connectServer->requestStr: %@",requestStr);
	NSURL * REQUESTURL = [NSURL URLWithString:requestStr];
	
	
	//[NSURLRequest allowsAnyHTTPSCertificateForHost:[REQUESTURL host]];
	//[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[REQUESTURL host]];
	
	NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
	[request setURL:REQUESTURL];
	[request setHTTPMethod:@"POST"];
	
	////set headers	
	[request addValue:@"application/x-www-form-urlencode" forHTTPHeaderField:@"Content-Type"];
	[request addValue:@"Mozilla/4.0" forHTTPHeaderField:@"User-Agent"];
	[request setValue:reqLen forHTTPHeaderField:@"Content-Length"];
	
    /*
     NSMutableData * postBody = [NSMutableData data];
     NSData * reqData = [reqTemp dataUsingEncoding:NSUTF8StringEncoding];
     [postBody appendData:reqData];
     [reqData release];
     [request setHTTPBody:postBody];
     */
    
	//get response
	NSURLResponse * response = nil;
	NSHTTPURLResponse * httpResponse = nil;  
	NSError * error = nil;  
	NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	[request release];
	
	httpResponse = (NSHTTPURLResponse *)response;
	NSInteger statusCode = [httpResponse statusCode];
    
	if(statusCode == !200)
	{
		
        [self performSelectorOnMainThread:@selector(showErrorMsg:) withObject:@"网络暂无连接." waitUntilDone:YES];
      
		return @"null";
	}

	NSString * jsonStr = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    //NSString * jsonStr = [[NSString alloc] initWithData:responseData];
	NSLog(@"requestToServer->jsonStr: %@",jsonStr);
  

    
	//nrOfRequest.code = 1;
    //nrOfRequest.text = jsonStr;
    
	return [jsonStr autorelease];
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if ([touch tapCount] == 2) 
	{
        if(bDownloading == 0)
            [[[self superview] nextResponder] backToMainMenu];
        else
            [self showErrorMsg:@"资料更新中，请等更新完毕后再退出"];
	}

    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{


}


- (void) dataDownloadAtPercent: (NSNumber *) aPercent
{
	//[progress setHidden:NO];
	//[progress setProgress:[aPercent floatValue]];
    //NSLog(@"progress %f",[aPercent floatValue]);
    
    //amountDone += [aPercent floatValue];
    //NSLog(@"progress %f",amountDone / updateCount);
    
    [progressView setProgress: ( (amountDone + [aPercent floatValue]) / updateCount)];
    
}

- (void) dataDownloadFailed: (NSString *) reason
{
	//[self restoreGUI];
	//if (reason) [self doLog:@"Download failed: %@", reason];
    if(reason) NSLog(@"Download failed: %@", reason);
}

- (void) didReceiveFilename: (NSString *) aName
{
    
	self.savePath = [DEST_PATH stringByAppendingString:aName];
    NSLog(@"didReceiveFilename %@",self.savePath );
}
-(void)didBatchDownloadStartup: (NSData *) theData
{
    //sleep(10);
    //[DownloadHelper sharedInstance].isDownloading = NO;
    for(int i=0;i<[updateItem count];i++){
        NSString *urlString =[NSString stringWithFormat:@"http://%@%@",HostDefault,[updateItem objectAtIndex:i]];
        NSLog(@"url is %@",urlString);
        // Prepare for download
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        
        // Set up the Download Helper and start download
        [DownloadHelper sharedInstance].delegate = self;
        [DownloadHelper download:urlString];
        [updateItem removeObjectAtIndex:0];
        amountDone ++;
        break;
    }
    
    if([updateItem count] == 0)
        [self performSelector:@selector(closeOverlay) withObject:nil afterDelay:0.5 ];
}
- (void) didReceiveData: (NSData *) theData
{
	if (![theData writeToFile:self.savePath atomically:YES])
        NSLog(@"Error writing data to file");

    
	[theData release];
	//[self restoreGUI];
	//[self doLog:@"Download succeeded"];
    NSLog(@"Download succeeded");
    

    
}

- (void) action: (NSDictionary *) dataDict
{
	//self.log = [NSMutableString string];
	//[self doLog:@"Starting Download..."];
	
	// Retrieve the URL string
	//int which = [(UISegmentedControl *)self.navigationItem.titleView selectedSegmentIndex];
	//NSArray *urlArray = [NSArray arrayWithObjects: SMALL_URL, BIG_URL, FAKE_URL, nil];
    
    updateCount = [[dataDict objectForKey:@"count"] intValue];
    
    NSArray *tempArr = [[NSArray alloc] initWithArray:[[dataDict objectForKey:@"items"] componentsSeparatedByString:@","]];
    if(updateItem != nil)
        [updateItem release];
    NSMutableArray *tempMArr = [[NSMutableArray alloc] init];
    self.updateItem = tempMArr;
    [tempMArr release], tempMArr = nil;
    for(int i=0;i<[tempArr count];i++){
        [updateItem addObject:[tempArr objectAtIndex:i]];
    }
    //self.updateItem = [[NSArray alloc] initWithArray:[dataStr componentsSeparatedByString:@","]];
    [tempArr release];
    
    for(int i=0;i<[updateItem count];i++){
	NSString *urlString =[NSString stringWithFormat:@"http://%@%@",HostDefault,[updateItem objectAtIndex:i]];
    
	// Prepare for download
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
	// Set up the Download Helper and start download
	[DownloadHelper sharedInstance].delegate = self;
	[DownloadHelper download:urlString];
        [updateItem removeObjectAtIndex:0];
        break;
    }
}

// This callback fakes progress via setProgress:
- (void) incrementBar: (id) timer
{
    amountDone += 1.0f;
    [progressView setProgress: (amountDone / loadingTime)];
	if (amountDone > loadingTime) 
	{
        if(overlay) [overlay removeFromSuperview];
		[timer invalidate];
        
        
        
	}
}

-(void) startActionProgressByTime:(float)timeint{
    loadingTime = timeint;
    [self actionProgress];
}
-(void)closeOverlay
{
    updateCount = 0;
    amountDone = 0;
    bDownloading = 0;
    
    if(overlay) [overlay removeFromSuperview];
}
// Load the progress bar onto an actionsheet backing
-(void) actionProgress
{
    NSLog(@"action progress");
	amountDone = 0.0f;
    loadingTime = 33.0;
    bDownloading = 1;
    
    
	progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0.0f, 40.0f, self.frame.size.width/2, 90.0f)];
    [progressView setProgressViewStyle: UIProgressViewStyleDefault];
    
    //创建一个蒙板
    overlay = [[UIView alloc ] initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height)];
    [overlay setBackgroundColor:[UIColor clearColor]];
    overlay.userInteractionEnabled = YES;
    //创建透明蒙板
    UIView *overlayBg = [[UIView alloc] init ];
    overlayBg.frame = overlay.frame;
    [overlayBg setBackgroundColor:[UIColor blackColor]];
    overlayBg.alpha = 0.5;  
    [overlay addSubview:overlayBg];
    [overlayBg release];
    
    //创建文字区域
    UILabel *progressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width/2 + 80, 80.0f)];
    progressLabel.textAlignment = UITextAlignmentCenter;
    progressLabel.textColor = [UIColor whiteColor];
    progressLabel.backgroundColor=[UIColor clearColor];
    progressLabel.font=[UIFont fontWithName:@"Arial" size:(20.0)];
    progressLabel.text = @"资料更新中，请稍候 :-)";
    progressLabel.center = CGPointMake(overlay.center.x, overlay.center.y);	
    [overlay addSubview:progressLabel];
    [progressLabel release];
    
    [overlay addSubview:progressView];
    //[actionSheet addSubview:progressView];
    [progressView release];
	
    
	
    // Create the demonstration updates
    [progressView setProgress:(amountDone = 0.0f)];
	//[NSTimer scheduledTimerWithTimeInterval: 0.35 target: self selector:@selector(incrementBar:) userInfo: nil repeats: YES];
	
    progressView.center = CGPointMake(overlay.center.x, overlay.center.y-20);	
    [self addSubview:overlay];
}



#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
    NSLog(@"start to reload data?????");
	_reloading = YES;
    //[self pageRefresh];
    [self performSelector:@selector(pageRefresh) withObject:nil afterDelay:1.0];
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    [tableView reloadData];
    NSLog(@"doneLoadingTableViewData");
	
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
    if(_reloading == NO){
        [self reloadTableViewDataSource];
    }
	//[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	//NSLog(@" reloading is %b",_reloading);
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if(textField.tag == 21){
        NSLog(@"textFieldShouldReturn %@",textField.text);
        NSString *newValue = [NSString stringWithFormat:@"%@",textField.text];
        [del setUserNickName:newValue];
        //del.nickName = textField.text;
         NSLog(@"set nick name %@,%@",del.nickName,[del getUserNickName]);
        
        
    }
    [textField resignFirstResponder];
    return YES;
}

-(void)showErrorMsg:(NSString *)e
{
    //	[[del.screenObj activityIndicator] stopAnimating];
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示:" message:e delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
}
- (void)dealloc
{
    if(updateList != nil)
        [updateList release];
    if(updateItem != nil)
        [updateItem release];
    if(tableView != nil)
        [tableView removeFromSuperview];
    
    [HostDefault release];
    
    if(jsonDict != nil)
        [jsonDict release];
    
    if(updateItem != nil)
        [updateItem release];
    
    [progressView release];
    [overlay release];
    
    [super dealloc];
    
}

@end
