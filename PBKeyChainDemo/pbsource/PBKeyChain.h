//
//  PBKeyChain.h
//  PBKeyChainDemo
//
//  Created by wentao lu on 2021/5/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PBKeyChain : NSObject
+ (void)setPassword:(NSString *)password forService:(NSString *)service account:(NSString *)account;
+ (NSString *)passwordForService:(NSString *)service account:(NSString *)account;
+ (void)deletePasswordForService:(NSString *)service account:(NSString *)account;
@end

NS_ASSUME_NONNULL_END
