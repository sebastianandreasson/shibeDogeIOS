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
	
	UITextField *suchTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
	[suchTextField setText:@"wow"];
//	[suchTextField setFont:[UIFont fontWithName:@"ComicSans" size:14]];
	[suchTextField setCenter:CGPointMake([tap locationInView:contentView].x, [tap locationInView:contentView].y)];
	[contentView addSubview:suchTextField];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
