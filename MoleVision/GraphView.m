//
//  GraphView.m
//  MoleVision
//
//  Created by Ivy Dong on 13-07-29.
//  Copyright (c) 2013 Team Up. All rights reserved.
//

#import "GraphView.h"

@implementation GraphView

float data[] = {0.3, 0, 0, 0, 0, 0, 0};


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


    - (void)drawBar:(CGRect)rect context:(CGContextRef)ctx
    {
        // Prepare the resources
        CGFloat components[12] = {0.2314, 0.5686, 0.4, 1.0,  // Start color
            0.4727, 1.0, 0.8157, 1.0, // Second color
            0.2392, 0.5686, 0.4118, 1.0}; // End color
        CGFloat locations[7] = {0.0, 0.14, 0.28,0.42,0.56,0.70,0.90};
        size_t num_locations = 3;
        CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
        CGGradientRef gradient = CGGradientCreateWithColorComponents(colorspace, components, locations, num_locations);
        CGPoint startPoint = rect.origin;
        CGPoint endPoint = CGPointMake(rect.origin.x + rect.size.width, rect.origin.y);
        // Create and apply the clipping path
        CGContextBeginPath(ctx);
        CGContextSetGrayFillColor(ctx, 0, 100);
        CGContextMoveToPoint(ctx, CGRectGetMinX(rect), CGRectGetMinY(rect));
        CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMinY(rect));
        CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
        CGContextAddLineToPoint(ctx, CGRectGetMinX(rect), CGRectGetMaxY(rect));
        CGContextClosePath(ctx);
        CGContextSaveGState(ctx);
        CGContextClip(ctx);
        // Draw the gradient
        CGContextDrawLinearGradient(ctx, gradient, startPoint, endPoint, 0);
        CGContextRestoreGState(ctx);
        // Release the resources
        CGColorSpaceRelease(colorspace);
        CGGradientRelease(gradient);
    }




// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.6);
    CGContextSetStrokeColorWithColor(context, [[UIColor lightGrayColor] CGColor]);
    
    
    // How many lines?
    int howMany = (kDefaultGraphWidth - kOffsetX) / kStepX;
    // Here the lines go
    for (int i = 0; i < howMany; i++)
    {
        CGContextMoveToPoint(context, kOffsetX + i * kStepX, kGraphTop);
        CGContextAddLineToPoint(context, kOffsetX + i * kStepX, kGraphBottom);
    }
    
    int howManyHorizontal = (kGraphBottom - kGraphTop - kOffsetY) / kStepY;
    for (int i = 0; i <= howManyHorizontal; i++)
    {
        CGContextMoveToPoint(context, kOffsetX, kGraphBottom - kOffsetY - i * kStepY);
        CGContextAddLineToPoint(context, kDefaultGraphWidth, kGraphBottom - kOffsetY - i * kStepY);
    }
    
    CGContextStrokePath(context);
    
    // Draw the bars
    float maxBarHeight = kGraphHeight - kBarTop - kOffsetY;
    for (int i = 0; i < sizeof(data); i++)
    {
        float barX =kOffsetX + kStepX + i * kStepX - kBarWidth / 2;
        float barY = kBarTop + maxBarHeight - maxBarHeight * data[i];
        float barHeight = maxBarHeight * data[i];
        CGRect barRect = CGRectMake(barX, barY, kBarWidth, barHeight);
        [self drawBar:barRect context:context];

}
}

@end
