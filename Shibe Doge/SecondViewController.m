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
	NSUserDefaults *defaults;

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

	defaults = [NSUserDefaults standardUserDefaults];
	
	[self.view setBackgroundColor:[UIColor blackColor]];
	
	[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageWithData:[defaults objectForKey:@"image"]]]];
	
	contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
	[self.view addSubview:contentView];
	
	UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
	[contentView addGestureRecognizer:tapGestureRecognizer];
	
	// BottomView
	UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, 320, 50)];
	[bottomView setBackgroundColor:[UIColor whiteColor]];
	[self.view addSubview:bottomView];
	
	UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
	[backBtn setBackgroundColor:[UIColor redColor]];
	[backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
	[bottomView addSubview:backBtn];
	
	UIButton *doneBtn = [[UIButton alloc]initWithFrame:CGRectMake(270, 0, 50, 50)];
	[doneBtn setBackgroundColor:[UIColor greenColor]];
	[doneBtn addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
	[bottomView addSubview:doneBtn];
}

#pragma mark - Actions

- (void)back
{
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)done
{
	NSLog(@"such beautiful");
}

#pragma mark - GestureRecognizers

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
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

- (void)handlePinch:(UIPinchGestureRecognizer *)pinch
{
    pinch.view.transform = CGAffineTransformScale(pinch.view.transform, pinch.scale, pinch.scale);
    pinch.scale = 1;
}


- (void)handleRotate:(UIRotationGestureRecognizer *)rotate
{
    rotate.view.transform = CGAffineTransformRotate(rotate.view.transform, rotate.rotation);
    rotate.rotation = 0;
}

- (void)handlePan:(UIPanGestureRecognizer *)pan
{
    CGPoint translation = [pan translationInView:self.view];
    pan.view.center = CGPointMake(pan.view.center.x + translation.x,
                                         pan.view.center.y + translation.y);
    [pan setTranslation:CGPointMake(0, 0) inView:self.view];
}

- (void)addNewTextFieldWithCenter:(CGPoint)center
{
	UITextField *suchTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
	[suchTextField setText:@"such text"];
	[suchTextField setFont:[UIFont fontWithName:@"ComicSansMS" size:25]];
	[suchTextField sizeToFit];
	[suchTextField setFrame:CGRectMake(suchTextField.frame.origin.x - 10, suchTextField.frame.origin.y - 10, suchTextField.frame.size.width + 20, suchTextField.frame.size.height + 20)];
	[suchTextField setTextColor:[UIColor whiteColor]];
	[suchTextField setCenter:center];
	[suchTextField setTextAlignment:NSTextAlignmentCenter];
	[suchTextField setDelegate:self];
	[suchTextField addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
	[contentView addSubview:suchTextField];
	
	UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
	[panGestureRecognizer setDelegate:self];
	[suchTextField addGestureRecognizer:panGestureRecognizer];
	
	UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(handlePinch:)];
	[pinchGestureRecognizer setDelegate:self];
	[suchTextField addGestureRecognizer:pinchGestureRecognizer];
	
	UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(handleRotate:)];
	[rotationGestureRecognizer setDelegate:self];
	[suchTextField addGestureRecognizer:rotationGestureRecognizer];
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
//	[textField setFrame:CGRectMake(textField.frame.origin.x, textField.frame.origin.y, textField.frame.size.width + 20, textField.frame.size.height + 20)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
