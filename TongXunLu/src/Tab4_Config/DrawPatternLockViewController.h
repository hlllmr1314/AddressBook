//
//  ViewController.h
//  AndroidLock
//
//  Created by Purnama Santo on 11/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomViewController.h"
typedef enum {
    typeLockSet,
    typeLockReSet,
    typeLockGo,
} typeLock;

@interface DrawPatternLockViewController : UIViewController {
  NSMutableArray* _paths;
  
  // after pattern is drawn, call this:
  id _target;
  SEL _action;
}

// get key from the pattern drawn
- (NSString*)getKey;

- (void)setTarget:(id)target withAction:(SEL)action;


@property(nonatomic,assign)typeLock typeLock;
@property(nonatomic,strong) void(^setFinish)(BOOL finish);
@end
