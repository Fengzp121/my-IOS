//
//  NSDictionary+toString.h
//  FFwheel
//
//  Created by ffzp on 2019/1/22.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NSDictionary(util)
-(NSString *) toString:(NSString *)aKey;
-(int)toInt:(NSString *)aKey;
-(float)toFloat:(NSString *)aKey;
-(NSObject *)toObject:(NSString *)akey;
-(BOOL)isPureInt:(NSString*)string;
-(BOOL)isPureFloat:(NSString *)string;
@end

 
