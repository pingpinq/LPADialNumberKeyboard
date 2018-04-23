//
//  LPADialNumberKeyboard.h
//  LPADialNumberKeyboard
//
//  Created by 平果太郎 on 2018/4/23.
//

#import <UIKit/UIKit.h>

@class LPADialNumberKeyboard;

@protocol LPADialNumberKeyboardDelegate <NSObject>

@optional
- (void)dialNumberKeyboard:(LPADialNumberKeyboard *)dialNumberKeyboard didPressedAtButtonWithText:(NSString *)text;

@end

@interface LPADialNumberKeyboard : UIView

@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) CGFloat borderWidth;

@property (nonatomic, weak) id<LPADialNumberKeyboardDelegate> delegate;

@end
