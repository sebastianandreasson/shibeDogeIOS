//
//  MainViewController.m
//  Shibe Doge
//
//  Created by Sebastian Andreasson on 2013-10-27.
//  Copyright (c) 2013 Sebastian Andreasson Apps. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController (){
    UIImageView *background;
    UIImageView *animatedDoge;
    UILabel *title;
    
    UIButton *photoButton;
    UIButton *libraryButton;
    NSArray *suchArray;
    
    NSTimer *animateTimer;
    
    UIImagePickerController *imagePicker;
    
    NSUserDefaults *defaults;
    
    UIView *dogeView;
    UIImageView *theBackground;
    UIImageView *theDoge;
    UIButton *nextDoge;
    UIButton *previousDoge;
    UIButton *doneButton;
    UIButton *cancelButton;
}

@end

@implementation MainViewController

- (void)viewDidLoad
{
    defaults = [NSUserDefaults standardUserDefaults];
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [self initViews];
    [self initDogeView];
    
    animateTimer = [NSTimer scheduledTimerWithTimeInterval:0.6 target:self selector:@selector(animateText) userInfo:nil repeats:YES];
    suchArray = [[NSArray alloc] initWithObjects:@"wow",@"clap",@"such app",@"so innovate",@"wow",@"wow",@"doge",@"amaze",@"such doge",@"much work", nil];
}

- (void)initViews{
    background = [[UIImageView alloc] initWithFrame:self.view.frame];
    [background setImage:[UIImage imageNamed:@"space.jpg"]];
    [self.view addSubview:background];
    
    title = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 320, 60)];
    [title setText:@"Shibe Doge"];
    [title setBackgroundColor:[UIColor clearColor]];
    [title setTextColor:[UIColor magentaColor]];
    [title setTextAlignment:NSTextAlignmentCenter];
    [title setFont:[UIFont fontWithName:@"Comic Sans MS" size:30]];
    [self.view addSubview:title];
    
    animatedDoge = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 265, 265)];
    [animatedDoge setImage:[UIImage imageNamed:@"shibeNormal.png"]];
    [animatedDoge setCenter:self.view.center];
    [self.view addSubview:animatedDoge];
    
    photoButton = [[UIButton alloc] initWithFrame:CGRectMake(170, self.view.frame.size.height-64, 130, 44)];
    [photoButton setBackgroundColor:[UIColor orangeColor]];
    [photoButton setTitle:@"such photo" forState:UIControlStateNormal];
    [[photoButton titleLabel] setFont:[UIFont fontWithName:@"Comic Sans MS" size:16]];
    [photoButton addTarget:self action:@selector(photoViewTakePhotoButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:photoButton];
    
    libraryButton = [[UIButton alloc] initWithFrame:CGRectMake(20, self.view.frame.size.height-64, 130, 44)];
    [libraryButton setBackgroundColor:[UIColor orangeColor]];
    [[libraryButton titleLabel] setFont:[UIFont fontWithName:@"Comic Sans MS" size:16]];
    [libraryButton setTitle:@"such library" forState:UIControlStateNormal];
    [libraryButton addTarget:self action:@selector(photoViewLibraryButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:libraryButton];
}

- (void)initDogeView{
    dogeView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    [dogeView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:dogeView];
    
    theBackground = [[UIImageView alloc] initWithFrame:self.view.frame];
    [dogeView addSubview:theBackground];
    
    theDoge = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 265, 265)];
    [theDoge setImage:[UIImage imageNamed:@"shibeNormal.png"]];
    [theDoge setCenter:dogeView.center];
    [dogeView addSubview:theDoge];
    
    doneButton = [[UIButton alloc] initWithFrame:CGRectMake(170, self.view.frame.size.height-64, 130, 44)];
    [doneButton setTitle:@"Next" forState:UIControlStateNormal];
    [[doneButton titleLabel] setFont:[UIFont fontWithName:@"Comic Sans MS" size:16]];
    [doneButton addTarget:self action:@selector(goToNextPage) forControlEvents:UIControlEventTouchUpInside];
    [doneButton setBackgroundColor:[UIColor yellowColor]];
    [dogeView addSubview:doneButton];
    
    cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(20, self.view.frame.size.height-64, 130, 44)];
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [[cancelButton titleLabel] setFont:[UIFont fontWithName:@"Comic Sans MS" size:16]];
    [cancelButton addTarget:self action:@selector(dismissDogeView) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton setBackgroundColor:[UIColor yellowColor]];
    [dogeView addSubview:cancelButton];
}

- (void)dismissDogeView{
    [UIView animateWithDuration:0.4f delay:0 options:UIViewAnimationOptionTransitionCurlDown animations:^{
        dogeView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
    }completion:^(BOOL finished){
    }];
    
    
}

- (void)animateText{
    
    int randomX = (arc4random()%(280-1))+1;
    int randomY = (arc4random()%(400-50))+50;
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
    rect.origin.y = randomY - 40;
    
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

- (void)showDogePicker{
    [UIView animateWithDuration:0.4f delay:0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
        dogeView.frame = self.view.frame;
        theDoge.center = self.view.center;
    }completion:^(BOOL finished){
    }];
    [theBackground setImage:[UIImage imageWithData:[defaults objectForKey:@"image"]]];
}

- (void)goToNextPage{
    [defaults setObject:theDoge.image.CIImage forKey:@"doge"];
    [self performSegueWithIdentifier:@"suchSegue" sender:nil];
}


- (void)photoViewTakePhotoButtonPressed{
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)photoViewLibraryButtonPressed{
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSData *libImage = UIImagePNGRepresentation([info objectForKey:UIImagePickerControllerEditedImage]);
    
    [defaults setObject:libImage forKey:@"image"];
    [defaults synchronize];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        [self showDogePicker];
    }];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
