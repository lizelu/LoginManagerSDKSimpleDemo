//
//  ViewController.m
//  MyLoginTest
//
//  Created by Mr.LuDashi on 16/8/24.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

#import "LoginViewController.h"
#import "AccountManager.h"

@interface LoginViewController ()
@property (strong, nonatomic) IBOutlet UITextField *userNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UILabel *loginStateLabel;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

@property (strong, nonatomic) AccountManager * accountManager;

@property (nonatomic, strong) LoginBlock loginSuccessBlock;
@property (nonatomic, strong) LoginFailureBlock loginFailureBlock;

@property (strong, nonatomic) NSString *token;

@end

@implementation LoginViewController

#pragma make - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLoginManager];
    NSLog(@"Log - Debug - Test");
}

#pragma makr - setter and getter
- (void)setLoginResult: (LoginBlock)loginBlock
          failureBlock: (LoginFailureBlock) failBlock {
    self.loginSuccessBlock = loginBlock;
    self.loginFailureBlock = failBlock;
}

- (IBAction)tapLoginButton:(id)sender {
    if (![self textFieldIsNull:_userNameTextField] &&
        ![self textFieldIsNull:_passwordTextField]) {
        NSLog(@"%@, %@", _userNameTextField.text, _passwordTextField.text);
        [_accountManager loginWithUserName:_userNameTextField.text
                                password:_passwordTextField.text];
        
    }
}

#pragma mark - private method
- (void)initLoginManager {
    _accountManager = [AccountManager shareManager];
    
    __weak typeof(self) weak_self = self;
    
    [_accountManager setLoginResult:^(NSString *token) {
        [weak_self handelLogin:token];
    } failureBlock:^(NSString *errorMessage) {
        [weak_self tipText:errorMessage];
    }];
}

-(void)handelLogin: (NSString *)token {
    if (_loginSuccessBlock != nil) {
        _loginSuccessBlock(token);
        [self tipText:@"已登录"];
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

- (IBAction)tapDismissButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(Boolean) textFieldIsNull: (UITextField *) textFeild {
    return textFeild == nil || [textFeild.text isEqualToString:@""];
}

- (void)tipText: (NSString *)tip {
    self.loginStateLabel.text = tip;
    if (_loginFailureBlock != nil) {
        _loginFailureBlock(tip);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc {
    NSLog(@"释放");
}

@end
