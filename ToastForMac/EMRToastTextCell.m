//
//  EMRToastTextCell.m
//  ToastForMac
//
//  Created by ruixinyi on 2019/12/12.
//  Copyright © 2019 ruixinyi. All rights reserved.
//

#import "EMRToastTextCell.h"

@implementation EMRToastTextCell

// make text content centered vertically
- (NSRect)drawingRectForBounds:(NSRect)rect {
    NSRect newRect = [super drawingRectForBounds:rect];
    NSSize textSize = [self cellSizeForBounds:rect];
    CGFloat deltaHight = newRect.size.height - textSize.height;
    if (deltaHight > 0) {
        newRect.size.height = textSize.height;
        newRect.origin.y += deltaHight * 0.5;
        
    }
    return newRect;
}
@end
