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
//
//
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

////没使用汇编会有callq    _inlineFunction
////如果使用 __attribute__((always_inline))
////汇编中就没callq了
//__attribute__((always_inline)) void inlineFunction(){int a = 10; a+= 10;}
//void testInline(){inlineFunction();}




int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
//        NSLog(@"%lu",sizeof(my_stu));
//        NSLog(@"%p %p,%p,%p",&my_stu,&my_stu.length,&my_stu.name,&my_stu.value);
//        NSLog(@"Hello, World!");
//
//        void *const p = my_malloc(100);
//        NSLog(@"%d", __builtin_object_size(p,1));
//
//        void *const a = my_callocd(20,3,5);
//        NSLog(@"%d", __builtin_object_size(a,2));
        testInline();
    }
    return 0;
}
