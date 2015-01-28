//
//  StyleKitMock.j
//
//  Created by Udo Schneider on 25/01/15.
//  Copyright (c) 2015 Krodelin Software Solutions. All rights reserved.

@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

CPFontAttributeName = @"CPFontAttributeName";
CPForegroundColorAttributeName = @"CPForegroundColorAttributeName";
CPParagraphStyleAttributeName = @"CPParagraphStyleAttributeName";
CPCompositeSourceOver = @"CPCompositeSourceOver";

CPZeroRect = CGRectMakeZero;

@implementation CPMutableParagraphStyle : CPObject
{
}

+ (id)defaultParagraphStyle
{
    return [[CPMutableParagraphStyle alloc] init];
}

- (void)set_alignment:(id)alignment
{

}

@end

@implementation CPString (StyleKitMocks)
{
}

- (void)drawInRect:(NSRect)aRect withAttributes:(CPDictionary)attributes
{
}

@end

@implementation CPBezierPath (StyleKitMocks)

- (void)setMiterLimit:(CGFloat)mitterLimit
{
}

@end

@implementation CPImage (StyleKitMocks)
{
}

- (void)drawInRect:(CGRect)dstRect
          fromRect:(CGRect)srcRect
         operation:(NSCompositingOperation)op
          fraction:(CGFloat)delta
{
    var ctx = [[CPGraphicsContext currentContext] graphicsPort];
    CGContextDrawImage(ctx, dstRect, self);
}

- (void)drawInRect:(CGRect)dstSpacePortionRect
          fromRect:(CGRect)srcSpacePortionRect
         operation:(NSCompositingOperation)op
          fraction:(CGFloat)requestedAlpha
    respectFlipped:(bool)respectContextIsFlipped
             hints:(CPDictionary)hints
{
    var ctx = [[CPGraphicsContext currentContext] graphicsPort];
    CGContextDrawImage(ctx, dstSpacePortionRect, self);
}

@end
