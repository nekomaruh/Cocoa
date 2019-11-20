//
//  ViewController.m
//  NM_1
//
//  Created by Johan Esteban Ordenes Galleguillos on 10/2/19.
//  Copyright © 2019 Johan Esteban Ordenes Galleguillos. All rights reserved.
//

#import "ViewController.h"
#include "LinearRegression.h"
#include "GraphBridge.h"
#import "NM_1-Swift.h"

@implementation ViewController

@synthesize path;
@synthesize pathIsSelected;
@synthesize fileView;
@synthesize fileText;
@synthesize resultsView;
@synthesize resultsText;
@synthesize btnCalculateX;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [fileView setBorderType:NSBezelBorder];
    //[fileText setTextContainer:@"test"];
    NSFont *font = [NSFont userFontOfSize:15.0];
    [fileText setEditable:false];
    [fileText setFont:font];
    
    [resultsView setBorderType:NSBezelBorder];
    [resultsText setEditable:false];
    [resultsText setFont:font];
    
    [GraphBridge sharedSingleton].isFileLoaded = false;

}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    // Update the view, if already loaded.
}

- (IBAction)btnLoadFile:(id)sender {
    // Create the File Open Dialog class.
    NSOpenPanel *openDlg = [NSOpenPanel openPanel];
    NSArray *fileTypes = [NSArray arrayWithObjects:@"txt",nil];

    // Enable the selection of files in the dialog.
    [openDlg setCanChooseFiles:YES];

    // Multiple files not allowed
    [openDlg setAllowsMultipleSelection:NO];

    // Can't select a directory
    [openDlg setCanChooseDirectories:NO];
    
    // Just select txt files or folders
    [openDlg setAllowedFileTypes:fileTypes];

    // Display the dialog. If the OK button was pressed,
    // process the files.
    if ( [openDlg runModalForDirectory:nil file:nil] == NSOKButton ){
        // Get an array containing the full filenames of all
        // files and directories selected.
        NSArray* files = [openDlg filenames];

        // Loop through all the files and process them.
        NSString* fileName = [files objectAtIndex:0];
        
        NSLog(@"File: %@", fileName);
        path.stringValue = fileName;
        pathIsSelected = true;
        
        // Read the data of the file
        const char *absolutePath = [path.stringValue UTF8String]; // Objective-C path to C path
        
        @try{
            readFile(absolutePath); // C code
        }
        @catch (NSException * e) {
            NSLog(@"Exception: %@", e);
            return;
        }
        btnCalculateX.enabled = YES;
        
        
        
        // Load file into fileView
        [fileText setEditable:true];
        // Reset Values
        [fileText setString:@""];
        for(int i=0; i<n; i++){
            NSString *a = [NSString stringWithFormat:@"%.2f", dataX[i]];
            NSString *b = [NSString stringWithFormat:@"%.2f", dataY[i]];
            NSString *v = [NSString stringWithFormat:@"%d", i];
            NSString *ab = [NSString stringWithFormat:@"X%@ = %@    Y%@ = %@\n", v, a, v, b];
            [fileText insertText:ab];
        }
        [fileText setEditable:false];
        
        [GraphBridge sharedSingleton].n = n;
        [GraphBridge sharedSingleton].dataX = dataX;
        [GraphBridge sharedSingleton].dataY = dataY;
        
        [GraphBridge sharedSingleton].isFileLoaded = true;
        
    }
}




- (IBAction)btnCalculate:(id)sender {
    if(!pathIsSelected){
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:@"File error"];
        [alert setInformativeText:@"Please select a file path to read"];
        [alert addButtonWithTitle:@"Ok"];
        [alert runModal];
    }else{
        // y-y1 = m (x-x1)
        // y = m(x-x1) + y1
        // Run C code //
        runAlgorithm();
        [GraphBridge sharedSingleton].a = a;
        [GraphBridge sharedSingleton].b = b;
        
        NSViewController *vc = [self.storyboard instantiateControllerWithIdentifier:@"SwiftViewController"];
        
        [vc viewDidLoad];
        
        // Run C code //
        
        [resultsText setEditable:true];
        [resultsText setString:@""];
        [resultsText insertText:[NSString stringWithFormat:@"Sum X = %.2f\n", sumX]];
        [resultsText insertText:[NSString stringWithFormat:@"Sum Y = %.2f\n", sumY]];
        [resultsText insertText:[NSString stringWithFormat:@"Sum X*Y = %.2f\n", sumXY]];
        [resultsText insertText:[NSString stringWithFormat:@"Sum X^2 = %.2f\n", sumX2]];
        [resultsText insertText:[NSString stringWithFormat:@"a = %.2f\n", a]];
        [resultsText insertText:[NSString stringWithFormat:@"b = %.2f\n", b]];
        [resultsText setEditable:false];
        
        btnCalculateX.enabled = NO;
    }
    
    
}

@end





