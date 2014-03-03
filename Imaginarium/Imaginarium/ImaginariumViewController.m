//
//  ImaginariumViewController.m
//  Imaginarium
//
//  Created by Charles Feng on 3/2/14.
//  Copyright (c) 2014 Charles Feng. All rights reserved.
//

#import "ImaginariumViewController.h"
#import "ImageViewController.h"

@interface ImaginariumViewController ()

@end

@implementation ImaginariumViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[ImageViewController class]]) {
        ImageViewController *ivc = (ImageViewController *)segue.destinationViewController;
        ivc.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://images.apple.com/v/iphone-5s/gallery/a/images/download/%@.jpg", segue.identifier]];
        ivc.title = segue.identifier;
    }
}

@end
