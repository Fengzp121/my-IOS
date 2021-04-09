//
//  FFFaceDetect.h
//  FFwheel
//
//  Created by 你吗 on 2021/4/8.
//  Copyright © 2021 ffzp. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, FFFaceDetectType){
    FFFaceDetectType_OPENCV,
    FFFaceDetectType_FACEPP,
    FFFaceDetectType_VISION,
    FFFaceDetectType_TENSORFLOW,
};

NS_ASSUME_NONNULL_BEGIN

@interface FFFaceDetect : NSObject

@property (nonatomic, assign) CGSize sampleBufferSize;

@property (nonatomic, assign) FFFaceDetectType faceDetectType;

+ (instancetype)defaultInstance;

- (void)start;

- (void)stop;

- (void)licenseFacepp;

- (float *)detectWithSampleBuffer:(CMSampleBufferRef)sampleBuffer facePointCount:(int *)facePointCount isMirror:(BOOL)isMirror;

- (void)visionDetectWithSampleBuffer:(CMSampleBufferRef)sampleBuffer completHandler:(void(^)(void))completHandler;

@end

NS_ASSUME_NONNULL_END


import org.apache.jmeter.config.Arguments;
import org.apache.jmeter.protocol.java.sampler.AbstractJavaSamplerClient;
import org.apache.jmeter.protocol.java.sampler.JavaSamplerContext;
import org.apache.jmeter.samplers.SampleResult;

public class CalcSampler extends AbstractJavaSamplerClient {
    
    @Override
    public Arguments getDefaultParameters() {
        Arguments params = new Arguments();
        //请求的参数的添加，取决于业务本身的需要
        params.addArgument("type","请输入计算类型，可用：add或者minus");
        params.addArgument("n1","请输入数字1");
        params.addArgument("n2","请输入数字2");
        return params;
    }

    @Override
    public SampleResult runTest(JavaSamplerContext arg0) {
        
        String mytype = arg0.getParameter("type");
        
        int num1 = arg0.getIntParameter("n1");
        
        int num2 = arg0.getIntParameter("n2");
        
        //实例化业务请求类
        Calc c = new Calc();
        
        String result = "";
        
        SampleResult sr = new SampleResult();
        //表示开始计时
        sr.sampleStart();
        //使用try/catch/finally是为了做异常处理，如果不考虑异常处理，便可以不用加这个
        try {
            //if中为业务调用的内容,做完之后把结果给我就行
            if (mytype.equals("add")) {
                result = String.valueOf(c.add(num1, num2));
            }
            if (mytype.equals("minus")) {
                result = String.valueOf(c.minus(num1, num2));
            }
            //设置返回结果和状态
            sr.setResponseData(result,SampleResult.TEXT);
            sr.setSuccessful(true);
        } catch (Exception e) {
            //设置返回结果和状态
            sr.setResponseData(e.getMessage(),SampleResult.TEXT);
            sr.setSuccessful(false);
        }
        finally{
            //表示计时结束
            sr.sampleEnd();
        }
        return sr;
    }

}
