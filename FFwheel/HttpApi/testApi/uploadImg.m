//
//  uploadImg.m
//  FFwheel
//
//  Created by ffzp on 2019/9/11.
//  Copyright © 2019 ffzp. All rights reserved.
//

#import "uploadImg.h"
#import "AFNetworking.h"
@implementation uploadImg
{
    UIImage *_image;
}
-(id)initWithImage:(UIImage *)image{
    self = [super init];
    if (self) {
        _image = image;
    }
    return self;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

-(NSString *)requestUrl{
    return @"/app/testUploadVideo";
}

- (AFConstructingBlock)constructingBodyBlock {
    return ^(id<AFMultipartFormData> formData) {
        NSData *data = UIImageJPEGRepresentation(self->_image, 0.9);
        NSString *name = @"video";
        NSString *formKey = @"video";
        NSString *type = @"image/jpeg";
        [formData appendPartWithFileData:data name:formKey fileName:name mimeType:type];
    };
}



@end
