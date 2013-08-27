#import <MessageUI/MessageUI.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "NSNull+ConvertoString.h"
#import "CustomCell.h"
//#import "FMDatabase.h"
//#import "FMDatabaseAdditions.h"
#import "QAlertView.h"
#import "UIAlertViewBlock.h"
#import "AFNetworking.h"
#import "CustomViewController.h"


#define UI_SCREEN_WIDTH                 ([[UIScreen mainScreen] bounds].size.width)
#define UI_SCREEN_HEIGHT                ([[UIScreen mainScreen] bounds].size.height)

//#define SERVER_ADD @"http://vps2.dev.shinemo.com:8080/contacts/api/"
#define SERVER_ADD @"https://s1.txl.release.shinemo.net:8089/contacts/api/"

//#define TESTTOKEN @"MTo1MjcwMjBhZTJmYmQ0ZjBmNTFiOTk1NmMxZmM2ZTZiMmFmYzQ3MjNmOjEzNjQ0MDA2ODI5ODM="
//#define TESTTOKEN @"MjMxODU6OThlMWU4MDIwOTdiODg0MjVmNDY4NjNlMzQ2MTljY2M1MDRiODY5OToxMzY5MTk5ODE4NjY0OjE1MjU3MTAzODky"//@"MzgwMTo1MzUyODk4MWNmNGRkZmQ3YzNkMzM0ZDMwMTg1MDU2ZTU3MmNlY2YzOjEzNjU0OTE1ODA0MDg="
#define IOS6 [[[UIDevice currentDevice] systemVersion] compare:@"6.0" options:NSNumericSearch] != NSOrderedAscending
 

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define IS_IPHONE_5 ([UIScreen mainScreen].bounds.size.height == 568.0)
#define _AFNETWORKING_ALLOW_INVALID_SSL_CERTIFICATES_ 1;

//isEscape
#define iosStr @"IOS"