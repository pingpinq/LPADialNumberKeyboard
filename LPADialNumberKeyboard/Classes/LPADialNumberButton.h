//
//  LPADialNumberButton.h
//  LPADialNumberKeyboard
//
//  Created by 平果太郎 on 2018/4/23.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSInteger, LPADialNumberButtonBorderType) {
    LPADialNumberButtonBorderTypeTop = 1 << 1,
    LPADialNumberButtonBorderTypeLeft = 1 << 2,
    LPADialNumberButtonBorderTypeRight = 1 << 3,
    LPADialNumberButtonBorderTypeBottom = 1 << 4
};

@interface LPADialNumberButton : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailTextLabel;

@property (nonatomic, assign) LPADialNumberButtonBorderType borderType;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) CGFloat borderWidth;

@property (nonatomic, copy) void (^buttonHandlerBlock)(NSString *numberText);

@end
