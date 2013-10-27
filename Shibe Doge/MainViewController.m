//
//  MainViewController.m
//  Shibe Doge
//
//  Created by Sebastian Andreasson on 2013-10-27.
//  Copyright (c) 2013 Sebastian Andreasson Apps. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController (){
    UIImageView *animatedDoge;
    UILabel *title;
    
    UIButton *photoButton;
    UIButton *libraryButton;
}

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [self initViews];
    
}

- (void)initViews{
    title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    [title setText:@"Shibe Doge"];
    [title setBackgroundColor:[UIColor clearColor]];
    [title setTextColor:[UIColor magentaColor]];
    [title setTextAlignment:NSTextAlignmentCenter];
    [title setFont:[UIFont fontWithName:@"Comic Sans MS Bold" size:24]];
    [self.view addSubview:title];
    
    photoButton = [[UIButton alloc] initWithFrame:CGRectMake(170, self.view.frame.size.height-64, 130, 44)];
    [photoButton setBackgroundColor:[UIColor orangeColor]];
    [photoButton setTitle:@"such photo" forState:UIControlStateNormal];
    [photoButton addTarget:self action:@selector(goToNextPage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:photoButton];
    
    libraryButton = [[UIButton alloc] initWithFrame:CGRectMake(20, self.view.frame.size.height-64, 130, 44)];
    [libraryButton setBackgroundColor:[UIColor orangeColor]];
    [libraryButton setTitle:@"such library" forState:UIControlStateNormal];
    [self.view addSubview:libraryButton];
}

- (void)goToNextPage{
    [self performSegueWithIdentifier:@"suchSegue" sender:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
