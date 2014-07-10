//
//  WYPTextView.m
//  WYPTextView
//
//  Created by 怒赞Nuzan-2 on 7/10/14.
//  Copyright (c) 2014 WYP. All rights reserved.
//

#import "WYPTextView.h"

@implementation WYPTextView

@synthesize placeholderColor = _placeholderColor;

-(id)init
{
    if (self = [super init]) {
        [self addTextChangeObserver];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self addTextChangeObserver];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTextChangeObserver];
    }
    return self;
}

- (void)dealloc
{
    [self removeTextChangeObserver];
}

- (void)addTextChangeObserver
{
    self.placeholderColor = [UIColor grayColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:self];
}

- (void)removeTextChangeObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //placeholder
    if (([[self text] length] == 0) && ([[self placeholder] length] != 0))
    {
        
        CGContextSetFillColorWithColor(context, self.placeholderColor.CGColor);
        CGRect rect = CGRectInset(self.bounds, self.textContainerInset.left+5, self.textContainerInset.top);
        // iOS7 Version
        if ([self.placeholder respondsToSelector:@selector(drawInRect:withAttributes:)]) {
            NSLog(@"%@", self.font);
            UIFont *font = self.font;
            if (font == NULL) {
                font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
            }
            [self.placeholder drawInRect:rect withAttributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: self.placeholderColor}];
        }
        else {
            [self.placeholder drawInRect:rect withFont:self.font lineBreakMode:NSLineBreakByCharWrapping];
        }
    }
    
}

#pragma mark - Set Method

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textChanged:nil];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    
    [self textChanged:nil];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    [self textChanged:nil];
}

- (void)textChanged:(NSNotification *)notification
{
    if ([[self placeholder] length] != 0)
    {
        [self setNeedsDisplay];
    }
}

-(UIColor *)placeholderColor
{
    if (!_placeholderColor) {
        _placeholderColor = [UIColor grayColor];
    }
    return _placeholderColor;
}

@end
