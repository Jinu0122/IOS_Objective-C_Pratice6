//
//  ItemMaster.m
//  FifthTask_1
//
//  Created by Jinwoo on 2023/07/30.
//

#import "ItemMaster.h"

static ItemMaster* sharedInstance = nil;

@implementation ItemMaster
{
    
    NSThread *thread;
    
    NSMutableArray *arrayAll;
    NSMutableArray *arrayKospi;
    NSMutableArray *arrayKosdaq;
    NSMutableArray *arrayETN;
    NSMutableArray *arraySerch;
    
    NSDictionary *dicAll;
    NSDictionary *dicKospi;
    NSDictionary *dicKosdaq;
    NSDictionary *dicETN;
    NSDictionary *dicSerch;
}

+ (ItemMaster *) Instance
{
    if (sharedInstance == nil)
    {
        sharedInstance = [[ItemMaster alloc] init];
    }
    return sharedInstance;
}

- (id) init
{
    self = [super init];
    if (self)
    {
        
    }
 
    return self;
}

- (void) f_GetItemCode{
    thread = [[NSThread alloc]initWithTarget:self selector:@selector(onLoadFile) object:nil]; // 스레드를 사용하는 이유는 메인스레드에서 하면 파일읽어오는 시간 뒤에 뷰가 뜨니깐 뷰는 뷰대로 보이고 파일은 파일대로 읽도록 각자 스레드 돌게 만드는거임
    [thread start]; // thread = [[NSLoadFile alloc]initWithTarget:self selector:@selector(LoadFile2) object:nil];를 실행시키는거임
}

-(void)onLoadFile{
    
    NSError *err = NULL;
    NSString *szPath = [[NSBundle mainBundle] pathForResource:@"m_easy_stock" ofType:@"mst"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:szPath]) // 해당 파일이 있는지 예외처리
    {
        NSString *sFileData = [[NSString alloc] initWithContentsOfFile:szPath encoding:-2147481280 error:&err];
//        NSLog(@"Data [%@]", szDataFile);
        NSArray *arrayFileData = [sFileData componentsSeparatedByString:@"\n"];

//        _tItemInfo = [NSMutableArray arrayWithCapacity:tMasterFile.count];
        
        arrayAll = [[NSMutableArray alloc]init];
        arrayKospi = [[NSMutableArray alloc]init];
        arrayKosdaq = [[NSMutableArray alloc]init];
        arrayETN = [[NSMutableArray alloc]init];
        
        dicAll = [[NSMutableDictionary alloc]init];
        dicKospi = [[NSMutableDictionary alloc]init];
        dicKosdaq = [[NSMutableDictionary alloc]init];
        dicETN = [[NSMutableDictionary alloc]init];
        
        
        for ( NSString *sSubValue in arrayFileData )
            {
//                NSLog(@"sSubValue [%@]" , sSubValue);
                if (sSubValue == nil || sSubValue.length == 0)
                {
//
                }else{
                    NSArray *tItem = [sSubValue componentsSeparatedByString:@"|"];

                    if(!tItem || tItem.count == 0)
                    {
                    }else{
                        
                        ItemCode *itemData = [[ItemCode alloc]init];

                        itemData.jongmokCode = [tItem[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                        itemData.jongmokName = [tItem[1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                        itemData.jongmokMarket = [tItem[2] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                        
                        
                        [arrayAll addObject:itemData]; // 전체
                        [dicAll setValue:itemData.jongmokCode forKey:itemData.jongmokName];
                        
                        if ([itemData.jongmokMarket isEqualToString:@"1"]){ // 코스피
                            [arrayKospi addObject:itemData];
                            [dicKospi setValue:itemData.jongmokCode forKey:itemData.jongmokName];
                        
                        }
                        else if ([itemData.jongmokMarket isEqualToString:@"4"]){ // 코스닥
                            [arrayKosdaq addObject:itemData];
                            [dicKosdaq setValue:itemData.jongmokCode forKey:itemData.jongmokName];
                        
                        }
                        
                        else if ([itemData.jongmokMarket isEqualToString:@"A"]){ // ETN
                            [arrayETN addObject:itemData];
                            [dicETN setValue:itemData.jongmokCode forKey:itemData.jongmokName];
                        
                        }
                        else{
                            NSLog(@"남는 값이 있습니다.");
                        }
                        
                    }

                }
        }
            

    }else{
        NSLog(@"LoadFile_ERROR");
    }
    
    [thread cancel];
    thread = nil;
}

// NSMutableArray --------------------------------------------------------------------------------------------
- (NSMutableArray *) f_GetAllCode{
//    NSMutableArray *arraySendData = arrayAll;
//    return arraySendData;
    return  [NSMutableArray arrayWithArray:arrayAll];
}

- (NSMutableArray *) f_GetKospiCode{
//    NSMutableArray *arraySendData = arrayKospi;
//    return arraySendData;
    return [NSMutableArray arrayWithArray:arrayKospi];
}

- (NSMutableArray *) f_GetKosdaqCode{
//    NSMutableArray *arraySendData = arrayKosdaq;
//    return arraySendData;
    return [NSMutableArray arrayWithArray:arrayKosdaq];
}

- (NSMutableArray *) f_GetETNCode{
//    NSMutableArray *arraySendData = arrayETN;
//    return arraySendData;
    return [NSMutableArray arrayWithArray:arrayETN];
}

- (NSMutableArray *) f_GetSerchCode{
//    NSMutableArray *arraySendData = arraySerch;
//    return arraySendData;
    return [NSMutableArray arrayWithArray:arraySerch];
}

// NSDictionary --------------------------------------------------------------------------------------------
- (NSDictionary *) f_GetDictionaryAllCode{
//    NSDictionary *dicSendData = dicAll;
//    return dicSendData;
    return [NSMutableDictionary dictionaryWithDictionary:dicAll];
}

- (NSDictionary *) f_GetDictionaryKospiCode{
//    NSDictionary *dicSendData = dicKospi;
//    return dicSendData;
    return [NSMutableDictionary dictionaryWithDictionary:dicKospi];
}

- (NSDictionary *) f_GetDictionaryKosdaqCode{
//    NSDictionary *dicSendData = dicKosdaq;
//    return dicSendData;
    return [NSMutableDictionary dictionaryWithDictionary:dicKosdaq];
}

- (NSDictionary *) f_GetDictionaryETNCode{
//    NSDictionary *dicSendData = dicETN;
//    return dicSendData;
    return [NSMutableDictionary dictionaryWithDictionary:dicETN];
}

- (NSDictionary *) f_GetDictionarySerchCode{
//    NSDictionary *dicSendData = dicSerch;
//    return dicSendData;
    return [NSMutableDictionary dictionaryWithDictionary:dicSerch];
}

- (BOOL) f_SerchText:(NSString*)sText Gubun:(NSString*)sGubun{
    NSMutableArray *arrayList = [self f_GetGubunArrayList:sGubun];
    arraySerch = [[NSMutableArray alloc]init];
    dicSerch = [[NSMutableDictionary alloc]init];
    
    for (int i = 0; i< [arrayList count]; i++){
    
        ItemCode *itemData = [arrayList objectAtIndex:i];
        
        NSRange serchCode = [itemData.jongmokCode rangeOfString:sText];
        if (serchCode.location != NSNotFound) {
            [arraySerch addObject:itemData];
            [dicSerch setValue:itemData.jongmokCode forKey:itemData.jongmokName];
        }
        
        else {
            
             NSRange serchName = [itemData.jongmokName rangeOfString:sText];
             if (serchName.location != NSNotFound) {
                 [arraySerch addObject:itemData];
                 [dicSerch setValue:itemData.jongmokCode forKey:itemData.jongmokName];
              }
            
             else {
                  NSString *sTextJaum = [self GetUTF8String:sText];
                  NSString *sListJaum = [self GetUTF8String:itemData.jongmokName];

                  NSRange serchName = [sListJaum rangeOfString:sTextJaum];
                  if (serchName.location != NSNotFound) {
                      [arraySerch addObject:itemData];
                      [dicSerch setValue:itemData.jongmokCode forKey:itemData.jongmokName];
                  }
              }
         }
    }
    
    if (arraySerch.count > 0){
        return true;
    }
    else{
        return false;
    }
}

- (NSMutableArray*) f_GetGubunArrayList:(NSString*)sGubun{
    
//    NSMutableArray *arrayList = [[NSMutableArray alloc]init];
    NSMutableArray *arrayList;
    
    if ([sGubun isEqualToString:@"ALL"]){
        arrayList = arrayAll;
    }
    else if ([sGubun isEqualToString:@"KOSPI"]){
        arrayList = arrayKospi;
    }
    else if ([sGubun isEqualToString:@"KOSDAQ"]){
        arrayList = arrayKosdaq;
    }
    else if ([sGubun isEqualToString:@"ETN"]){
        arrayList = arrayETN;
    }
    
    return arrayList;
}

- (NSString *)GetUTF8String:(NSString *)hanggulString {
    NSArray *chosung = [[NSArray alloc] initWithObjects:@"ㄱ",@"ㄲ",@"ㄴ",@"ㄷ",@"ㄸ",@"ㄹ",@"ㅁ",@"ㅂ",@"ㅃ",@"ㅅ",@"ㅆ",@"ㅇ",@"ㅈ",@"ㅉ",@"ㅊ",@"ㅋ",@"ㅌ",@"ㅍ",@"ㅎ",nil];
    NSArray *jungsung = [[NSArray alloc] initWithObjects:@"ㅏ",@"ㅐ",@"ㅑ",@"ㅒ",@"ㅓ",@"ㅔ",@"ㅕ",@"ㅖ",@"ㅗ",@"ㅘ",@"ㅙ",@"ㅚ",@"ㅛ",@"ㅜ",@"ㅝ",@"ㅞ",@"ㅟ",@"ㅠ",@"ㅡ",@"ㅢ",@"ㅣ",nil];
    NSArray *jongsung = [[NSArray alloc] initWithObjects:@"",@"ㄱ",@"ㄲ",@"ㄳ",@"ㄴ",@"ㄵ",@"ㄶ",@"ㄷ",@"ㄹ",@"ㄺ",@"ㄻ",@"ㄼ",@"ㄽ",@"ㄾ",@"ㄿ",@"ㅀ",@"ㅁ",@"ㅂ",@"ㅄ",@"ㅅ",@"ㅆ",@"ㅇ",@"ㅈ",@"ㅊ",@"ㅋ",@" ㅌ",@"ㅍ",@"ㅎ",nil];
    NSString *textResult = @"";
    for (int i=0;i<[hanggulString length];i++) {
        NSInteger code = [hanggulString characterAtIndex:i];
        if (code >= 44032 && code <= 55203) {
            NSInteger uniCode = code - 44032;
            NSInteger chosungIndex = uniCode / 21 / 28;
            NSInteger jungsungIndex = uniCode % (21 * 28) / 28;
            NSInteger jongsungIndex = uniCode % 28;
            textResult = [NSString stringWithFormat:@"%@%@%@%@", textResult, [chosung objectAtIndex:chosungIndex], [jungsung objectAtIndex:jungsungIndex], [jongsung objectAtIndex:jongsungIndex]];
        }
    }
    return textResult;
}


-(void) dealloc{
    NSLog(@"ItemMaster Screen dealloc");
    
    
    [self CloseNilProc:thread];
    [self CloseNilProc:arrayAll];
    [self CloseNilProc:arrayKospi];
    [self CloseNilProc:arrayKosdaq];
    [self CloseNilProc:arrayETN];
    [self CloseNilProc:arraySerch];
    [self CloseNilProc:dicAll];
    [self CloseNilProc:dicKospi];
    [self CloseNilProc:dicKosdaq];
    [self CloseNilProc:dicETN];
    [self CloseNilProc:dicSerch];
}

-(void)CloseNilProc:sObject{
    if (sObject != nil) {
        sObject = nil;
    }
}


@end
