//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Charles Feng on 2/24/14.
//  Copyright (c) 2014 Charles Feng. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

@end