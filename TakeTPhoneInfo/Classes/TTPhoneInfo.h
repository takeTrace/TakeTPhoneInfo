//
//  TTPhoneInfo.h
//  TakeTPhoneInfo
//
//  Created by BigPapa on 2020/11/26.
//

#import <Foundation/Foundation.h>
#import <LFPhoneInfo/LFPhoneInfo.h>

NS_ASSUME_NONNULL_BEGIN

@interface LFPhoneInfo(TTPhoneInfo)
@property (class, readonly) NSUInteger deviceTotalMemoryByte;
@property (class, readonly) NSUInteger appTakeUpMemoryByte;
@property (class, readonly) NSUInteger deviceTotalDiskByte;
@property (class, readonly) NSUInteger deviceFreeDiskByte;
@property (class, readonly) NSArray<NSString *> *deviceCarrierContryCodes;
@property (class, readonly) NSString *dnsInfo;
@end

NS_ASSUME_NONNULL_END
