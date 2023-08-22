//
//  ViewWaitPopup.m
//  FifthTask_1
//
//  Created by Jinwoo on 2023/08/08.
//

#import "ViewWaitPopup.h"

@implementation ViewWaitPopup

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self f_InitUISetting:frame];
        
    }
    return self;
    
}

- (void)f_InitUISetting:(CGRect)frame
{
    UILabel *lblBg = [[UILabel alloc]initWithFrame:CGRectMake(0 , 0, frame.size.width , frame.size.height)];
    [lblBg setBackgroundColor:[[UIColor blackColor]colorWithAlphaComponent:0.5]];
    
    [self addSubview:lblBg];
    
    UILabel *lblBox = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.frame) + 50, CGRectGetMinY(self.frame) + 200, CGRectGetWidth(self.frame) - 100, CGRectGetHeight(self.frame) - 400)];
    [lblBox setBackgroundColor:[UIColor whiteColor]];
    
    [self addSubview:lblBox];

    UILabel *lblText = [[UILabel alloc]initWithFrame:CGRectMake(lblBox.frame.origin.x + 24, lblBox.frame.origin.y, lblBox.frame.size.width - 48, lblBox.frame.size.height)];
    
    [lblText setNumberOfLines:0];
    [lblText setText:@"마스터를 읽고있습니다. 잠시만 기다려주세요."];
    
    [self addSubview:lblText];

}

@end
