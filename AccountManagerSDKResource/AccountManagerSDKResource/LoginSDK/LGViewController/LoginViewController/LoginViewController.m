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
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

@property (strong, nonatomic) AccountManager * accountManager;
@property (nonatomic, strong) LoginBlock loginSuccessBlock;
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
- (void)setLoginResult: (LoginBlock)loginBlock {
    self.loginSuccessBlock = loginBlock;
}

- (IBAction)tapLoginButton:(id)sender {
    if (![self textFieldIsNull:_userNameTextField] &&
        ![self textFieldIsNull:_passwordTextField]) {
        NSLog(@"%@, %@", _userNameTextField.text, _passwordTextField.text);
        [_accountManager loginWithUserName:_userNameTextField.text
                                password:_passwordTextField.text];
        
    } else {
        [self tipText:@"请输入用户名或密码"];
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
        [self.view endEditing:YES];
        [self dismissViewControllerAnimated:YES completion:^{
             _loginSuccessBlock(token);
        }];
    }
}

- (IBAction)tapDismissButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)tapGestrueRecognize:(id)sender {
    [self.view endEditing:YES];
}

-(Boolean) textFieldIsNull: (UITextField *) textFeild {
    return textFeild == nil || [textFeild.text isEqualToString:@""];
}

- (void)tipText: (NSString *)tip {
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:tip delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
    [alter show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc {
    NSLog(@"释放");
}

@end
