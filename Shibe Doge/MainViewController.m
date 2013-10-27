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
    NSArray *normalDogeArray;
    
    NSTimer *animateTimer;
    
    UIImagePickerController *imagePicker;
    
    NSUserDefaults *defaults;
    
    UIView *dogeView;
    UILabel *theDogeTitle;
    UIImageView *theBackground;
    UIScrollView *dogeScrollView;
    UIImageView *theDoge;
    UIImageView *theDoge2;
    UIImageView *theDoge3;
    UIImageView *theDoge4;
    UIView *pageDogeBackground;
    UIPageControl *pageDoge;
    UIButton *nextDoge;
    UIButton *previousDoge;
    UIButton *doneButton;
    UIButton *cancelButton;
    
    int whatDoge;
}

@end

@implementation MainViewController

- (void)viewDidLoad
{
    defaults = [NSUserDefaults standardUserDefaults];
    whatDoge = 0;
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [self initViews];
    [self initDogeView];
    
    animateTimer = [NSTimer scheduledTimerWithTimeInterval:0.6 target:self selector:@selector(animateText) userInfo:nil repeats:YES];
    suchArray = [[NSArray alloc] initWithObjects:@"wow",@"clap",@"such app",@"so innovate",@"wow",@"wow",@"doge",@"amaze",@"such doge",@"much work", nil];
    normalDogeArray = [[NSArray alloc] initWithObjects:@"pick me",@"such smile",@"clap",@"so nice", @"pick me", nil];
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
    
    theDogeTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 320, 60)];
    [theDogeTitle setText:@"Pick Doge"];
    [theDogeTitle setBackgroundColor:[UIColor clearColor]];
    [theDogeTitle setTextColor:[UIColor magentaColor]];
    [theDogeTitle setTextAlignment:NSTextAlignmentCenter];
    [theDogeTitle setFont:[UIFont fontWithName:@"Comic Sans MS" size:30]];
    [dogeView addSubview:theDogeTitle];
    
    dogeScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 80, 320, 320)];
    [dogeScrollView setContentSize:CGSizeMake(320*4, 320)];
    [dogeScrollView setPagingEnabled:YES];
    dogeScrollView.delegate = self;
    [dogeScrollView setBackgroundColor:[UIColor clearColor]];
    [dogeScrollView setShowsHorizontalScrollIndicator:NO];
    [dogeView addSubview:dogeScrollView];
    
    theDoge = [[UIImageView alloc] initWithFrame:CGRectMake(60, 50, 200, 200)];
    [theDoge setImage:[UIImage imageNamed:@"shibeNormal.png"]];
    [dogeScrollView addSubview:theDoge];
    
    theDoge2 = [[UIImageView alloc] initWithFrame:CGRectMake(60+320, 50, 200, 200)];
    [theDoge2 setImage:[UIImage imageNamed:@"shibeNormal.png"]];
    [dogeScrollView addSubview:theDoge2];
    
    theDoge3 = [[UIImageView alloc] initWithFrame:CGRectMake(60+640, 50, 200, 200)];
    [theDoge3 setImage:[UIImage imageNamed:@"shibeNormal.png"]];
    [dogeScrollView addSubview:theDoge3];
    
    theDoge4 = [[UIImageView alloc] initWithFrame:CGRectMake(60+960, 50, 200, 200)];
    [theDoge4 setImage:[UIImage imageNamed:@"shibeNormal.png"]];
    [dogeScrollView addSubview:theDoge4];
    
    theBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 80, 320, 320)];
    [theBackground setImage:[UIImage imageNamed:@"frame.png"]];
    [dogeView addSubview:theBackground];
    
    pageDogeBackground = [[UIView alloc] initWithFrame:CGRectMake(dogeView.center.x-50, dogeView.center.y+5 + (theDoge.frame.size.height/2), 100, 20)];
    [pageDogeBackground setBackgroundColor:[UIColor blackColor]];
    [pageDogeBackground setAlpha:0.465];
    [dogeView addSubview:pageDogeBackground];
    
    pageDoge = [[UIPageControl alloc] init];
    [pageDoge setNumberOfPages:4];
    [pageDoge setCurrentPage:0];
    [pageDoge setCenter:pageDogeBackground.center],
    [dogeView addSubview:pageDoge];
    
    
    doneButton = [[UIButton alloc] initWithFrame:CGRectMake(170, self.view.frame.size.height-64, 130, 44)];
    [doneButton setTitle:@"Next" forState:UIControlStateNormal];
    [[doneButton titleLabel] setFont:[UIFont fontWithName:@"Comic Sans MS" size:16]];
    [doneButton addTarget:self action:@selector(goToNextPage) forControlEvents:UIControlEventTouchUpInside];
    [doneButton setBackgroundColor:[UIColor magentaColor]];
    [dogeView addSubview:doneButton];
    
    cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(20, self.view.frame.size.height-64, 130, 44)];
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [[cancelButton titleLabel] setFont:[UIFont fontWithName:@"Comic Sans MS" size:16]];
    [cancelButton addTarget:self action:@selector(dismissDogeView) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton setBackgroundColor:[UIColor magentaColor]];
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
    int randomSize = (arc4random()%(25-12))+12;
    int randomScale = ((arc4random()%(15-10))+10)/10;
    
    UILabel *aLabel = [[UILabel alloc] initWithFrame:CGRectMake(randomX, randomY, 100, 34)];
    [aLabel setTextColor:[UIColor colorWithRed:(arc4random()%255)/255.0 green:(arc4random()%255)/255.0 blue:(arc4random()%255)/255.0 alpha:1]];
    [aLabel setFont:[UIFont fontWithName:@"Comic Sans MS" size:randomSize]];
    switch (whatDoge) {
        case 0:
            [aLabel setText:[suchArray objectAtIndex:arc4random()%suchArray.count]];
            break;
        case 1:
            [aLabel setText:[normalDogeArray objectAtIndex:arc4random()%normalDogeArray.count]];
            break;
        default:
            break;
    }
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
    }completion:^(BOOL finished){
        [pageDoge setFrame:CGRectMake(dogeView.center.x-50, dogeView.center.y+20 + (theDoge.frame.size.height/2), pageDoge.frame.size.width, pageDoge.frame.size.height)];
        [pageDogeBackground setFrame:CGRectMake(dogeView.center.x-50, dogeView.center.y+20 + (theDoge.frame.size.height/2), 100, 20)];
        [pageDoge setCenter:pageDogeBackground.center];
    }];
    whatDoge = 1;
}

- (void)goToNextPage{
    switch (pageDoge.currentPage) {
        case 0:
            [defaults setObject:UIImagePNGRepresentation(theDoge.image) forKey:@"doge"];
            break;
        case 1:
            [defaults setObject:UIImagePNGRepresentation(theDoge2.image) forKey:@"doge"];
            break;
        case 2:
            [defaults setObject:UIImagePNGRepresentation(theDoge3.image) forKey:@"doge"];
            break;
        case 3:
            [defaults setObject:UIImagePNGRepresentation(theDoge4.image) forKey:@"doge"];
            break;
        default:
            break;
    }
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x >= 960) {
        [pageDoge setCurrentPage:3];
    }
    else if (scrollView.contentOffset.x >= 640) {
        [pageDoge setCurrentPage:2];
    }
    else if (scrollView.contentOffset.x >= 320) {
        [pageDoge setCurrentPage:1];
    }
    else if (scrollView.contentOffset.x >= 0) {
        [pageDoge setCurrentPage:0];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
