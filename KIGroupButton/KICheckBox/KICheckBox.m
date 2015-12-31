//
//  KICheckBox.m
//  KIGroupButton
//
//  Created by apple on 15/12/31.
//  Copyright (c) 2015年 SmartWalle. All rights reserved.
//

#import "KICheckBox.h"

@implementation KICheckBox

#pragma mark - Event Response
- (void)onTouchUpInsideAction:(KICheckBox *)sender {
    [self setSelected:!sender.selected sendControlEvent:YES];
}

#pragma mark - Methods
- (void)deselectAllButtons {
    for (NSValue *v in _sharedButtons) {
        KICheckBox *cb = [v nonretainedObjectValue];
        [cb setSelected:NO sendControlEvent:NO];
    }
}

- (NSArray *)selectedButtons {
    NSMutableArray *buttons = [[NSMutableArray alloc] init];
    for (NSValue *v in _sharedButtons) {
        KICheckBox *cb = [v nonretainedObjectValue];
        if ([cb isSelected]) {
            [buttons addObject:cb];
        }
    }
    return buttons;
}

- (void)setSelected:(BOOL)selected {
    [self setSelected:selected sendControlEvent:NO];
}

- (void)setSelectedWithTag:(NSInteger)tag {
    if (self.tag == tag) {
        [self setSelected:YES sendControlEvent:NO];
    } else {
        for (NSValue *v in _sharedButtons) {
            KICheckBox *cb = [v nonretainedObjectValue];
            if (cb.tag == tag) {
                [cb setSelected:YES sendControlEvent:NO];
                break;
            }
        }
    }
}

- (void)setSelected:(BOOL)selected sendControlEvent:(BOOL)sendControlEvent {
    BOOL valueChanged = (self.selected != selected);
    [super setSelected:selected];
    if (valueChanged && sendControlEvent) {
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

@end
