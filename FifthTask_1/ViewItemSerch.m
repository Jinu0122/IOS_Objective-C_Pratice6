//
//  ViewItemSerch.m
//  FifthTask_1
//
//  Created by Jinwoo on 2023/07/30.
//

#import "ViewItemSerch.h"

@implementation ViewItemSerch

{
    UIButton *btnAll;
    UIButton *btnKospi;
    UIButton *btnKosdaq;
    UIButton *btnETN;
    UITextField *edtText;
    UITableView *tableView;
    
    NSInteger tableCount;
    
    NSMutableArray *arrayList;
    
    NSString *itemGubun;
    
}

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        
        [self f_InitUISetting:frame];
        
        arrayList = [[NSMutableArray alloc]init];
        
        [self onBtnItemClick:btnAll];
        
        [edtText becomeFirstResponder];
    }
    return self;
    
    
}

- (void)f_InitUISetting:(CGRect)frame
{
    UILabel *lblBg = [[UILabel alloc]initWithFrame:CGRectMake(0 , 0, frame.size.width , frame.size.height)];
    [lblBg setBackgroundColor:[UIColor whiteColor]];
    
    [self addSubview:lblBg];
    
    edtText = [[UITextField alloc]initWithFrame:CGRectMake(24, CGRectGetMinY(self.frame) + 110, CGRectGetMaxX(self.frame) - 48, 50)];
    [edtText setBackgroundColor:[[UIColor grayColor]colorWithAlphaComponent:0.3]];
    [edtText addTarget:self action:@selector(onEditChange:)  forControlEvents:UIControlEventEditingChanged];
    [edtText setBorderStyle: UITextBorderStyleBezel];
    [edtText setReturnKeyType: UIReturnKeyDone];
    [edtText setAutocorrectionType: UITextAutocorrectionTypeNo];
    [edtText setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    edtText.delegate = self;
    [self addSubview:edtText];
    
    btnAll = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.frame) + 24, CGRectGetMinY(self.frame) + 170, 70, 50)];
    [btnAll setBackgroundColor:[UIColor blueColor]];
    [btnAll setTitle:@"전체" forState:UIControlStateNormal];
    [btnAll addTarget:self action:@selector(onBtnItemClick:) forControlEvents:UIControlEventTouchUpInside];
    [btnAll setTag:1];
    [self addSubview:btnAll];
    
    btnKospi = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.frame) + 108, CGRectGetMinY(self.frame) + 170, 70, 50)];
    [btnKospi setBackgroundColor:[[UIColor blueColor]colorWithAlphaComponent:0.5]];
    [btnKospi setTitle:@"코스피" forState:UIControlStateNormal];
    [btnKospi addTarget:self action:@selector(onBtnItemClick:) forControlEvents:UIControlEventTouchUpInside];
    [btnKospi setTag:2];
    [self addSubview:btnKospi];
    
    btnKosdaq = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.frame) + 192, CGRectGetMinY(self.frame) + 170, 70, 50)];
    [btnKosdaq setBackgroundColor:[[UIColor blueColor]colorWithAlphaComponent:0.5]];
    [btnKosdaq setTitle:@"코스닥" forState:UIControlStateNormal];
    [btnKosdaq addTarget:self action:@selector(onBtnItemClick:) forControlEvents:UIControlEventTouchUpInside];
    [btnKosdaq setTag:3];
    [self addSubview:btnKosdaq];
    
    btnETN = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.frame) + 276, CGRectGetMinY(self.frame) + 170, 70, 50)];
    [btnETN setBackgroundColor:[[UIColor blueColor]colorWithAlphaComponent:0.5]];
    [btnETN setTitle:@"ETN" forState:UIControlStateNormal];
    [btnETN addTarget:self action:@selector(onBtnItemClick:) forControlEvents:UIControlEventTouchUpInside];
    [btnETN setTag:4];
    [self addSubview:btnETN];
    
    tableView = [[UITableView alloc]  initWithFrame:CGRectMake(0, CGRectGetMinY(self.frame) + 240, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - 240)];
    
    [tableView setRowHeight:50];
    
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    
    [self addSubview:tableView];
    
    UIButton *btnClose = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.frame) - 54 , CGRectGetMinY(self.frame) + 70, 40, 40)];
    [btnClose addTarget:self action:@selector(onClose:) forControlEvents:UIControlEventTouchUpInside];
    [btnClose setBackgroundColor:[UIColor whiteColor]];
    [btnClose setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnClose setTitle:@"X" forState:UIControlStateNormal];
    [self addSubview:btnClose];
}


// 키패드 올라와 있을 때 다른 영역 터치 시 키패드 닫기
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
     [self endEditing:YES];
}


// 키보드 return key 선택 시 처리
// 키패드를 내림 resignFirstResponder
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return true;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
    //    return [mutableArray count];
    return tableCount;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    UILabel *lblCode = nil;
    UILabel *lblName = nil;
    UILabel *lblGubun = nil;
    UIImageView *imgView = nil;
    
    
    
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
        
        lblName = [[UILabel alloc] initWithFrame:CGRectMake(110, 0, CGRectGetWidth(tableView.frame) - 190, 45)];
        [lblName setBackgroundColor:[[UIColor lightGrayColor]colorWithAlphaComponent:0.3]];
        [lblName setTextAlignment:NSTextAlignmentCenter];
        [lblName setTag:2];
        [cellTable addSubview:lblName];
        
        
        lblGubun = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(tableView.frame) - 75, 0, 70, 45)];
        [lblGubun setBackgroundColor:[[UIColor lightGrayColor]colorWithAlphaComponent:0.3]];
        [lblGubun setTextAlignment:NSTextAlignmentCenter];
        [lblGubun setTag:3];
        [cellTable addSubview:lblGubun];
        
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(tableView.frame) - 50, 10, 24 , 24)];
        [imgView setTag:4];
        [cellTable addSubview:imgView];
        
        
        
    }else{
        
        lblCode = [cellTable viewWithTag:1];
        lblName = [cellTable viewWithTag:2];
        lblGubun = [cellTable viewWithTag:3];
        imgView = [cellTable viewWithTag:4];
        
    }
    
    ItemCode *itemData = [arrayList objectAtIndex:indexPath.row];
    
    [lblCode setText:itemData.jongmokCode];
    [lblName setText:itemData.jongmokName];
    
    [imgView setImage:[UIImage imageNamed:[self f_GetJongMokGubunName:itemData.jongmokMarket]]];

//    [lblGubun setText:[self f_GetJongMokGubunName:itemData.jongmokMarket]];
    
    
    
    
    return cellTable;
    
    
}

- (NSString*)f_GetJongMokGubunName:(NSString*)sValue{
    
    NSString *sName;
    
    if ([sValue isEqualToString:@"1"]){
        sName = @"icon_K";
    }
    else if ([sValue isEqualToString:@"4"]){
        sName = @"icon_Q";
    }
    else if ([sValue isEqualToString:@"A"]){
        sName = @"icon_N";
    }
    
    return sName;
}

- (void)onBtnItemClick:(UIButton*)sender // 추가버튼 클릭시
{
    
    [self f_SetRdoBtnBgColorChange:[sender tag]]; // Rdo 처럼 보이게 색상 셋팅
    
    
    if ([sender tag] == 1) { // 전체
        
        [edtText setText:@""];
        
        itemGubun = @"ALL";
        
    }
    else if ([sender tag] == 2){ // 코스피
        
        [edtText setText:@""];
        
        itemGubun = @"KOSPI";
        
    }
    else if ([sender tag] == 3){ // 코스닥
        
        [edtText setText:@""];
        
        itemGubun = @"KOSDAQ";
        
    }
    else if ([sender tag] == 4){ // ETN
        
        [edtText setText:@""];
        
        itemGubun = @"ETN";
    }
    
    arrayList = [self f_getArrayList:itemGubun];

    [self f_DataSort:arrayList];
    

    
    tableCount = arrayList.count;
    
    [tableView reloadData];
}

- (NSMutableArray *) f_DataSort:(NSMutableArray *)arrayList{
    NSArray *tempArray = [arrayList sortedArrayUsingComparator:^NSComparisonResult(ItemCode *obj1, ItemCode *obj2) {
            return [obj1.jongmokName compare:obj2.jongmokName options:NSCaseInsensitiveSearch];
        }];
    
    [arrayList setArray:tempArray];
    return arrayList;
}

- (NSMutableArray*)f_getArrayList:(NSString*)sGubun{
    
    NSMutableArray *arraySend;
    
    if ([sGubun isEqualToString:@"ALL"]){
        arraySend = [[ItemMaster Instance] f_GetAllCode];
    }
    else if ([sGubun isEqualToString:@"KOSPI"]){
        arraySend = [[ItemMaster Instance] f_GetKospiCode];
    }
    else if ([sGubun isEqualToString:@"KOSDAQ"]){
        arraySend = [[ItemMaster Instance] f_GetKosdaqCode];
    }
    else if ([sGubun isEqualToString:@"ETN"]){
        arraySend = [[ItemMaster Instance] f_GetETNCode];
    }
    
    
    return arraySend;
}

-(void)onClose:(UIButton *) sender{
    
    [self.delegate CloseScreen];
}

// 에딧트 수정될대
-(void)onEditChange:(UITextField *) sender{
    
    if ([[[edtText text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""] ){
        
        arrayList = [self f_getArrayList:itemGubun];
        tableCount = arrayList.count;
        
        [tableView reloadData];
        
    }else{
        
    BOOL result = [[ItemMaster Instance] f_SerchText:[edtText text] Gubun:itemGubun];
        
        if (result == true){
            
            arrayList = [[ItemMaster Instance] f_GetSerchCode];
            tableCount = arrayList.count;
            [tableView reloadData];
        }
    }
}

- (void)f_SetRdoBtnBgColorChange:(NSInteger)nValue{
    if (nValue == 1){
        [btnAll setBackgroundColor:[UIColor blueColor]];
        [btnKospi setBackgroundColor:[[UIColor blueColor]colorWithAlphaComponent:0.5]];
        [btnKosdaq setBackgroundColor:[[UIColor blueColor]colorWithAlphaComponent:0.5]];
        [btnETN setBackgroundColor:[[UIColor blueColor]colorWithAlphaComponent:0.5]];
    }
    else if (nValue == 2){
        [btnAll setBackgroundColor:[[UIColor blueColor]colorWithAlphaComponent:0.5]];
        [btnKospi setBackgroundColor:[UIColor blueColor]];
        [btnKosdaq setBackgroundColor:[[UIColor blueColor]colorWithAlphaComponent:0.5]];
        [btnETN setBackgroundColor:[[UIColor blueColor]colorWithAlphaComponent:0.5]];
    }
    else if (nValue == 3){
        [btnAll setBackgroundColor:[[UIColor blueColor]colorWithAlphaComponent:0.5]];
        [btnKospi setBackgroundColor:[[UIColor blueColor]colorWithAlphaComponent:0.5]];
        [btnKosdaq setBackgroundColor:[UIColor blueColor]];
        [btnETN setBackgroundColor:[[UIColor blueColor]colorWithAlphaComponent:0.5]];
    }
    else if (nValue == 4){
        [btnAll setBackgroundColor:[[UIColor blueColor]colorWithAlphaComponent:0.5]];
        [btnKospi setBackgroundColor:[[UIColor blueColor]colorWithAlphaComponent:0.5]];
        [btnKosdaq setBackgroundColor:[[UIColor blueColor]colorWithAlphaComponent:0.5]];
        [btnETN setBackgroundColor:[UIColor blueColor]];
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    ItemCode *item = [arrayList objectAtIndex:indexPath.row];
    
    [self.delegate getData:item];
    
}

-(void) dealloc{
    NSLog(@"ViewItemSerch Screen dealloc");
    
    [btnAll removeFromSuperview];
    [btnKospi removeFromSuperview];
    [btnKosdaq removeFromSuperview];
    [btnETN removeFromSuperview];
    [edtText removeFromSuperview];
    [tableView removeFromSuperview];

    
    [self CloseNilProc:btnAll];
    [self CloseNilProc:btnKospi];
    [self CloseNilProc:btnKosdaq];
    [self CloseNilProc:btnETN];
    [self CloseNilProc:edtText];
    [self CloseNilProc:tableView];
    [self CloseNilProc:arrayList];
    [self CloseNilProc:itemGubun];
}

-(void)CloseNilProc:sObject{
    if (sObject != nil) {
        sObject = nil;
    }
}

@end


