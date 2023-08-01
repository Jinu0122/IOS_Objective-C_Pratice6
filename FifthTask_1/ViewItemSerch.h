//
//  ViewItemSerch.h
//  FifthTask_1
//
//  Created by Jinwoo on 2023/07/30.
//

#import <UIKit/UIKit.h>
#import "ItemMaster.h"
#import "ItemCode.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ViewUserInfoDelefate <NSObject>

- (void)getData:(ItemCode*)value;
- (void)CloseScreen;

@end

@interface ViewItemSerch : UIView < UITableViewDelegate , UITableViewDataSource, UITextFieldDelegate >
    

@property ( nonatomic , weak  ) id<ViewUserInfoDelefate> delegate;

@end

NS_ASSUME_NONNULL_END
