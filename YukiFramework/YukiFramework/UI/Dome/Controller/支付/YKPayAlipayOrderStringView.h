//
//  YKPayAlipayOrderStringView.h
//  YukiFramework
//
//  Created by 王宇 on 2019/3/14.
//  Copyright © 2019 wy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YKPayAlipayOrderStringView : UIView
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, copy) void (^payAliPayBlock)(void);
@end

NS_ASSUME_NONNULL_END
