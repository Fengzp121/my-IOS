//
//  FFSocketTest.h
//  FFwheel
//
//  Created by ffzp on 2019/3/14.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"
@interface FFSocketTest : NSObject


//生成单例
+(instancetype)sharedInstance;

-(BOOL)connect;
-(void)disconnect;
-(void)sendMsg:(NSString *)msg;
-(void)pullMsg;

@end

