//
//  LPADialNumberButton.m
//  LPADialNumberKeyboard
//
//  Created by 平果太郎 on 2018/4/23.
//

#import "LPADialNumberButton.h"

@interface LPADialNumberButton ()

@property (nonatomic, strong) UIButton *contentButton;

@property (nonatomic, strong) UIView *topLineView;
@property (nonatomic, strong) UIView *leftLineView;
@property (nonatomic, strong) UIView *rightLineView;
@property (nonatomic, strong) UIView *bottomLineView;

@end

@implementation LPADialNumberButton

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.titleLabel];
        [self addSubview:self.detailTextLabel];
        [self addSubview:self.contentButton];
        // Border lines
        [self addSubview:self.topLineView];
        [self addSubview:self.leftLineView];
        [self addSubview:self.rightLineView];
        [self addSubview:self.bottomLineView];
        _borderWidth = 0.5f;
        self.borderColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_titleLabel sizeToFit];
    [_detailTextLabel sizeToFit];
    [_titleLabel setFrame:CGRectMake(0, (CGRectGetHeight(self.bounds) - CGRectGetHeight(_titleLabel.frame)) / 2,
                                     CGRectGetWidth(self.bounds), CGRectGetHeight(_titleLabel.frame))];
    [_detailTextLabel setFrame:CGRectMake(0, CGRectGetMaxY(_titleLabel.frame),
                                          CGRectGetWidth(self.bounds), CGRectGetHeight(_detailTextLabel.frame))];
    // Boarder lines
    if (_borderType & LPADialNumberButtonBorderTypeTop) {
        _topLineView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), _borderWidth);
    }else {
        _topLineView.frame = CGRectZero;
    }
    if (_borderType & LPADialNumberButtonBorderTypeLeft) {
        _leftLineView.frame = CGRectMake(0, 0, _borderWidth, CGRectGetHeight(self.bounds));
    }else {
        _leftLineView.frame = CGRectZero;
    }
    if (_borderType & LPADialNumberButtonBorderTypeRight) {
        _rightLineView.frame = CGRectMake(CGRectGetWidth(self.bounds) - _borderWidth, 0, _borderWidth, CGRectGetHeight(self.bounds));
    }else {
        _rightLineView.frame = CGRectZero;
    }
    if (_borderType & LPADialNumberButtonBorderTypeBottom) {
        _bottomLineView.frame = CGRectMake(0, CGRectGetHeight(self.bounds) - _borderWidth, CGRectGetWidth(self.bounds), _borderWidth);
    }else {
        _bottomLineView.frame = CGRectZero;
    }
}

#pragma mark - Event Response

- (void)contentButtonHandler:(UIButton *)button {
    if (self.buttonHandlerBlock) {
        self.buttonHandlerBlock(_titleLabel.text);
    }
}

#pragma mark - Custom Accessors

- (UIButton *)contentButton {
    if (!_contentButton) {
        _contentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_contentButton addTarget:self action:@selector(contentButtonHandler:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _contentButton;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *)detailTextLabel {
    if (!_detailTextLabel) {
        _detailTextLabel = [[UILabel alloc] init];
        _detailTextLabel.textColor = [UIColor grayColor];
        _detailTextLabel.font = [UIFont systemFontOfSize:12];
        _detailTextLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _detailTextLabel;
}

- (UIView *)topLineView {
    if (!_topLineView) {
        _topLineView = [[UIView alloc] init];
    }
    return _topLineView;
}

- (UIView *)leftLineView {
    if (!_leftLineView) {
        _leftLineView = [[UIView alloc] init];
    }
    return _leftLineView;
}

- (UIView *)rightLineView {
    if (!_rightLineView) {
        _rightLineView = [[UIView alloc] init];
    }
    return _rightLineView;
}

- (UIView *)bottomLineView {
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] init];
    }
    return _bottomLineView;
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    _topLineView.backgroundColor = _borderColor;
    _leftLineView.backgroundColor = _borderColor;
    _rightLineView.backgroundColor = _borderColor;
    _bottomLineView.backgroundColor = _borderColor;
}

@end
