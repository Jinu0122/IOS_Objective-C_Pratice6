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

@interface ViewController : UIViewController <ViewUserInfoDelefate>

 // 리턴값 타입이 다른 2개를 보낼수 있는지?
 // @synthesize delegate; control + cmd + 클릭 시 3개가 나오는이유..?
 // ViewController (?) 주석된곳 보면 alloc 하지도않았는데 값이 잘나오는데 어떤건 alloc 을 해야하고 어떤건 안해도되고 잘구분이 안가는데 질문하기
 // arrayWithArray 가 정확히 모하는앤지...

@end

