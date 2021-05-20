//
//  PBKeyChain.m
//  PBKeyChainDemo
//
//  Created by wentao lu on 2021/5/19.
//

#import "PBKeyChain.h"
#import "PBKeyChainQuery.h"

@implementation PBKeyChain
+ (void)setPassword:(NSString *)password forService:(NSString *)service account:(NSString *)account {
    PBKeyChainQuery *model = [[PBKeyChainQuery alloc] init];
    model.password = password;
    model.account = account;
    model.service = service;
    [model save];
}

+ (NSString *)passwordForService:(NSString *)service account:(NSString *)account {
    PBKeyChainQuery *model = [[PBKeyChainQuery alloc] init];
    model.account = account;
    model.service = service;
    [model fetch];
    return model.password;
}

+ (void)deletePasswordForService:(NSString *)service account:(NSString *)account {
    PBKeyChainQuery *model = [[PBKeyChainQuery alloc] init];
    model.account = account;
    model.service = service;
    [model deleteItem];
}

@end
