//
//  Transform3dUse.h
//  TongXunLu
//
//  Created by Mac Mini on 13-7-26.
//  Copyright (c) 2013年 ShineMo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Transform3dUse : NSObject
+ (CATransform3D)skewedIdentitiyTransformWithZDistance:(CGFloat)zDistance;
@end
