//
//  FFRequestGenerator.h
//  FFwheel
//
//  Created by ffzp on 2019/1/22.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FFRequestModel.h"

@interface FFRequestGenerator : NSObject

+(instancetype)sharedInstance;

-(NSURLRequest *)generateWithRequestDataModel:(FFRequestModel *)dataModel;

@end


