//
//  ViewController.m
//  SendSMSInApp
//
//  Created by Robin.Chao on 11/10/14.
//  Copyright (c) 2014 Robin. All rights reserved.
//

#import "ViewController.h"
#import <MessageUI/MessageUI.h>

@interface ViewController ()<MFMessageComposeViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *sendSMSBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendSMSBtn.frame = CGRectMake(0, 0, 100, 50);
    sendSMSBtn.center = self.view.center;
    sendSMSBtn.backgroundColor = [UIColor blackColor];
    [sendSMSBtn setTitle:@"SendSMS" forState:UIControlStateNormal];
    [sendSMSBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendSMSBtn addTarget:self action:@selector(sendSMS:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendSMSBtn];
}


- (void)sendSMS:(id)sender {
    
    BOOL canSendSMS = [MFMessageComposeViewController canSendText];
    NSLog(@"can send SMS [%d]", canSendSMS);
    if (canSendSMS) {
        
        MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
        picker.messageComposeDelegate = self;
        picker.navigationBar.tintColor = [UIColor blackColor];
        picker.body = @"Sned SMS in App";
        picker.recipients = [NSArray arrayWithObject:@"186-0123-0123"];
        
        [self presentViewController:picker animated:YES completion:NULL];
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    
    // Notifies users about errors associated with the interface
    switch (result) {
        case MessageComposeResultCancelled:
            if (DEBUG) NSLog(@"Result: canceled");
            break;
        case MessageComposeResultSent:
            if (DEBUG) NSLog(@"Result: Sent");
            break;
        case MessageComposeResultFailed:
            if (DEBUG) NSLog(@"Result: Failed");
            break;
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
