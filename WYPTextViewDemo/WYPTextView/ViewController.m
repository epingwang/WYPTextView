//
//  ViewController.m
//  WYPTextView
//
//  Created by 怒赞Nuzan-2 on 7/10/14.
//  Copyright (c) 2014 WYP. All rights reserved.
//

#import "ViewController.h"
#import "WYPTextView.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    WYPTextView *textView = [[WYPTextView alloc] initWithFrame:CGRectMake(0, 20, 320, self.view.frame.size.height - 20)];
    textView.placeholder = @"请输入";
    [self.view addSubview:textView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
