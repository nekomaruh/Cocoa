//
//  objectFile.m
//  NM_1
//
//  Created by Johan Esteban Ordenes Galleguillos on 07-11-19.
//  Copyright © 2019 Johan Esteban Ordenes Galleguillos. All rights reserved.
//

#import "GraphBridge.h"

@implementation GraphBridge

@synthesize n;
@synthesize a;
@synthesize b;
@synthesize dataX;
@synthesize dataY;
@synthesize avg;
@synthesize isFileLoaded;

+ (GraphBridge *)sharedSingleton{
  static GraphBridge *sharedSingleton;
  @synchronized(self)
  {
    if (!sharedSingleton)
      sharedSingleton = [[GraphBridge alloc] init];

    return sharedSingleton;
  }
}

-(void)method{
    NSLog(@"works!!!");
}

@end
