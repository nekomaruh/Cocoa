//
//  LinearRegression.c
//  NM_1
//
//  Created by Johan Esteban Ordenes Galleguillos on 07-11-19.
//  Copyright © 2019 Johan Esteban Ordenes Galleguillos. All rights reserved.
//

#include "LinearRegression.h"
#include <Stdlib.h>

// Here goes the Linear Regression algorithm in C code

int n;
float dataX[255];
float dataY[255];
float avg;

float sumX;
float sumX2;
float sumY;
float sumXY;
float a;
float b;


int readFile(const char *path){
    FILE *fp;
    char line[255];
    
    fp = fopen(path, "r");
    if (fp == NULL){
        printf("Could not open file %s",path);
        return 0;
    }
    
    int numValues = 0;
    
    while (fgets(line, sizeof(line), fp) != NULL){
        const char* val1 = strtok(line, ",");
        const char* val2 = strtok(NULL, ",");
        
        int a = atof(val1);
        int b = atof(val2);
        dataX[numValues] = atof(val1);
        dataY[numValues] = atof(val2);
        numValues++;
    }
    n = numValues;
    
    for(int i=0; i<n; i++){
        printf("%f, ", dataX[i]);
        printf("%f\n", dataY[i]);
    }
    printf("%d", n);
        
    fclose(fp);
    return 1;
}

int checkNumber(const char* s){
    char *endptr;
    int errno = 0;
    float f = strtof(s, &endptr);
    if (s == endptr)  {
      return 0;
    }
    while (isspace((unsigned char) *endptr)) {  // look past the number for junk
      endptr++;
    }
    if (*endptr) {
      return 0;
    }

    // If desired
    // Special cases with with underflow not considered here.
    if (errno) {
      return 0; // likely under/overflow
    }

    return 1;
}

/*
bool checkNumber(char c){
    char digits[] = {'1','2','3','4','5','6','7','8','9','0',','};
    for(int i=0; i<sizeof(digits); i++){

    }
}
*/

void runAlgorithm(){
    /* Calculating Required Sum */
    sumX = 0;
    sumX2 = 0;
    sumY = 0;
    sumXY = 0;
    a = 0;
    b = 0;
    avg = 0;
    
    for(int i=0;i<n;i++){
        sumX = sumX + dataX[i];
        sumX2 = sumX2 + dataX[i]*dataX[i];
        sumY = sumY + dataY[i];
        sumXY = sumXY + dataX[i]*dataY[i];
    }
    
    /* Calculating a and b */
    b = (n*sumXY-sumX*sumY)/(n*sumX2-sumX*sumX);
    a = (sumY - b*sumX)/n;
    
    avg = sumY*n;
}
