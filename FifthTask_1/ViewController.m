//
//  ViewController.m
//  FifthTask_1
//
//  Created by Jinwoo on 2023/07/30.
//

#import "ViewController.h"

@interface ViewController ()
{
    ViewItemSerch *uiView;
    ItemCode *jongmokItem;
    
    UILabel *lblSerch;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUISetting];
    
    [[ItemMaster Instance]f_GetItemCode];
    
}

- (void)initUISetting{
    lblSerch  = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.view.frame) + 24, CGRectGetMinY(self.view.frame) + 100, CGRectGetMaxX(self.view.frame) - 48, 50)];
    
    [lblSerch setBackgroundColor:[[UIColor grayColor]colorWithAlphaComponent:0.5]];
    
    [self.view addSubview:lblSerch];
    
    UIButton *btnSerch = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.view.frame) + 24, CGRectGetMinY(self.view.frame) + 100, CGRectGetMaxX(self.view.frame) - 48, 50)];
    
    [btnSerch addTarget:self action:@selector(onBtnSerchClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btnSerch];
}

- (void)onBtnSerchClick:(UIButton*)sender{ // 추가버튼 클릭시{
    
    uiView = [[ViewItemSerch alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    uiView.delegate = self;
    [self.view addSubview:uiView];
}

- (void)CloseScreen{
    
    [uiView removeFromSuperview];
    uiView = nil;
}
- (void)getData:(ItemCode*)objData;

{
    
    [uiView removeFromSuperview];
    uiView = nil;
    
    // (?)
    jongmokItem = objData;
    
    [lblSerch setText:jongmokItem.jongmokName];
    
    
}

-(void) dealloc{
    NSLog(@"ViewUserInfo Screen dealloc");
    
    [lblSerch removeFromSuperview];
    
    [self CloseNilProc:uiView];
    [self CloseNilProc:jongmokItem];
    [self CloseNilProc:lblSerch];
}

-(void)CloseNilProc:sObject{
    if (sObject != nil) {
        sObject = nil;
    }
}

@end


