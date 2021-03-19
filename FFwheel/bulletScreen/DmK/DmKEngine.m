//
//  DmkEngine.m
//  FFwheel
//
//  Created by 你吗 on 2021/3/19.
//  Copyright © 2021 ffzp. All rights reserved.
//

#import "DmKEngine.h"
#import "DmKItem.h"
#import "DmKCanvas.h"
@interface DmKEngine()
@property (nonatomic,strong)DmKCanvas *canvas;
@end

@implementation DmKEngine

-(instancetype)init{
    if(self = [super init]){
        _canvas = [[DmKCanvas alloc] init];
        
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
