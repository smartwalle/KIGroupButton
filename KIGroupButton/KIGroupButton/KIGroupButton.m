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
    for (NSValue *v in _sharedButtons) {
        if ([v nonretainedObjectValue] == self) {
            [_sharedButtons removeObjectIdenticalTo:v];
            break;
        }
    }
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
        for (KIGroupButton *rb in groupButtons) {
            if (rb->_sharedButtons != nil) {
                _sharedButtons = rb->_sharedButtons;
                break;
            }
        }
        if (_sharedButtons == nil) {
            _sharedButtons = [[NSMutableArray alloc] initWithCapacity:[groupButtons count] + 1];
        }
    }
    
    BOOL (^buttonExistInList)(NSArray *, KIGroupButton *) = ^(NSArray *list, KIGroupButton *rb) {
        for (NSValue *v in list) {
            if ([v nonretainedObjectValue] == rb) {
                return YES;
            }
        }
        return NO;
    };
    
    if (!buttonExistInList(_sharedButtons, self)) {
        [_sharedButtons addObject:[NSValue valueWithNonretainedObject:self]];
    }
    
    for (KIGroupButton *rb in groupButtons) {
        if (rb->_sharedButtons != _sharedButtons) {
            if (rb->_sharedButtons == nil) {
                rb->_sharedButtons = _sharedButtons;
            } else {
                for (NSValue *v in rb->_sharedButtons) {
                    KIGroupButton *temp = [v nonretainedObjectValue];
                    if (!buttonExistInList(_sharedButtons, temp)) {
                        [_sharedButtons addObject:v];
                        temp->_sharedButtons = _sharedButtons;
                    }
                }
            }
        }
        
        if (!buttonExistInList(_sharedButtons, rb)) {
            [_sharedButtons addObject:[NSValue valueWithNonretainedObject:rb]];
        }
    }
}

@end
