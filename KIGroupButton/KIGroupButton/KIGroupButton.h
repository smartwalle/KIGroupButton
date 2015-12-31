//
//  KIGroupButton.h
//  KIGroupButton
//
//  Created by apple on 15/12/31.
//  Copyright (c) 2015年 SmartWalle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KIGroupButton : UIButton {
@protected
    NSMutableArray *_sharedButtons;
}

@property (nonatomic, strong) IBOutletCollection(KIGroupButton) NSArray *groupButtons;

@end
