//
//  ViewController.m
//  AbraArcReactor
//
//  Created by Rob Enriquez on 10/28/15.
//  Copyright © 2015 Rob Enriquez. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Glow.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *unibeamImageView;

@property (strong, nonatomic) AVAudioPlayer *audioPlayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"fra,e = %g, %g, %g, %g", self.imageView.frame.origin.x, self.imageView.frame.origin.y, self.imageView.frame.size.width, self.imageView.frame.size.height);

    CGRect window = [UIScreen mainScreen].bounds;

    self.imageView.frame = CGRectMake(0, 0, window.size.width, window.size.height);

    [self.imageView startGlowing];

    [self setupAVPlayer];

}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)setupAVPlayer {

    // Construct URL to sound file
    NSString *path = [NSString stringWithFormat:@"%@/repulsor.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];

    // Create audio player object and initialize with URL to sound
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
}

#pragma mark - IBActions

- (IBAction)uniBeamButtonTapped:(UIButton *)sender {

    [self fireUnibeam];

    double delayInSeconds2 = 1.5f;
    dispatch_time_t popTime2 = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds2 * NSEC_PER_SEC);
    dispatch_after(popTime2, dispatch_get_main_queue(), ^(void){

        [self fadeOut];

        [self.imageView stopAnimating];
        [self.imageView stopGlowing];

        [self.imageView startGlowing];

    });

}

- (void)fireUnibeam {
    [self.audioPlayer play];

    [self.imageView stopAnimating];
    [self.imageView stopGlowing];

    [self.imageView startGlowingWithColor:[UIColor whiteColor] intensity:15];

    self.unibeamImageView.hidden = NO;
    [self fadeIn];

    [self.unibeamImageView glowOnce];

}

- (void)fadeOut {
    UIImageView *Image = self.unibeamImageView;

    Image.hidden = NO;
    [UIView animateWithDuration:0.5 delay:1.0 options: UIViewAnimationOptionCurveEaseOut animations:^ {Image.alpha = 0;}
                     completion:^(BOOL finished){Image.hidden = YES;}];
}

- (void)fadeIn {
    UIImageView *Image = self.unibeamImageView;

    Image.hidden = YES;
    [UIView animateWithDuration:0.5 delay:0.5 options: UIViewAnimationOptionCurveEaseIn animations:^ {Image.alpha = 1;}
                     completion:^(BOOL finished){Image.hidden = NO;}];
}


@end
