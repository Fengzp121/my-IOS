//
//  MemoryCheck.m
//  iOSTest-OC
//
//  Created by ffzp on 2020/7/6.
//  Copyright © 2020 ffzp. All rights reserved.
//

#import "MemoryCheck.h"
#import <mach/mach.h>
@implementation MemoryCheck

- (int64_t)memoryUsage {
    int64_t memoryUsageInByte = 0;
    task_vm_info_data_t vmInfo;
    mach_msg_type_number_t count = TASK_VM_INFO_COUNT;
    kern_return_t kernelReturn = task_info(mach_task_self(), TASK_VM_INFO, (task_info_t) &vmInfo, &count);
    if(kernelReturn == KERN_SUCCESS) {
        memoryUsageInByte = (int64_t) vmInfo.phys_footprint;
        NSLog(@"Memory in use (in bytes): %lld", memoryUsageInByte);
    } else {
        NSLog(@"Error with task_info(): %s", mach_error_string(kernelReturn));
    }

    return memoryUsageInByte;
}

@end
