//
//  BullsEyeViewController.m
//  BullsEye
//
//  Created by yiye on 14-4-9.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "BullsEyeViewController.h"
#import "aboutViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface BullsEyeViewController ()
{
    int currentValue;
    int targetValue;
    int score;
    int round;
}

- (IBAction)showAlert:(UIButton*)sender;
@property (strong, nonatomic) IBOutlet UISlider *slider;

@property (strong, nonatomic) IBOutlet UILabel *targetLabel;

@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;

@property (strong, nonatomic) IBOutlet UILabel *roundLabel;

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

- (IBAction)sliderMoved:(UISlider*)sender;

- (IBAction)startOver:(id)sender;

- (IBAction)showInfo:(id)sender;

@end





@implementation BullsEyeViewController

@synthesize audioPlayer;


- (void)playBackgroundMusic{

    NSString *musicPatch = [[NSBundle mainBundle]pathForResource:@"no" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:musicPatch];
    NSError *error;
    
    audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    audioPlayer.numberOfLoops = -1;
    if(audioPlayer == nil){
        NSString *errorInfo = [NSString stringWithString:[error description]];
        NSLog(@"the error is:%@",errorInfo);
    }else{
        [audioPlayer play];
    }
}


/*- (void)playStartOverMusic{
    
    NSString *musicPatch = [[NSBundle mainBundle]pathForResource:@"no1" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:musicPatch];
    NSError *error;
    
    audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    audioPlayer.numberOfLoops = -1;
    if(audioPlayer == nil){
        NSString *errorInfo = [NSString stringWithString:[error description]];
        NSLog(@"the error is:%@",errorInfo);
    }else{
        [audioPlayer play];
    }
    
}*/


/*- (void)playShowInfoMusic{
    
    NSString *musicPatch = [[NSBundle mainBundle]pathForResource:@"no2" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:musicPatch];
    NSError *error;
    
    audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    audioPlayer.numberOfLoops = -1;
    if(audioPlayer == nil){
        NSString *errorInfo = [NSString stringWithString:[error description]];
        NSLog(@"the error is:%@",errorInfo);
    }else{
        [audioPlayer play];
       
    }
    
}*/




@synthesize slider;
@synthesize targetLabel;
@synthesize scoreLabel;
@synthesize roundLabel;

- (void)startNewRound{
    round += 1;
    targetValue = 1 + (arc4random()%100);
    currentValue = 50;
    self.slider.value = currentValue;

}

- (void)startNewGame{
    score = 0;
    round = 0;
    [self startNewRound];
}

-(void)updateLabel{

    self.targetLabel.text = [NSString stringWithFormat:@"%d",targetValue];
    self.scoreLabel.text = [NSString stringWithFormat:@"%d",score];
    self.roundLabel.text = [NSString stringWithFormat:@"%d",round];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	//currentValue = self.slider.value;
    //targetValue = 1+ (arc4random() % 100);
    [self startNewGame];
    [self updateLabel];
    //[self playBackgroundMusic];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)showAlert:(UIButton *)sender{

    int difference;
    difference = abs(targetValue - currentValue);
    int point = 100 - difference;
    score += point;
    
    NSString *title;
    
    if (difference == 0) {
        title = @"土豪！你太特么NB惹";
        score += 100;
    }else if (difference < 5){

        if (difference == 1) {
            point += 50;
        }
        title = @"土豪太棒惹，但是还差一点";
       
    }else if (difference < 10){
        title = @"好吧，勉强算个土鳖";
        
    }else{
        title = @"口亨！不是土豪少来找我";
    }
    //if (difference<0) {
      //  difference = difference * -1;
    //}
    //if(currentValue > targetValue){
      //  difference = currentValue - targetValue;
    //}else if(targetValue > currentValue){
      //  difference = targetValue - currentValue;
    //}else{
      //  difference = 0;
    //}
    
    
    NSString *message = [NSString stringWithFormat:@"The value of the slider is :%d\n The target value is :%d\n 恭喜高富帅您得分是:%d", currentValue,targetValue, point];
    [[[UIAlertView alloc]initWithTitle:title            //@"您好，一叶土豪"
                         message:message
                        delegate:self
               cancelButtonTitle:@"朕知道了，爱卿退下吧"
               otherButtonTitles:nil,nil]show];
 //[self startNewRound];
 //[self updateLabel];
}

- (IBAction)sliderMoved:(UISlider*)sender {

    currentValue = (int)lround(sender.value);
}

- (IBAction)statOver:(id)sender {
}


 - (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:
(NSInteger)buttonIndex{
    [self startNewRound];
    [self updateLabel];
}

- (IBAction)startOver:(id)sender{
    
  
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    transition.duration = 0.7;
    transition.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut];
    [self startNewGame];
    [self updateLabel];
    [self.view.layer addAnimation:transition forKey:nil];
    

}



- (IBAction)showInfo:(id)sender {
    
        aboutViewController*controller =[[aboutViewController alloc]initWithNibName:@"aboutViewController" bundle:nil];
    controller.modalTransitionStyle =UIModalTransitionStylePartialCurl;
    [self presentViewController: controller animated:YES completion:nil];
    
    
}


@end
