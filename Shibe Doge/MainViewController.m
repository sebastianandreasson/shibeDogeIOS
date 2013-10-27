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
    NSArray *suchArray;
    
    NSTimer *animateTimer;
}

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [self initViews];
    
    animateTimer = [NSTimer scheduledTimerWithTimeInterval:0.6 target:self selector:@selector(animateText) userInfo:nil repeats:YES];
    suchArray = [[NSArray alloc] initWithObjects:@"wow",@"such app",@"so innovate",@"wow",@"wow",@"doge",@"amaze",@"such doge", @"much work", nil];
}

- (void)initViews{
    title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    [title setText:@"Shibe Doge"];
    [title setBackgroundColor:[UIColor clearColor]];
    [title setTextColor:[UIColor magentaColor]];
    [title setTextAlignment:NSTextAlignmentCenter];
    [title setFont:[UIFont fontWithName:@"Comic Sans MS Bold" size:24]];
    [self.view addSubview:title];
    
    animatedDoge = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 265, 265)];
    [animatedDoge setImage:[UIImage imageNamed:@"shibeNormal.png"]];
    [animatedDoge setCenter:self.view.center];
    [self.view addSubview:animatedDoge];
    
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

- (void)animateText{
    
    int randomX = (arc4random()%(280-1))+1;
    int randomY = (arc4random()%(400-50))+50;
    int randomIndex = arc4random()%suchArray.count;
    
    UILabel *aLabel = [[UILabel alloc] initWithFrame:CGRectMake(randomX, randomY, 100, 34)];
    [aLabel setText:[suchArray objectAtIndex:randomIndex]];
    [aLabel setTextColor:[UIColor colorWithRed:(arc4random()%255)/255.0 green:(arc4random()%255)/255.0 blue:(arc4random()%255)/255.0 alpha:1]];
    [self.view addSubview:aLabel];
    CGRect rect = aLabel.frame;
    rect.origin.y = randomY - 40;
    
    int randomDelay = (arc4random()%(4-1))+1;
    
    [UIView animateWithDuration:0.0f delay:randomDelay options:UIViewAnimationOptionCurveEaseOut animations:^{
    }completion:^(BOOL finished){
        [UIView animateWithDuration:1.2f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [aLabel setFrame:rect];
            [aLabel setAlpha:0];
        }completion:^(BOOL finished){
            [aLabel removeFromSuperview];
        }];
    }];
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
