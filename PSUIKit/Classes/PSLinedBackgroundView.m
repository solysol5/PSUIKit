//
//  UILinedBackgroundView.m
//  PSUIKit
//
//  Created by Steve Kim on 2013. 12. 31..
//  Copyright (c) 2013 Steve Kim. All rights reserved.
//

#import "PSLinedBackgroundView.h"
#import "PSUIKit.h"

@implementation PSLinedBackgroundView

// ================================================================================================
//  Overridden: UIView
// ================================================================================================

- (void)dealloc
{
    _seperatorColors = nil;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
        [self initProperties];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initProperties];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    UIColor *color1 = self.seperatorColors.count > 0 ? [self.seperatorColors objectAtIndex:0] : [UIColor clearColor];
    UIColor *color2 = self.seperatorColors.count > 1 ? [self.seperatorColors objectAtIndex:1] : color1;
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if ((self.lineDrawPosition & LineDrawPositionTop) == LineDrawPositionTop)
    {
        CGContextSetStrokeColorWithColor(context, color1.CGColor);
        CGContextSetLineWidth(context, self.lineHeight);
        CGContextMoveToPoint(context, self.linePadding.left, 0);
        CGContextAddLineToPoint(context, rect.size.width - self.linePadding.right, 0);
        CGContextStrokePath(context);
    }
    
    if ((self.lineDrawPosition & LineDrawPositionBottom) == LineDrawPositionBottom)
    {
        UIColor *color = self.lineDrawPosition == (LineDrawPositionBottom | LineDrawPositionTop) ? color2 : color1;
        CGContextSetStrokeColorWithColor(context, color.CGColor);
        CGContextSetLineWidth(context, self.lineHeight);
        CGContextMoveToPoint(context, self.linePadding.left, rect.size.height);
        CGContextAddLineToPoint(context, rect.size.width - self.linePadding.right, rect.size.height);
        CGContextStrokePath(context);
    }
}

- (void)setLineDrawPosition:(LineDrawPosition)lineDrawPosition
{
    if (lineDrawPosition == _lineDrawPosition)
        return;
    
    _lineDrawPosition = lineDrawPosition;
    
    [self setNeedsDisplay];
}

- (void)setLineHeight:(CGFloat)lineHeight
{
    if (_lineHeight == lineHeight)
        return;
    
    _lineHeight = lineHeight;
    
    [self setNeedsDisplay];
}

- (void)setLinePadding:(CGPadding)linePadding
{
    if (CGPaddingEquals(_linePadding, linePadding))
        return;
    
    _linePadding = linePadding;
    
    [self setNeedsDisplay];
}

// ================================================================================================
//  Internal
// ================================================================================================

- (void)initProperties
{
    self.clearsContextBeforeDrawing = YES;
    _lineHeight = 1.0f;
    _lineDrawPosition = LineDrawPositionBottom | LineDrawPositionTop;
    _linePadding = CGPaddingMakeHorizontal(0, 0);
    _seperatorColors = @[[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
}
@end
