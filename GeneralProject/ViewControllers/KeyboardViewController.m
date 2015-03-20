//
//  KeyboardViewController.m
//  GeneralProject
//
//  Created by Chendi on 15/2/27.
//  Copyright (c) 2015年 Cindy. All rights reserved.
//

#import "KeyboardViewController.h"

@interface KeyboardViewController ()
{
    UITextField *_fieldText;
}

@end

@implementation KeyboardViewController

#pragma mark - 
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (IBAction)buttonPress:(UIButton *)sender
{
    if (sender.tag == 100) {
        
        
//        NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage];
//        NSLog(@"primaryLanguage : %@",lang);
        
        
        _fieldText.keyboardType = UIKeyboardTypeEmailAddress;
        NSLog(@"result : %zi",[_fieldText becomeFirstResponder]) ;
        sender.tag = 101;
    } else {
        [_fieldText resignFirstResponder];
        sender.tag = 100;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _fieldText = [[UITextField alloc] init];
    [self.view addSubview:_fieldText];
    _fieldText.keyboardType = UIKeyboardTypeEmailAddress;
    _fieldText.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textInputCurrentInputModeDidChangeNotification:) name:UITextInputCurrentInputModeDidChangeNotification object:nil];
    
}

- (void)textFieldTextDidChangeNotification:(NSNotification *)notification
{
    NSLog(@"================= notification ==============");
    static NSString *lastContent = @"";
    NSString *newStr = _fieldText.text;
    NSLog(@"now text : %@",newStr);
    if (![lastContent isEqualToString:newStr]) {
        if (newStr.length < lastContent.length) {
            NSLog(@"delete char : %@",[lastContent stringByReplacingOccurrencesOfString:newStr withString:@""]);
        } else if (newStr.length > lastContent.length) {
            NSLog(@"enter char : %@",[newStr stringByReplacingOccurrencesOfString:lastContent withString:@""]);
        } else {
            NSLog(@"exception !!!!");
            NSLog(@"newStr : (%@) \n lastStr : (%@)",newStr,lastContent);
        }
        lastContent = newStr;
    }
    NSLog(@" \n");
}

- (void)textInputCurrentInputModeDidChangeNotification:(NSNotification *)notification
{
//    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage];
//    NSLog(@"primaryLanguage : %@",lang);
    NSLog(@"notification : %@",notification);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
