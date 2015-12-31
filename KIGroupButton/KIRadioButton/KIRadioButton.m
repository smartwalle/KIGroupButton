//
//  KIRadioButton.m
//  KIGroupButton
//
//  Created by apple on 15/12/31.
//  Copyright (c) 2015年 SmartWalle. All rights reserved.
//

#import "KIRadioButton.h"

@implementation KIRadioButton

#pragma mark - Event Response
- (void)onTouchUpInsideAction:(KIRadioButton *)sender {
    [self setSelected:YES distinct:YES sendControlEvent:YES];
}

#pragma mark - Methods
- (void)deselectAllButtons {
    for (NSValue *v in _sharedButtons) {
        KIRadioButton *rb = [v nonretainedObjectValue];
        [rb setSelected:NO sendControlEvent:NO];
    }
}

- (KIRadioButton *)selectedButton {
    if ([self isSelected]) {
        return self;
    } else {
        for (NSValue *v in _sharedButtons) {
            KIRadioButton *rb = [v nonretainedObjectValue];
            if ([rb isSelected]) {
                return rb;
            }
        }
    }
    return nil;
}

- (void)setSelected:(BOOL)selected {
    [self setSelected:selected distinct:YES sendControlEvent:NO];
}

- (void)setSelectedWithTag:(NSInteger)tag {
    if (self.tag == tag) {
        [self setSelected:YES distinct:YES sendControlEvent:NO];
    } else {
        for (NSValue *v in _sharedButtons) {
            KIRadioButton *rb = [v nonretainedObjectValue];
            if (rb.tag == tag) {
                [rb setSelected:YES distinct:YES sendControlEvent:NO];
                break;
            }
        }
    }
}

- (void)setSelected:(BOOL)selected distinct:(BOOL)distinct sendControlEvent:(BOOL)sendControlEvent {
    [self setSelected:selected sendControlEvent:sendControlEvent];
    if (distinct && (selected || [_sharedButtons count] == 2)) {
        selected = !selected;
        for (NSValue *v in self->_sharedButtons) {
            KIRadioButton *rb = [v nonretainedObjectValue];
            if (rb != self) {
                [rb setSelected:selected sendControlEvent:sendControlEvent];
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
