//
//  PBKeyChainQuery.h
//  PBKeyChainDemo
//
//  Created by wentao lu on 2021/5/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PBKeyChainQuery : NSObject
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *service;
@property (nonatomic, copy) NSString *account;
- (BOOL)save;
- (BOOL)fetch;
- (BOOL)deleteItem;
@end

NS_ASSUME_NONNULL_END
