//
//  objectFile.h
//  NM_1
//
//  Created by Johan Esteban Ordenes Galleguillos on 07-11-19.
//  Copyright © 2019 Johan Esteban Ordenes Galleguillos. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GraphBridge : NSObject{}

-(void)method;

+ (GraphBridge *)sharedSingleton;

@property(nonatomic) int n;
@property(nonatomic) float avg;
@property(nonatomic) float* dataX;
@property(nonatomic) float* dataY;
@property(nonatomic) float a;
@property(nonatomic) float b;
@property(nonatomic) bool isFileLoaded;

@end

NS_ASSUME_NONNULL_END
