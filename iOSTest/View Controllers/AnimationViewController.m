//
//  AnimationViewController.m
//  iOSTest
//
//  Created by App Partner on 12/13/16.
//  Copyright © 2016 AppPartner. All rights reserved.
//

#import "AnimationViewController.h"
#import "MenuViewController.h"

@interface AnimationViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UIImageView *image;



    


@end

@implementation AnimationViewController

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make the UI look like it does in the mock-up.
 *
 * 2) Logo should spin when the user hits the spin button
 *
 * 3) User should be able to drag the logo around the screen with his/her fingers
 *
 * 4) Add a bonus to make yourself stick out. Music, color, fireworks, explosions!!! Have Swift experience? Why not write the Animation 
 *    section in Swfit to show off your skills. Anything your heart desires!
 *
 **/

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Animation";
    self.navigationController.navigationBar.backItem.title = @"Back";

    [self addEntranceAnimationToLayer:self.logoImage.layer
                            withDelay:0.5];
    [self addEntranceAnimationToLayer:self.bgImage.layer
                            withDelay:0.7];
    
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
    emitterLayer.emitterPosition = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.origin.y);
    emitterLayer.emitterZPosition = 10.0;
    emitterLayer.emitterSize = CGSizeMake(self.view.bounds.size.width, 0.0);
    emitterLayer.emitterShape = kCAEmitterLayerSphere;
    
    CAEmitterCell *emitterCell = [CAEmitterCell emitterCell];
    
    emitterCell.scale = 0.4;
    emitterCell.scaleRange = 0.6;
    emitterCell.emissionRange = (CGFloat)M_PI;
    emitterCell.lifetime = 10.0;
    emitterCell.birthRate = 10.0;
    emitterCell.velocity = 100.0;
    emitterCell.velocityRange = 100.0;
    emitterCell.yAcceleration = 300.0;
    
    emitterCell.contents = (id)[[UIImage imageNamed:@"A.png"] CGImage];
    
    CAEmitterCell *emitterCell2 = [CAEmitterCell emitterCell];
    emitterCell2.scale = 0.4;
    emitterCell2.scaleRange = 0.6;
    emitterCell2.emissionRange = (CGFloat)M_PI;
    emitterCell2.lifetime = 10.0;
    emitterCell2.birthRate = 10.0;
    emitterCell2.velocity = 100.0;
    emitterCell2.velocityRange = 100.0;
    emitterCell2.yAcceleration = 300.0;
    emitterCell2.contents = (id)[[UIImage imageNamed:@"P.png"] CGImage];
    
    emitterLayer.emitterCells = @[emitterCell, emitterCell2];
    [self.view.layer addSublayer:emitterLayer];

    
}

- (IBAction)backAction:(id)sender
{
    MenuViewController *mainMenuViewController = [[MenuViewController alloc] init];
    [self.navigationController pushViewController:mainMenuViewController animated:YES];
}

# pragma - SpinAction

- (IBAction)didPressSpinButton:(id)sender
{
    CABasicAnimation* rotateAction;
    rotateAction = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAction.toValue = [NSNumber numberWithFloat: M_PI * 2];
    rotateAction.duration = 1.0;
    rotateAction.repeatCount = 1;
    [self.logoImage.layer addAnimation:rotateAction forKey:@"rotationAnimation"];
}

# pragma - EntranceAnimation

- (void) addEntranceAnimationToLayer:(CALayer *)aLayer withDelay:(CGFloat)aDelay {
    CAKeyframeAnimation *trans = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    
    NSArray *values = @[@(-300),@(30),@(0)];
    trans.values = values;
    
    NSArray *times = @[@(0.0),@(0.85),@(1)];
    trans.keyTimes = times;
    trans.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    trans.duration = 0.8;
    trans.removedOnCompletion = NO;
    trans.fillMode = kCAFillModeBackwards;
    trans.beginTime = CACurrentMediaTime()+aDelay;
    [aLayer addAnimation:trans forKey:@"entrance"];
    
}

# pragma - TouchesMoved

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if ([touch view] == self.logoImage)
    {
        CGPoint touchPosition = [touch locationInView:touch.window];
        CGRect oldFrame = self.logoImage.frame;
        
        CGRect newFrame = CGRectMake(touchPosition.x - oldFrame.size.width/2, touchPosition.y -oldFrame.size.height/2, oldFrame.size.width, oldFrame.size.height);
        self.logoImage.frame = newFrame;
    }
}



@end
