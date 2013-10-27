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
	
	NSTimer *animateTimer;
	NSArray *suchArray;
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
	
	animateTimer = [NSTimer scheduledTimerWithTimeInterval:0.6 target:self selector:@selector(animateText) userInfo:nil repeats:YES];

	[self.view setBackgroundColor:[UIColor blackColor]];
	
	UILabel *titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, 320, 40)];
	[titleLbl setText:@"tap image for add texts !"];
	[titleLbl setTextAlignment:NSTextAlignmentCenter];
	[titleLbl setFont:[UIFont fontWithName:@"ComicSansMS" size:20]];
	[titleLbl setTextColor:[UIColor magentaColor]];
	[self.view addSubview:titleLbl];
	
	UILabel *titleLbl2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 55, 320, 40)];
	[titleLbl2 setText:@"move trn zoom pretty !!"];
	[titleLbl2 setTextAlignment:NSTextAlignmentCenter];
	[titleLbl2 setFont:[UIFont fontWithName:@"ComicSansMS" size:20]];
	[titleLbl2 setTextColor:[UIColor magentaColor]];
	[self.view addSubview:titleLbl2];
	
	contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, 320, 320)];
	[self.view addSubview:contentView];
	
	UIImageView *bgImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 320)];
	[bgImage setImage:[UIImage imageWithData:[defaults objectForKey:@"image"]]];
	[bgImage setContentMode:UIViewContentModeScaleAspectFill];
	[contentView addSubview:bgImage];
	
	UIImageView *dogeImg = [[UIImageView alloc]initWithFrame:CGRectMake(22.5, 122, 265, 265)];
	[dogeImg setImage:[UIImage imageWithData:[defaults objectForKey:@"doge"]]];
	[dogeImg setContentMode:UIViewContentModeCenter];
	[dogeImg setUserInteractionEnabled:YES];
	[self.view addSubview:dogeImg];
	
	UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
	[panGestureRecognizer setDelegate:self];
	[dogeImg addGestureRecognizer:panGestureRecognizer];
	
	UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(handlePinch:)];
	[pinchGestureRecognizer setDelegate:self];
	[dogeImg addGestureRecognizer:pinchGestureRecognizer];
	
	UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(handleRotate:)];
	[rotationGestureRecognizer setDelegate:self];
	[dogeImg addGestureRecognizer:rotationGestureRecognizer];

	UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
	[contentView addGestureRecognizer:tapGestureRecognizer];
	
	// BottomView
	UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, 320, 50)];
	[bottomView setBackgroundColor:[UIColor clearColor]];
	[self.view addSubview:bottomView];
	
	UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
//	[backBtn setBackgroundColor:[UIColor redColor]];
	[backBtn setImage:[UIImage imageNamed:@"crossIcon.png"] forState:UIControlStateNormal];
	[backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
	[bottomView addSubview:backBtn];
	
	UIButton *doneBtn = [[UIButton alloc]initWithFrame:CGRectMake(270, 0, 50, 50)];
//	[doneBtn setBackgroundColor:[UIColor greenColor]];
	[doneBtn setImage:[UIImage imageNamed:@"checkIcon.png"] forState:UIControlStateNormal];
	[doneBtn addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
	[bottomView addSubview:doneBtn];
	
//	suchArray = [[NSArray alloc] initWithObjects:@"wow",@"such app",@"so innovate",@"wow",@"wow",@"doge",@"amaze",@"such doge", @"much work", nil];
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
		[self addNewTextFieldWithCenter:CGPointMake([tap locationInView:self.view].x, [tap locationInView:self.view].y)];
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
	[self.view addSubview:suchTextField];
	
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

- (UIStatusBarStyle)preferredStatusBarStyle
{
	return UIStatusBarStyleLightContent;
}

#pragma mark - Animate Text

- (void)animateText{
    
    int randomX = (arc4random()%(280-1))+1;
    int randomY = (arc4random()%(560-340))+340;
    int randomIndex = arc4random()%suchArray.count;
    int randomSize = (arc4random()%(25-12))+12;
    int randomScale = ((arc4random()%(15-10))+10)/10;
    
    UILabel *aLabel = [[UILabel alloc] initWithFrame:CGRectMake(randomX, randomY, 100, 34)];
    [aLabel setText:[suchArray objectAtIndex:randomIndex]];
    [aLabel setTextColor:[UIColor colorWithRed:(arc4random()%255)/255.0 green:(arc4random()%255)/255.0 blue:(arc4random()%255)/255.0 alpha:1]];
    [aLabel setFont:[UIFont fontWithName:@"Comic Sans MS" size:randomSize]];
    [aLabel sizeToFit];
    [self.view addSubview:aLabel];
    CGRect rect = aLabel.frame;
    rect.origin.x = randomY + 40;
    
    int randomDelay = (arc4random()%(4-1))+1;
    
    [UIView animateWithDuration:0.0f delay:randomDelay options:UIViewAnimationOptionCurveEaseOut animations:^{
    }completion:^(BOOL finished){
        [UIView animateWithDuration:1.4f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [aLabel setFrame:rect];
            [aLabel setAlpha:0];
            aLabel.transform = CGAffineTransformMakeScale(randomScale, randomScale);
        }completion:^(BOOL finished){
            [aLabel removeFromSuperview];
        }];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
