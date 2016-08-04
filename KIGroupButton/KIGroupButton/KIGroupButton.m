//
//  KIGroupButton.m
//  KIGroupButton
//
//  Created by apple on 15/12/31.
//  Copyright (c) 2015年 SmartWalle. All rights reserved.
//

#import "KIGroupButton.h"
@implementation KIGroupButton

#pragma mark - Lifecycle
- (void)dealloc {
    [self removeButton:self];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addTocuhUpInsideEventHandler];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self addTocuhUpInsideEventHandler];
}

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    [self addTocuhUpInsideEventHandler];
    [super addTarget:target action:action forControlEvents:controlEvents];
}

#pragma mark - Event Response
- (void)onTouchUpInsideAction:(KIGroupButton *)sender {
}

#pragma mark - Methods
- (void)addTocuhUpInsideEventHandler {
    if (![[self allTargets] containsObject:self]) {
        [super addTarget:self
                  action:@selector(onTouchUpInsideAction:)
        forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)addButton:(KIGroupButton *)button {
    if (button == self) {
        return ;
    }
    if (_sharedButtons == nil) {
        _sharedButtons = [[NSMutableArray alloc] init];
    }
    
    // 2016.08.04 修正通过 addButton 方法添加 Button 不能处理自身状态的 Bug.
    if (![self containsButton:self inList:_sharedButtons]) {
        [_sharedButtons addObject:[NSValue valueWithNonretainedObject:self]];
    }
    
    if (![self containsButton:button inList:_sharedButtons]) {
        
        NSMutableArray *tempList = button->_sharedButtons;
        [button removeButton:button];
        [_sharedButtons addObject:[NSValue valueWithNonretainedObject:button]];
        button->_sharedButtons = _sharedButtons;
        
        for (NSValue *v in tempList) {
            KIGroupButton *btn = (KIGroupButton *)[v nonretainedObjectValue];
            if (btn != self && ![self containsButton:btn inList:_sharedButtons]) {
                [btn removeButton:btn];
                [_sharedButtons addObject:[NSValue valueWithNonretainedObject:btn]];
                btn->_sharedButtons = _sharedButtons;
            }
        }
       
    }
}

- (void)removeButton:(KIGroupButton *)button {
    for (NSValue *v in _sharedButtons) {
        if ([v nonretainedObjectValue] == button) {
            [_sharedButtons removeObject:v];
            button->_sharedButtons = nil;
            break;
        }
    }
}

- (BOOL)containsButton:(KIGroupButton *)button inList:(NSArray *)list {
    for (NSValue *v in list) {
        if ([v nonretainedObjectValue] == button) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - Getters & Setters
- (NSArray *)groupButtons {
    if ([_sharedButtons count]) {
        NSMutableArray *buttons = [[NSMutableArray alloc] initWithCapacity:_sharedButtons.count];
        for (NSValue *v in _sharedButtons) {
            [buttons addObject:[v nonretainedObjectValue]];
            
        }
        return buttons;
    }
    return nil;
}

- (void)setGroupButtons:(NSArray *)groupButtons {
    if (_sharedButtons == nil) {
        for (KIGroupButton *gb in groupButtons) {
            if (gb->_sharedButtons != nil) {
                _sharedButtons = gb->_sharedButtons;
                break;
            }
        }
        if (_sharedButtons == nil) {
            _sharedButtons = [[NSMutableArray alloc] initWithCapacity:[groupButtons count] + 1];
        }
    }
    
    if (![self containsButton:self inList:_sharedButtons]) {
        [_sharedButtons addObject:[NSValue valueWithNonretainedObject:self]];
    }
    
    for (KIGroupButton *gb in groupButtons) {
        if (gb->_sharedButtons != _sharedButtons) {
            if (gb->_sharedButtons == nil) {
                gb->_sharedButtons = _sharedButtons;
            } else {
                for (NSValue *v in gb->_sharedButtons) {
                    KIGroupButton *temp = [v nonretainedObjectValue];
                    if (![self containsButton:temp inList:_sharedButtons]) {
                        [_sharedButtons addObject:v];
                        temp->_sharedButtons = _sharedButtons;
                    }
                }
            }
        }
        
        if (![self containsButton:gb inList:_sharedButtons]) {
            [_sharedButtons addObject:[NSValue valueWithNonretainedObject:gb]];
        }
    }
}

@end
