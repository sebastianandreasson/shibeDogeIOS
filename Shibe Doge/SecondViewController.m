//
//  SecondViewController.m
//  Shibe Doge
//
//  Created by Johan Cato on 2013-10-27.
//  Copyright (c) 2013 Sebastian Andreasson Apps. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController
{
	UIView *contentView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

	}
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	[self.view setBackgroundColor:[UIColor redColor]];
	
	contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
	[self.view addSubview:contentView];
	
	UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
	[contentView addGestureRecognizer:tapGestureRecognizer];
}


- (void)handleTap:(UITapGestureRecognizer *)tap
{
	NSLog(@"asd");
	
	if (contentView.subviews.count < 1)
	{
		[self addNewTextFieldWithCenter:CGPointMake([tap locationInView:contentView].x, [tap locationInView:contentView].y)];
	}
	else
	{
		for (UITextField *subView in contentView.subviews)
		{
			if ([subView isFirstResponder])
			{
				[subView resignFirstResponder];
				break;
			}
			else
			{
				[self addNewTextFieldWithCenter:CGPointMake([tap locationInView:contentView].x, [tap locationInView:contentView].y)];
				break;
			}
		}
	}
}

- (void)addNewTextFieldWithCenter:(CGPoint)center
{
	UITextField *suchTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
	[suchTextField setText:@"wow"];
	[suchTextField setFont:[UIFont fontWithName:@"ComicSansMS" size:20]];
	[suchTextField setTextColor:[UIColor whiteColor]];
	[suchTextField setCenter:center];
	[contentView addSubview:suchTextField];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	NSLog(@"textFieldDidBeginEditing");
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	NSLog(@"textFieldDidEndEditing");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
