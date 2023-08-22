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
    ViewWaitPopup *uiWaitView;
    
    UILabel *lblSerch;
    UITableView *tableView;
    
    NSMutableArray *itemList;
    
    NSString *curCode;
    NSString *curName;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUISetting];
    
    uiWaitView = [[ViewWaitPopup alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    [self.view addSubview:uiWaitView];
    
    
    
    ItemMaster.Instance.delegate = self;
    [[ItemMaster Instance]f_GetItemCode];
    
//    [uiWaitView removeFromSuperview];
//    uiWaitView = nil;
    
    NSNotificationCenter * nCenter = [NSNotificationCenter defaultCenter];
     [nCenter addObserver:self selector:@selector(getNotification:) name:@"kMyClassNotificationName" object:nil];
    
    itemList = [[NSMutableArray alloc]init];
    
//    [self getSaveData];
    
    
}

- (void)CloseWaitPopup{
    [uiWaitView removeFromSuperview];
    uiWaitView = nil;
    NSLog(@"CloseWaitPopup");
}

- (void)getNotification:sender{
//    [uiWaitView removeFromSuperview];
//    uiWaitView = nil;
    NSLog(@"getNotification");
}

- (void)initUISetting{
    lblSerch  = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.view.frame) + 24, CGRectGetMinY(self.view.frame) + 100, CGRectGetMaxX(self.view.frame) - 48, 50)];
    
    [lblSerch setBackgroundColor:[[UIColor grayColor]colorWithAlphaComponent:0.5]];
    
    [self.view addSubview:lblSerch];
    
    UIButton *btnSerch = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.view.frame) + 24, CGRectGetMinY(self.view.frame) + 100, CGRectGetMaxX(self.view.frame) - 48, 50)];
    
    [btnSerch addTarget:self action:@selector(onBtnSerchClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btnSerch];
    
    tableView = [[UITableView alloc]  initWithFrame:CGRectMake(0, CGRectGetMinY(self.view.frame) + 170, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 240)];
    
    [tableView setRowHeight:50];
    
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    
    [self.view addSubview:tableView];
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

    jongmokItem = objData;
    
    [itemList addObject:jongmokItem];
    
    [lblSerch setText:jongmokItem.jongmokName];
    
    curCode = jongmokItem.jongmokCode;
    curName = jongmokItem.jongmokName;
    
    [tableView reloadData];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
    
    return [itemList count];
//    return 50;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    UILabel *lblCode = nil;
    UILabel *lblName = nil;

    UITableViewCell* cellTable = [tableView dequeueReusableCellWithIdentifier:@"CALENDAR_TEST"];
    if (cellTable == nil) {
        cellTable = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CALENDAR_TEST"];
        cellTable.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cellTable setClipsToBounds:YES];
        
        lblCode = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 100, 45)];
        [lblCode setBackgroundColor:[[UIColor lightGrayColor]colorWithAlphaComponent:0.3]];
        [lblCode setTextAlignment:NSTextAlignmentCenter];
        [lblCode setTag:1];
        [cellTable addSubview:lblCode];
        
        lblName = [[UILabel alloc] initWithFrame:CGRectMake(110, 0, CGRectGetWidth(tableView.frame) - 115, 45)];
        [lblName setBackgroundColor:[[UIColor lightGrayColor]colorWithAlphaComponent:0.3]];
        [lblName setTextAlignment:NSTextAlignmentCenter];
        [lblName setTag:2];
        [cellTable addSubview:lblName];
        
        
        
        
    }else{
        
        lblCode = [cellTable viewWithTag:1];
        lblName = [cellTable viewWithTag:2];
        
    }
    
    ItemCode *itemData = [itemList objectAtIndex:indexPath.row];
    
    [lblCode setText:itemData.jongmokCode];
    [lblName setText:itemData.jongmokName];
    
    return cellTable;
    
}

-(void) getSaveData{
    NSMutableArray *arrayData = [[NSMutableArray alloc]init];
    NSString *getData;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fullFileName = [NSString stringWithFormat:@"%@/ITEM_INFO.txt", documentsDirectory];
    
    getData = [[NSString alloc]initWithContentsOfFile:fullFileName encoding:NSUTF8StringEncoding error:nil];
    
    NSData *data = [[NSData alloc] initWithBytes:[getData UTF8String] length:[getData lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
    //    NSData *videoData = [NSData dataWithContentsOfFile: getData];
    
    arrayData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    itemList = [[NSMutableArray alloc]init];
    
    if (arrayData == nil) {
        NSLog(@"Get Failed");
        return;
    }
    
    
    for (int i = 0; i< [arrayData count]; i++){ // 객체로 테이블 셋팅하기때문에 다시 객체로 변환해주기

        ItemCode *info = [ItemCode alloc];
        
        info.jongmokCode = [[arrayData objectAtIndex:i]objectAtIndex:0];
        info.jongmokName = [[arrayData objectAtIndex:i]objectAtIndex:1];
        
        if (i == [arrayData count] -1){
            curCode = info.jongmokCode;
            curName = info.jongmokName;
        }
        else{
            [itemList addObject:info];
        }
        
    }
    
    NSLog(@"Get Success");
    [lblSerch setText:curName];
    [tableView reloadData];
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;


-(void) setSaveData{
    NSLog(@"setSaveData");
    NSMutableArray *arrayData = [[NSMutableArray alloc]init];
    
    if ([itemList count] == 0 ) {
        return;
    }
    
    for (int i = 0; i< [itemList count]; i++){
        ItemCode *info = [itemList objectAtIndex:i];
        
        [arrayData addObject:@[info.jongmokCode, info.jongmokName]];
    }
    
    [arrayData addObject:@[curCode, curName]];
    
    NSData *jsonChange = [NSJSONSerialization dataWithJSONObject:arrayData options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonResult = [[NSString alloc] initWithData:jsonChange encoding:NSUTF8StringEncoding];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fullFileName = [NSString stringWithFormat:@"%@/ITEM_INFO.txt", documentsDirectory];
    
    NSError *err = nil;
    BOOL ret = [jsonResult writeToFile:fullFileName atomically:NO encoding:NSUTF8StringEncoding error:&err];
    
    if (err != nil){
        [err localizedFailureReason];
    }

    if (!ret){
        NSLog(@"Save Failed");
    }
    else{
        NSLog(@"Save Success");
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    ItemCode *info = [itemList objectAtIndex:indexPath.row];

    curCode = info.jongmokCode;
    curName = info.jongmokName;
 
    [lblSerch setText:curName];
}

-(void) dealloc{
    NSLog(@"ViewUserInfo Screen dealloc");
    
//    [self setSaveData];
    
    [lblSerch removeFromSuperview];
    [tableView removeFromSuperview];
    
    [self CloseNilProc:uiView];
    [self CloseNilProc:jongmokItem];
    [self CloseNilProc:uiWaitView];
    [self CloseNilProc:lblSerch];
    [self CloseNilProc:tableView];
    
    [self CloseNilProc:itemList];
    [self CloseNilProc:curCode];
    [self CloseNilProc:curName];
    
}

-(void)CloseNilProc:sObject{
    if (sObject != nil) {
        sObject = nil;
    }
}


@end

