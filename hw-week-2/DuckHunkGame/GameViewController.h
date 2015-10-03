//
//  GameViewController.h
//  DuckHunkGame
//
//  Created by Diana Elezaj on 8/16/15.
//  Copyright (c) 2015 Diana Elezaj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface GameViewController : UIViewController
{
    AVAudioPlayer *_audioPlayerStartRound;
    AVAudioPlayer *_audioPlayerHit;
    AVAudioPlayer *_audioPlayerTongueRolling;
    AVAudioPlayer *_audioPlayerTwoToneDoorbell;
    AVAudioPlayer *_audioPlayerTelephoneRing;
    AVAudioPlayer *_audioPlayerButtonClickOn;
}
@end
