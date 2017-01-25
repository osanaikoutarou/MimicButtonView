//
//  MimicButtonView.m
//  MimicButtonViewProject
//
//  Created by osanai on 2017/01/25.
//  Copyright © 2017年 osanai. All rights reserved.
//

#import "MimicButtonView.h"

#define LIGHT_ALPHA 0.2
#define DARK_VIEW_ALPHA 0.5

//#define CUSTOM_BUTTON_VIEW_DEBUG YES

@implementation MimicButtonView {
    
    CGFloat defaultAlpha;
    
    // タッチ状態
    BOOL onTouch;
    
    // タッチしたpoint
    CGPoint touchDownPoint;
}

#pragma mark - 初期化

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
// 共通初期化
- (void)initialize {
    defaultAlpha = self.alpha;
    
    [self addTarget:self action:@selector(touchDown:withEvent:) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(touchUpInside) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(touchUpOutside) forControlEvents:UIControlEventTouchUpOutside];
    
    [self addTarget:self action:@selector(touchDragInside) forControlEvents:UIControlEventTouchDragInside];
    [self addTarget:self action:@selector(touchDragOutside) forControlEvents:UIControlEventTouchDragOutside];
    [self addTarget:self action:@selector(touchDragEnter) forControlEvents:UIControlEventTouchDragEnter];
    [self addTarget:self action:@selector(touchCancel) forControlEvents:UIControlEventTouchCancel];
    
    touchDownPoint = CGPointZero;
}

#pragma mark - interface

- (void)setupBackgroundImage {
    if (!self.backgroundImage ||
        [self.backgroundImage isEqualToString:@""] ||
        [UIImage imageNamed:self.backgroundImage]==nil) {
        return;
    }
    
    UIGraphicsBeginImageContext(self.frame.size);
    UIImage *image = [UIImage imageNamed:self.backgroundImage];
    [image drawInRect:self.bounds];
    UIImage *backgroundImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
}

- (BOOL)isView:(id)v {
    // UIViewであり、label、imageではないものすべて
    if (!v) {
        return NO;
    }
    if ([v isKindOfClass:[UILabel class]]) {
        return NO;
    }
    if ([v isKindOfClass:[UIImage class]]) {
        return NO;
    }
    
    if ([v isKindOfClass:[UIView class]]) {
        return YES;
    }
    
    return NO;
}

#pragma mark - ボタンに似せる Handling

- (void)touchDown:(UIControl *)control withEvent:(UIEvent *)event {
#ifdef CUSTOM_BUTTON_VIEW_DEBUG
    NSLog(@"MimicButtonView touchDown");
#endif
    UITouch *touch = [[event allTouches] anyObject];
    touchDownPoint = [touch locationInView:self];
    [self showTouchViewWithAnimation:NO];
}
- (void)touchUpInside {
#ifdef CUSTOM_BUTTON_VIEW_DEBUG
    NSLog(@"MimicButtonView touchUpInside");
#endif
    [self showUnTouchViewWithAnimation:YES];
}
- (void)touchUpOutside {
#ifdef CUSTOM_BUTTON_VIEW_DEBUG
    NSLog(@"MimicButtonView touchUpOutside");
#endif
    [self showUnTouchViewWithAnimation:YES];
}
- (void) touchDragInside {
#ifdef CUSTOM_BUTTON_VIEW_DEBUG
    NSLog(@"MimicButtonView touchDragInside");
#endif
}

- (void) touchDragOutside {
#ifdef CUSTOM_BUTTON_VIEW_DEBUG
    NSLog(@"MimicButtonView touchDragOutside");
#endif
    [self showUnTouchViewWithAnimation:YES];
}
- (void) touchDragEnter {
#ifdef CUSTOM_BUTTON_VIEW_DEBUG
    NSLog(@"MimicButtonView touchDragEnter");
#endif
    [self showTouchViewWithAnimation:YES];
}
- (void) touchDragExit {
#ifdef CUSTOM_BUTTON_VIEW_DEBUG
    NSLog(@"MimicButtonView touchDragExit");
#endif
    [self showUnTouchViewWithAnimation:YES];
}

- (void) touchCancel {
#ifdef CUSTOM_BUTTON_VIEW_DEBUG
    NSLog(@"touchCancel");
#endif
    [self showUnTouchViewWithAnimation:YES];
}

// 押された状態
- (void)showTouchViewWithAnimation:(BOOL)animation {
    if (onTouch) {
        return;
    }
    
    onTouch = YES;
    
    [UIView animateWithDuration:animation?0.2:0
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         // imageview
                         for (UIView *v in self.subviews) {
                             if ([v isKindOfClass:[UIImageView class]]) {
                                 v.alpha = LIGHT_ALPHA;
                             }
                         }
                         // label
                         for (UIView *v in self.subviews) {
                             if ([v isKindOfClass:[UILabel class]]) {
                                 v.alpha = LIGHT_ALPHA;
                             }
                         }
                         // other views
                         for (UIView *v in self.subviews) {
                             if ([self isView:v]) {
                                 v.alpha = LIGHT_ALPHA;
                             }
                         }

                     } completion:nil];
    
}

// 離された状態
- (void) showUnTouchViewWithAnimation:(BOOL)animation {
    
    if (!onTouch) {
        return;
    }
    
    onTouch = NO;
    
    [UIView animateWithDuration:animation?0.2:0
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{

                         // imageview
                         for (UIView *v in self.subviews) {
                             if ([v isKindOfClass:[UIImageView class]]) {
                                 //TODO:subviewsのalphaをこぞんする
                                 v.alpha = 1.0;
                             }
                         }
                         // label
                         for (UIView *v in self.subviews) {
                             if ([v isKindOfClass:[UILabel class]]) {
                                 //TODO:subviewsのalphaをこぞんする
                                 v.alpha = 1.0;
                             }
                         }
                         // other views
                         for (UIView *v in self.subviews) {
                             if ([self isView:v]) {
                                 //TODO:subviewsのalphaをこぞんする
                                 v.alpha = 1.0;
                             }
                         }
                     } completion:nil];
}

@end
