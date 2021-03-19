//
//  DmkEngine.m
//  FFwheel
//
//  Created by 你吗 on 2021/3/19.
//  Copyright © 2021 ffzp. All rights reserved.
//

#import "DmkEngine.h"
#import "DmKItem.h"
#import "DmkCanvas.h"
@interface DmkEngine()
@property (nonatomic,strong)DmkCanvas *canvas;
@end

@implementation DmkEngine

-(instancetype)init{
    if(self = [super init]){
        _canvas = [[DmkCanvas alloc] init];
        
    }
    return self;
}

-(void)start{
    
}

-(void)end{
    
}

-(void)pause{
    
}

-(void)receive:(id)arr{
    
}



@end
