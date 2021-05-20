//
//  PBKeyChainQuery.m
//  PBKeyChainDemo
//
//  Created by wentao lu on 2021/5/19.
//

#import "PBKeyChainQuery.h"

@interface PBKeyChainQuery()
@property (nonatomic, strong) NSData *passwordData;
@end

@implementation PBKeyChainQuery
- (BOOL)save {
    NSMutableDictionary *searchQuery = [self query];
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)searchQuery, NULL);
    if (status == errSecSuccess) {
        NSMutableDictionary *query = [[NSMutableDictionary alloc] init];
        [query setObject:self.passwordData forKey:(__bridge id<NSCopying>)kSecValueData];
        status = SecItemUpdate((__bridge CFDictionaryRef)searchQuery, (__bridge CFDictionaryRef)query);
    } else {
        NSMutableDictionary *query = [searchQuery mutableCopy];
        [query setObject:self.passwordData forKey:(__bridge id<NSCopying>)kSecValueData];
        status = SecItemAdd((__bridge CFDictionaryRef)query, NULL);
    }
    return status == errSecSuccess;
}

- (BOOL)fetch {
    CFTypeRef result = NULL;//这个地方会有内存泄露么，c和oc可以混编么
    NSMutableDictionary *searchQuery = [[self query] mutableCopy];
    [searchQuery setObject:@YES forKey:(__bridge id<NSCopying>)kSecReturnData];
    [searchQuery setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id<NSCopying>)kSecMatchLimit];
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)searchQuery, &result);
    if (status == errSecSuccess) {
        self.passwordData = (__bridge_transfer NSData *)result;
        return YES;
    }
    
    return NO;
}

- (BOOL)deleteItem {
    NSMutableDictionary *searchQuery = [[self query] mutableCopy];
    OSStatus status = SecItemDelete((__bridge CFDictionaryRef)searchQuery);
    return status == errSecSuccess;
}

- (NSString *)password {
    if ([self.passwordData length]) {
        return [[NSString alloc] initWithData:self.passwordData encoding:NSUTF8StringEncoding];
    }
    return nil;
}

- (NSMutableDictionary *)query {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithCapacity:3];
    [dictionary setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id<NSCopying>)kSecClass];
    if (self.service) {
        [dictionary setObject:_service forKey:(__bridge id<NSCopying>)kSecAttrService];
    }
    
    if (self.account) {
        [dictionary setObject:_account forKey:(__bridge id<NSCopying>)kSecAttrAccount];
    }
    return dictionary;
}

- (void)setPassword:(NSString *)password {
    self.passwordData = [password dataUsingEncoding:NSUTF8StringEncoding];
}

@end
