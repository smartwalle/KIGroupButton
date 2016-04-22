//
//  KICheckBox.h
//  KIGroupButton
//
//  Created by apple on 15/12/31.
//  Copyright (c) 2015年 SmartWalle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KIGroupButton.h"

@interface KICheckBox : KIGroupButton

- (void)deselectAllButtons;

- (NSArray *)selectedButtons;

- (void)setSelected:(BOOL)selected;

- (void)selectWithTag:(NSInteger)tag;

- (void)selectWithValue:(NSInteger)value;

@end
