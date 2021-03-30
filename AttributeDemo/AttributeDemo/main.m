//
//  main.m
//  AttributeDemo
//
//  Created by 你吗 on 2021/3/26.
//

#import <Foundation/Foundation.h>

////aligned 用来调整内存对齐中每行的位数
////如果设置少于4，编译器会自动优化成4
////好像最大也只能是8
//struct stu{
//    char sex;
//    int length;
//    char name[2];
//    char value[16];
//}__attribute__((aligned(16)));
//struct stu my_stu;
//        NSLog(@"%lu",sizeof(my_stu));
//        NSLog(@"%p %p,%p,%p",&my_stu,&my_stu.length,&my_stu.name,&my_stu.value);
//        NSLog(@"Hello, World!");



//// alloc_size 需要和 __builtin_object_size 一起使用
//// alloc_size 也只能最多两个参数，参数的意义就是指定函数的第几个形参
//// 根据我们传入的值的大小，从 __builtin_object_size 中获取的就是多少
//// 如果有两个参数，那么就会是两个参数的大小相乘的结果。
//// 这个就是给指针绑定了空间大小了
//void *my_malloc(int a) __attribute__((alloc_size(1)));
//void *my_callocd(int a, int b, int m) __attribute__((alloc_size(1,3)));
//void *my_malloc(int a){
//    return NULL;
//}
//void *my_callocd(int a, int b, int m){
//    return NULL;
//}
//        void *const p = my_malloc(100);
//        NSLog(@"%d", __builtin_object_size(p,1));
//
//        void *const a = my_callocd(20,3,5);
//        NSLog(@"%d", __builtin_object_size(a,2));



////没使用汇编会有callq    _inlineFunction
////如果使用 __attribute__((always_inline))
////汇编中就没callq了
//__attribute__((always_inline)) void inlineFunction(){int a = 10; a+= 10;}
//void testInline(){inlineFunction();}
//        testInline();



////在类前面添加，该类就无法添加子类，如果添加了，会编译出错。
//__attribute__((objc_subclassing_restricted))


//在父类中某个被重写的方法上添加这个，编译器会提醒子类的重写方法中调用[super]
//__attribute__((objc_requires_spuer))

//将 struct 和 union 转换成 NSValue
//__attribute__((objc_boxable))
//然后可以使用NSValue的语法糖。至于是什么，还没了解过
//struct __attribute__((objc_boxable)) _people {
//    int year;
//    NSString *name;
//};
//union __attribute__((objc_boxable)) _student {
//    int class;
//};
//typedef struct __attribute__((objc_boxable)) _people people;
//people p;
//NSValue *boxed = @(p);


////constructor/destructor，构造器和析构器，可以在main函数之前和之后调用函数
////constructor的调用会比load方法晚一点
////destructor会调用在exit函数之前。
////可以调整他们的调用优先级。后面的参数就是优先级
////__attribute_((constructor(101))) 【0-100】是系统保留了，不能占用，数字越小越优先
////constructor可以用来做很坏的事情，因为load方法已经加载完成了，内存中已经有被加载类的信息。
//__attribute__((constructor))
//void funca(){
//    NSLog(@"beforeMain");
//}
//
//__attribute__((destructor))
//void funcb(){
//    NSLog(@"beforeExit");
//}

////用在一个变量上，当变量的作用域结束时，调用一个指定函数
//__attribute__((cleanup(func)))


////重载一个C函数，同名函数根据传入参数不同来调用
//__attribute__((overloadable)))

////可以用在interface和protocol上，将类名或者协议名在编译期换成指定名字
//__attribute__((objc_runtime_name("xxx")))

////_Noreturn 需要与jump系列操作配和使用
//jmp_buf jump_buffer;
//_Noreturn void func(int a ){
//    printf("a is : %d \n",a);
//    longjmp(jump_buffer, a+1);
//}
//
//volatile int a = 0; //必须使用volatile类型
//if(setjmp(jump_buffer) != 9) func(a++);


////introduced 首次定义，deprecated 弃用版本， obsoleted 废弃版本，unavailable 平台无效， message=string-literal 在废弃或者弃用版本的提示，replacement=string-literal 该api的代替api
//void f(void) __attribute__((availability(macos,introduced=10.4,deprecated=10.6,obsoleted=10.7)));

////deprecated(gnu::deprecated)
////用来表示废弃api
////第一个参数是废弃的消息，第二个是建议用来替代的函数
//void f(void) __attribute__((deprecated("message","replacement")));


////diagnose_if用来添加一些函数调用时需要满足的条件，会在编译时发出警告或者提醒
////不会发出运行时的的警告的。
//int  tabs(int a)
//__attribute__((diagnose_if(a >= 0, "Redundant abs call", "warning")));
//int must_abs(int a)
//__attribute__((diagnose_if(a >= 0, "Redundant abs call", "error")));
//int val = tabs(1);    //warning
//int val2 = must_abs(1);//error
//int val3 = tabs(val);//nothing
//int val4 = must_abs(val);//nothing


////enable_if,刚好和diagnose_if的条件设置相反
//void func(int a)__attribute__((enable_if(a>0 && a<120,"我是xx"))){
//    NSLog(@"11:%d",a);
//}
//func(1000);


////__has_attribute 用来检测是否有attribute属性
//#if __has_feature(attribute_ns_returns_retained)
//#define NS_RETURNS_RETAINED __attribute__((ns_returns_retained))
//#else
//#define NS_RETURNS_RETAINED
//#endif


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSLog(@"main");
        
        
    }
    return 0;
}
