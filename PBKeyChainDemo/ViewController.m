//
//  ViewController.m
//  PBKeyChainDemo
//
//  Created by wentao lu on 2021/5/19.
//

#import "ViewController.h"
#import <Security/Security.h>
#import "PBKeyChain.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //面容登录
    NSString *service = @"theService";
    NSString *account = @"theAccount";
    [PBKeyChain deletePasswordForService:service account:account];
//    [PBKeyChain setPassword:@"123456" forService:service account:account];
    
    NSString *accountNo = [PBKeyChain passwordForService:service account:account];
    NSLog(@"%@", accountNo);
}


@end
