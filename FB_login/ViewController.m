//
//  ViewController.m
//  FB_login
//
//  Created by Joseph.Tsai on 2017/10/24.
//  Copyright © 2017年 Joseph.Tsai. All rights reserved.
//

#import "ViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *fbLogin;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.fbLogin.layer setCornerRadius:5.0f];
    self.fbLogin.readPermissions = @[@"public_profile", @"email", @"user_friends",@"user_likes",@"user_birthday",@"user_actions.video"];
    self.fbLogin.delegate=self;
    
    //friends -> only get amount , taggable_friends > can get , but need apply by FB
    //likes -> OK
    //birthday -> OK
    //user_actions.video -> fail , but video.watches ->OK
    //mobile_phone -> fail
    
    
    if ([FBSDKAccessToken currentAccessToken]) {
        // User is logged in, do work such as go to next view controller.
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - FBSDKLoginButtonDelegate
- (void)loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
              error:(NSError *)error{
    
    if (error) {
        NSLog(@"error code %ld",error.code);
    }else{
        NSLog(@"grantedPermissions are %@",result.grantedPermissions);
        NSLog(@"declinedPermissions are %@",result.declinedPermissions);
        NSLog(@"user cancel %d",result.isCancelled);
        NSLog(@"token is %@",result.token);
    }
    
}
- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{
    NSLog(@"user fb logout");
}






@end
