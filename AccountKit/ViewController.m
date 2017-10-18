//
//  ViewController.m
//  AccountKit
//
//  Created by Joseph.Tsai on 2017/10/17.
//  Copyright © 2017年 Joseph.Tsai. All rights reserved.
//

#import "ViewController.h"
#import <AccountKit/AccountKit.h>

@interface ViewController () <AKFViewControllerDelegate>
{
    AKFAccountKit *_accountKit;
    UIViewController<AKFViewController> *akfVC;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // initialize Account Kit
    if (_accountKit == nil) {
        // may also specify AKFResponseTypeAccessToken
        _accountKit = [[AKFAccountKit alloc] initWithResponseType:AKFResponseTypeAuthorizationCode];
    }
    
    akfVC = [_accountKit viewControllerForPhoneLoginWithPhoneNumber:nil state:nil];
    akfVC.uiManager = [[AKFSkinManager alloc]initWithSkinType:AKFSkinTypeTranslucent primaryColor:[UIColor purpleColor]];
    
    [self _prepareLoginViewController:akfVC];
    [self.view addSubview:akfVC.view];
}


- (void)_prepareLoginViewController:(UIViewController<AKFViewController> *)loginViewController
{
    loginViewController.delegate = self;
    loginViewController.whitelistedCountryCodes = @[@"TW"];
    // Optionally, you may use the Advanced UI Manager or set a theme to customize the UI.
    loginViewController.advancedUIManager = nil;
    loginViewController.theme = [self bicycleTheme];
}

- (AKFTheme *)bicycleTheme
{
    AKFTheme *theme = [AKFTheme outlineThemeWithPrimaryColor:[self _colorWithHex:0xffff5a5f]
                                            primaryTextColor:[UIColor whiteColor]
                                          secondaryTextColor:[UIColor whiteColor]
                                              statusBarStyle:UIStatusBarStyleLightContent];
//    theme.backgroundImage = [UIImage imageNamed:@"bicycle"];
    theme.backgroundColor = [self _colorWithHex:0x66000000];
    theme.inputBackgroundColor = [self _colorWithHex:0x00000000];
    theme.inputBorderColor = [UIColor whiteColor];
    return theme;
}

- (UIColor *)_colorWithHex:(NSUInteger)hex
{
    CGFloat alpha = ((CGFloat)((hex & 0xff000000) >> 24)) / 255.0;
    CGFloat red = ((CGFloat)((hex & 0x00ff0000) >> 16)) / 255.0;
    CGFloat green = ((CGFloat)((hex & 0x0000ff00) >> 8)) / 255.0;
    CGFloat blue = ((CGFloat)((hex & 0x000000ff) >> 0)) / 255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}


#pragma mark - AKFVC delegate
- (void)viewController:(UIViewController<AKFViewController> *)viewController didCompleteLoginWithAccessToken:(id<AKFAccessToken>)accessToken state:(NSString *)state{
    
    [_accountKit requestAccount:^(id<AKFAccount> account, NSError *error) {
        NSLog(@"userInfo id : %@ ,token id: %@ , phone : %@ , AKFAccount %@",account.accountID,accessToken.accountID ,  [account.phoneNumber stringRepresentation] , account);
    }];
    
}

- (void)viewController:(UIViewController<AKFViewController> *)viewController didCompleteLoginWithAuthorizationCode:(NSString *)code state:(NSString *)state{
    
    NSLog(@"authorization %@",code);
    
}

- (void)viewController:(UIViewController<AKFViewController> *)viewController didFailWithError:(NSError *)error{
    NSLog(@"error %@",error.userInfo);
}

- (void)viewControllerDidCancel:(UIViewController<AKFViewController> *)viewController{
    
}




@end
