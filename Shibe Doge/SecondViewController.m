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
	BOOL editingTextField;
	UITextField *selectedTextField;
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
	
	if (editingTextField)
	{
		[selectedTextField resignFirstResponder];
	}
	else
	{
		[self addNewTextFieldWithCenter:CGPointMake([tap locationInView:contentView].x, [tap locationInView:contentView].y)];
	}
}

- (void)addNewTextFieldWithCenter:(CGPoint)center
{
	UITextField *suchTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
	[suchTextField setText:@"wow"];
	[suchTextField sizeToFit];
	[suchTextField setFrame:CGRectMake(suchTextField.frame.origin.x - 10, suchTextField.frame.origin.y - 10, suchTextField.frame.size.width + 20, suchTextField.frame.size.height + 20)];
	[suchTextField setFont:[UIFont fontWithName:@"ComicSansMS" size:20]];
	[suchTextField setTextColor:[UIColor whiteColor]];
	[suchTextField setCenter:center];
	[suchTextField setTextAlignment:NSTextAlignmentCenter];
	[suchTextField setDelegate:self];
	[suchTextField addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
	[contentView addSubview:suchTextField];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	NSLog(@"textFieldDidBeginEditing");
	editingTextField = YES;
	selectedTextField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	NSLog(@"textFieldDidEndEditing");
	editingTextField = NO;
}

- (void)textFieldValueChanged:(UITextField *)textField
{
	NSLog(@"%@", textField.text);
	
	[textField sizeToFit];
	[textField setFrame:CGRectMake(textField.frame.origin.x, textField.frame.origin.y, textField.frame.size.width + 20, textField.frame.size.height + 20)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
