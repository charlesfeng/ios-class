//
//  PlayingCardView.h
//  SuperCard
//
//  Created by Charles Feng on 3/1/14.
//  Copyright (c) 2014 Charles Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) BOOL faceUp;

- (void)pinch:(UIPinchGestureRecognizer *)gesture;

@end
