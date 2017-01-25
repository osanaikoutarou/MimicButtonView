//
//  MimicButtonView.h
//  MimicButtonViewProject
//
//  Created by osanai on 2017/01/25.
//  Copyright © 2017年 osanai. All rights reserved.
//

#import <UIKit/UIKit.h>

// 目的:UIButtonのようなUIView

// 以下のものには対応していない
//   子Viewに、UIView、UILabel、UIImageView以外が乗る（全てUIViewとして対応）
//   子Viewにalphaがついている場合（孫Viewであれば問題なく動く）

// 以下の挙動に注意
// UIScrollView配下、MimicButtonViewの下にUIButton、GestureRecognizerとの干渉
// 対応方法については言及しない

// タッチした際にalphaではなく暗くしたい場合などは、このViewを継承して作成する

@interface MimicButtonView : UIControl

// 一応設定できるが、UIImageViewを配下に置いてもよいかも
@property (nonatomic) IBInspectable NSString *backgroundImage;

@end
