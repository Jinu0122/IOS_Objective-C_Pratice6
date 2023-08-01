//
//  ItemCode.h
//  FifthTask_1
//
//  Created by Jinwoo on 2023/07/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ItemCode : NSObject{

}


@property (nonatomic, retain, getter=getCode, setter=setCode:) NSString *jongmokCode;
@property (nonatomic, retain, getter=getName, setter=setName:) NSString *jongmokName;
@property (nonatomic, assign, getter=getMarketCode)  NSString *jongmokMarket;

@end

NS_ASSUME_NONNULL_END
