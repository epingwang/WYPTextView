//
//  WYPTextView.m
//  WYPTextView
//
//  Created by WYP on 7/10/14.
//  Copyright (c) 2014 WYP. All rights reserved.
//

#import "WYPTextView.h"

@implementation WYPTextView

@synthesize placeholderColor = _placeholderColor;

-(id)init
{
    if ([self respondsToSelector:@selector(initWithFrame:textContainer:)]) {
        NSTextStorage* textStorage = [[NSTextStorage alloc] init];
        NSLayoutManager* layoutManager = [NSLayoutManager new];
        [textStorage addLayoutManager:layoutManager];
        NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        [layoutManager addTextContainer:textContainer];
        textContainer.widthTracksTextView = YES;
        textContainer.heightTracksTextView = YES;
        if (self = [super initWithFrame:CGRectZero textContainer:textContainer]) {
            [self addTextChangeObserver];
        }
    }
    else {
        if (self = [super init]) {
            [self addTextChangeObserver];
        }
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
    if ([self respondsToSelector:@selector(initWithFrame:textContainer:)]) {
        NSTextStorage* textStorage = [[NSTextStorage alloc] init];
        NSLayoutManager* layoutManager = [NSLayoutManager new];
        [textStorage addLayoutManager:layoutManager];
        NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake(frame.size.width, frame.size.height)];
        [layoutManager addTextContainer:textContainer];
        if (self = [super initWithFrame:frame textContainer:textContainer]) {
            [self addTextChangeObserver];
        }
    }
    else {
        if (self = [super initWithFrame:frame]) {
            [self addTextChangeObserver];
        }
    }
    
    return self;
}

- (void)dealloc
{
    [self removeTextChangeObserver];
}

- (void)addTextChangeObserver
{
    self.editable = YES;
    if (!self.placeholderColor) {
        self.placeholderColor = [UIColor colorWithRed:0 green:0 blue:0.0980392 alpha:0.22];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:self];
}

- (void)removeTextChangeObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self drawRect:self.frame];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (!context) {
        return;
    }
    
    //placeholder
    if (([[self text] length] == 0) && ([[self placeholder] length] != 0))
    {
        
        CGContextSetFillColorWithColor(context, self.placeholderColor.CGColor);
        CGRect rect = CGRectInset(self.bounds, self.textContainerInset.left+5, self.textContainerInset.top - 1);
        // iOS7 Version
        if ([self.placeholder respondsToSelector:@selector(drawInRect:withAttributes:)]) {
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
//    [self setNeedsDisplay];
//    if (self.contentSize.height > self.contentOffset.y) {
//        [self setContentOffset:CGPointMake(0, self.contentSize.height) animated:YES];
//    }
}

-(UIColor *)placeholderColor
{
    if (!_placeholderColor) {
        _placeholderColor = [UIColor grayColor];
    }
    return _placeholderColor;
}

@end
