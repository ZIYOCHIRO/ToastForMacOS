//
//  EMRToast.h
//  ToastForMac
//
//  Created by ruixinyi on 2019/12/12.
//  Copyright © 2019 ruixinyi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface EMRToast : NSView

+ (void)Show:(NSString *)text;
@end

NS_ASSUME_NONNULL_END
