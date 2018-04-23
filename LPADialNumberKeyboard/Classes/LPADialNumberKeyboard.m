//
//  LPADialNumberKeyboard.m
//  LPADialNumberKeyboard
//
//  Created by 平果太郎 on 2018/4/23.
//

#import "LPADialNumberKeyboard.h"
#import "LPADialNumberButton.h"

static NSString *const kLPADialKeyboardCollectionViewCellIdentifier = @"LPADialKeyBoardCollectionViewCellIdentifier";
static NSString *const kLPADialKeyboardTitleKey = @"title";
static NSString *const kLPADialKeyboardDetailTextKey = @"detail";
static NSString *const kLPADialKeyboardBorderTypeKey = @"borderType";

@interface LPADialKeyboardCell : UICollectionViewCell

@property (nonatomic, strong) LPADialNumberButton *numberButton;

@end

@implementation LPADialKeyboardCell

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.numberButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_numberButton setFrame:self.bounds];
}

#pragma mark - Custom Accessors

- (LPADialNumberButton *)numberButton {
    if (!_numberButton) {
        _numberButton = [[LPADialNumberButton alloc] initWithFrame:CGRectZero];
    }
    return _numberButton;
}

@end

@interface LPADialNumberKeyboard () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy) NSArray *collectionData;

@end

@implementation LPADialNumberKeyboard

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.collectionView];
        // Keyboard content
        _collectionData = @[@{kLPADialKeyboardTitleKey: @"1", kLPADialKeyboardDetailTextKey: @"", kLPADialKeyboardBorderTypeKey: @(LPADialNumberButtonBorderTypeRight | LPADialNumberButtonBorderTypeBottom)},
                            @{kLPADialKeyboardTitleKey: @"2", kLPADialKeyboardDetailTextKey: @"ABC", kLPADialKeyboardBorderTypeKey: @(LPADialNumberButtonBorderTypeBottom | LPADialNumberButtonBorderTypeRight)},
                            @{kLPADialKeyboardTitleKey: @"3", kLPADialKeyboardDetailTextKey: @"EDF", kLPADialKeyboardBorderTypeKey: @(LPADialNumberButtonBorderTypeBottom)},
                            @{kLPADialKeyboardTitleKey: @"4", kLPADialKeyboardDetailTextKey: @"GHI", kLPADialKeyboardBorderTypeKey: @(LPADialNumberButtonBorderTypeBottom | LPADialNumberButtonBorderTypeRight)},
                            @{kLPADialKeyboardTitleKey: @"5", kLPADialKeyboardDetailTextKey: @"JKL", kLPADialKeyboardBorderTypeKey: @(LPADialNumberButtonBorderTypeBottom | LPADialNumberButtonBorderTypeRight)},
                            @{kLPADialKeyboardTitleKey: @"6", kLPADialKeyboardDetailTextKey: @"MNO", kLPADialKeyboardBorderTypeKey: @(LPADialNumberButtonBorderTypeBottom)},
                            @{kLPADialKeyboardTitleKey: @"7", kLPADialKeyboardDetailTextKey: @"PQRS", kLPADialKeyboardBorderTypeKey: @(LPADialNumberButtonBorderTypeBottom | LPADialNumberButtonBorderTypeRight)},
                            @{kLPADialKeyboardTitleKey: @"8", kLPADialKeyboardDetailTextKey: @"TUV", kLPADialKeyboardBorderTypeKey: @(LPADialNumberButtonBorderTypeBottom | LPADialNumberButtonBorderTypeRight)},
                            @{kLPADialKeyboardTitleKey: @"9", kLPADialKeyboardDetailTextKey: @"WXYZ", kLPADialKeyboardBorderTypeKey: @(LPADialNumberButtonBorderTypeBottom)},
                            @{kLPADialKeyboardTitleKey: @"*", kLPADialKeyboardDetailTextKey: @"", kLPADialKeyboardBorderTypeKey: @(LPADialNumberButtonBorderTypeRight)},
                            @{kLPADialKeyboardTitleKey: @"0", kLPADialKeyboardDetailTextKey: @"", kLPADialKeyboardBorderTypeKey: @(LPADialNumberButtonBorderTypeRight)},
                            @{kLPADialKeyboardTitleKey: @"#", kLPADialKeyboardDetailTextKey: @""}];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_collectionView setFrame:self.bounds];
}

#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _collectionData.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    LPADialKeyboardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kLPADialKeyboardCollectionViewCellIdentifier
                                                                          forIndexPath:indexPath];
    NSDictionary *numberDictionary = _collectionData[indexPath.row];
    cell.numberButton.titleLabel.text = numberDictionary[kLPADialKeyboardTitleKey];
    cell.numberButton.detailTextLabel.text = numberDictionary[kLPADialKeyboardDetailTextKey];
    cell.numberButton.borderType = [numberDictionary[kLPADialKeyboardBorderTypeKey] integerValue];
    return cell;
}

#pragma mark - UICollectionView Delegate FlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = CGRectGetWidth(_collectionView.bounds) / 3;
    CGFloat heigth = width / 2;
    return CGSizeMake(width, heigth);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark - UICollectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(dialNumberKeyboard:didPressedAtButtonWithText:)]) {
        NSDictionary *numberDictionary = _collectionData[indexPath.row];
        [self.delegate dialNumberKeyboard:self didPressedAtButtonWithText:numberDictionary[kLPADialKeyboardTitleKey]];
    }
}

#pragma mark - Custom Accessors

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor lightGrayColor];
        // Register cells
        [_collectionView registerClass:[LPADialKeyboardCell class]
            forCellWithReuseIdentifier:kLPADialKeyboardCollectionViewCellIdentifier];
    }
    return _collectionView;
}

@end
