//
//  TTPhoneInfo.m
//  TakeTPhoneInfo
//
//  Created by BigPapa on 2020/11/26.
//

#import "TTPhoneInfo.h"
#include <resolv.h>
#include <dns.h>
#include <arpa/inet.h>

@implementation LFPhoneInfo(TTPhoneInfo)
+ (NSString *)dnsInfo {
    NSMutableArray *dnsList = [NSMutableArray array];
    res_state res = malloc(sizeof(struct __res_state));
    int result = res_ninit(res);
    if (result == 0) {
        for (int i=0;i<res->nscount;i++) {
            NSString *s = [NSString stringWithUTF8String:inet_ntoa(res->nsaddr_list[i].sin_addr)];
            [dnsList addObject:s];
        }
    }
    res_nclose(res);
    res_ndestroy(res);
    free(res);
    
    return [dnsList firstObject];
}

+ (NSUInteger)deviceTotalMemoryByte{
    return [NSProcessInfo processInfo].physicalMemory;
}

+ (NSUInteger)appTakeUpMemoryByte{
    int64_t memoryUsageInByte = 0;
    task_vm_info_data_t vmInfo;
    mach_msg_type_number_t count = TASK_VM_INFO_COUNT;
    kern_return_t kernelReturn = task_info(mach_task_self(), TASK_VM_INFO, (task_info_t) &vmInfo, &count);
    if(kernelReturn == KERN_SUCCESS) {
        memoryUsageInByte = (int64_t) vmInfo.phys_footprint;
    } else {
        NSLog(@"Error with task_info(): %s", mach_error_string(kernelReturn));
    }
    return memoryUsageInByte;
}

+ (NSUInteger)deviceTotalDiskByte{
    NSError *error = nil;
    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) return 0;
    int64_t space =  [[attrs objectForKey:NSFileSystemSize] longLongValue];
    if (space < 0) space = 0;
    return space;
}

+ (NSUInteger)deviceFreeDiskByte{
    NSError *error = nil;
    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) return 0;
    int64_t space =  [[attrs objectForKey:NSFileSystemFreeSize] longLongValue];
    if (space < 0) space = 0;
    return space;
}

/**
 * 通过系统框架获取设备运营商所在国家 Code, ISO 3166-1，返回值可能不准确
 * e.g. @"中国移动" @"中国联通" @"中国电信" nil
 */
+ (NSArray<NSString *> *)deviceCarrierContryCodes {
    //    CTTelephonyNetworkInfo *telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
    //    CTCarrier *carrier = [telephonyInfo subscriberCellularProvider];
    //    NSString *isoCountryCode = [carrier isoCountryCode];
    //    return isoCountryCode;
    CTTelephonyNetworkInfo *telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
    NSMutableArray<NSString *> *tmpList = [NSMutableArray array];
    if (@available(iOS 12.0, *)) {
        NSDictionary *infoDict = telephonyInfo.serviceSubscriberCellularProviders;
        // iOS 12 以上可能为双卡
        for (CTCarrier *tmpCT in infoDict.allValues) {
            if (tmpCT.mobileCountryCode && tmpCT.mobileNetworkCode && tmpCT.isoCountryCode) {
                [tmpList addObject:tmpCT.isoCountryCode];
            }
        }
        return tmpList.copy;
    }
    // iOS 12 以下为单卡
    CTCarrier *carrier = telephonyInfo.subscriberCellularProvider;
    if (carrier.mobileCountryCode && carrier.mobileNetworkCode && carrier.isoCountryCode) {
        [tmpList addObject:carrier.isoCountryCode];
    }
    return tmpList.copy;
}
@end
