//
//  Transform3dUse.m
//  TongXunLu
//
//  Created by Mac Mini on 13-7-26.
//  Copyright (c) 2013年 ShineMo. All rights reserved.
//

#import "Transform3dUse.h"

@implementation Transform3dUse
+ (CATransform3D)skewedIdentitiyTransformWithZDistance:(CGFloat)zDistance
{
    CATransform3D skewedIdentityTransform = CATransform3DIdentity;
    skewedIdentityTransform.m34 = 1.0f / -zDistance;
    
    return skewedIdentityTransform;
}
@end
