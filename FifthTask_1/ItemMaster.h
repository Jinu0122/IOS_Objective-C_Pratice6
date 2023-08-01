//
//  ItemMaster.h
//  FifthTask_1
//
//  Created by Jinwoo on 2023/07/30.
//

#import <Foundation/Foundation.h>
#import "ItemCode.h"

NS_ASSUME_NONNULL_BEGIN

@interface ItemMaster : NSObject

+ (ItemMaster *) Instance;
- (void) f_GetItemCode;
- (BOOL) f_SerchText:(NSString*)sText Gubun:(NSString*)sGubun;
- (NSMutableArray*) f_GetAllCode;
- (NSMutableArray*) f_GetKospiCode;
- (NSMutableArray*) f_GetKosdaqCode;
- (NSMutableArray*) f_GetETNCode;
- (NSMutableArray*) f_GetSerchCode;

@end

NS_ASSUME_NONNULL_END
