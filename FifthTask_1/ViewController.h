//
//  ViewController.h
//  FifthTask_1
//
//  Created by Jinwoo on 2023/07/30.
//

#import <UIKit/UIKit.h>
#import "ViewItemSerch.h"
#import "ItemMaster.h"
#import "ItemCode.h"
#import "ViewWaitPopup.h"

@interface ViewController : UIViewController <ViewUserInfoDelefate,UITableViewDelegate , UITableViewDataSource, UITextFieldDelegate, ViewItemDelegate >

-(void) setSaveData;
-(void) getSaveData;

@end

