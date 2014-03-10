//
//  URLViewController.m
//  Photomania
//
//  Created by Charles Feng on 3/10/14.
//  Copyright (c) 2014 Charles Feng. All rights reserved.
//

#import "URLViewController.h"

@interface URLViewController ()
@property (strong, nonatomic) IBOutlet UITextView *urlTextView;
@end

@implementation URLViewController

- (void)setUrl:(NSURL *)url
{
    _url = url;
    [self updateUI];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateUI];
}

- (void)updateUI
{
    self.urlTextView.text = [self.url absoluteString];
}

@end
