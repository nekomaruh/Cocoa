//
//  LinearRegression.h
//  NM_1
//
//  Created by Johan Esteban Ordenes Galleguillos on 07-11-19.
//  Copyright © 2019 Johan Esteban Ordenes Galleguillos. All rights reserved.
//

#ifndef LinearRegression_h
#define LinearRegression_h

#include <stdio.h>

extern void runAlgorithm(void);
extern int checkNumber(const char *str);
extern int readFile(const char *path);

extern int n;
extern float avg;
extern float dataX[255];
extern float dataY[255];

extern float sumX;
extern float sumX2;
extern float sumY;
extern float sumXY;
extern float a;
extern float b;

#endif /* LinearRegression_h */
