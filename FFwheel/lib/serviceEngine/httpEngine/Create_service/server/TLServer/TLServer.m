 

#import "TLServer.h"
@interface TLServer()
{
    NSString * _serverHeader;
}

@end
@implementation TLServer
@synthesize releaseApiBaseUrl = _releaseApiBaseUrl;

-(id)init{
    if(self = [super init]){
        //设置服务器头
        //_serverHeader = @"39.108.133.34:8909";
    }
    return self;
}

- (NSString *)releaseApiBaseUrl {
    if (_releaseApiBaseUrl == nil) {
        _releaseApiBaseUrl = @"http://182.254.197.21:8909";
    }
    return _releaseApiBaseUrl;
}

@end
