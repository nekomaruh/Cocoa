//
//  ViewController.h
//  NM_1
//
//  Created by Johan Esteban Ordenes Galleguillos on 10/2/19.
//  Copyright © 2019 Johan Esteban Ordenes Galleguillos. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController

@property (strong) IBOutlet NSScrollView *fileView;
@property (strong) IBOutlet NSTextView *fileText;
@property (strong) IBOutlet NSScrollView *resultsView;
@property (strong) IBOutlet NSTextView *resultsText;

- (IBAction)btnLoadFile:(id)sender;
- (IBAction)btnCalculate:(id)sender;

@property (strong) IBOutlet NSTextField *path;
@property bool pathIsSelected;
@property (strong) IBOutlet NSButtonCell *btnCalculateX;

@end

