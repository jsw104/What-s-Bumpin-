//
//  LocationGraphViewController.m
//  WhatsBumpin
//
//  Created by Justin Wang on 3/20/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//
#import "Location.h"
//#import "CorePlot.h"

@interface LocationGraphViewController: UIViewController

@property (strong, nonatomic) Location *location;

@end

@implementation LocationGraphViewController

UIView *graphView;
NSArray *xVals;
NSMutableArray *yVals;
UIActivityIndicatorView *activity;


-(void)viewDidLoad{
    [super viewDidLoad];
    
    //create view
    graphView = [[UIView alloc] initWithFrame:CGRectMake(15, self.navigationController.navigationBar.frame.size.height + 30, self.view.bounds.size.width - 30, 300)];
    graphView.layer.cornerRadius = 15;
    graphView.layer.masksToBounds = YES;
    
    //set border
    graphView.layer.borderColor = [UIColor colorWithRed:251/255.0 green:10/255.0 blue:95/255.0 alpha:1].CGColor;
    graphView.layer.borderWidth = 3.0f;
    
    //add graphView to view
    [self.view addSubview:graphView];
    
    //create activity
    activity = [[UIActivityIndicatorView alloc] initWithFrame:graphView.bounds];
    [activity setBackgroundColor:[UIColor clearColor]];
    [activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [graphView addSubview:activity];
    [activity setHidesWhenStopped:true];
    [activity startAnimating];
    //load data
    [self loadBumpsPerDayWithCompletion:^(NSMutableArray *yVals) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *titleString = [NSString stringWithFormat:@"Bumps Per Day At %@",self.location.name];
            UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, graphView.bounds.size.width, 20)];
            title.text = titleString;
            title.numberOfLines = 0;
            title.textColor = [UIColor colorWithRed:14/255.0 green:201/255.0 blue:39/255.0 alpha:1];
            title.textAlignment = NSTextAlignmentCenter;
            [graphView addSubview:title];
            
            //add y-axis labels
            [self addYAxisLabels:4 withLabels:yVals];
            
            //draw bars
            [self drawBars:7 withValues:yVals];
            
            //set xVals
            xVals = [NSArray arrayWithObjects:@"Sun",@"Mon", @"Tue", @"Wed", @"Thu", @"Fri", @"Sat", nil];
            
            //add x-axis labels
            [self addXAxisLabels:7 withLabels:xVals];
            
            //draw x-axis
            [self drawXAxis];
            
            //draw y-axis
            [self drawYAxisWithTitle:title];
            
            [activity stopAnimating];
        });
        //add title
        
        
    }];
    //set yVals
    //yVals = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:40],[NSNumber numberWithInt:15],[NSNumber numberWithInt:3],[NSNumber numberWithInt:7],[NSNumber numberWithInt:16],[NSNumber numberWithInt:12],[NSNumber numberWithInt:9], nil];
    
}

- (void)drawYAxisWithTitle:(UILabel *)title {
    UIBezierPath *yAxis = [UIBezierPath bezierPath];
    [yAxis moveToPoint: CGPointMake(30, graphView.bounds.size.height - 30)];
    [yAxis addLineToPoint: CGPointMake(30, 30 + title.bounds.size.height)];
    CAShapeLayer *yAxisLayer = [CAShapeLayer layer];
    yAxisLayer.path = [yAxis CGPath];
    yAxisLayer.strokeColor = [[UIColor blueColor] CGColor];
    yAxisLayer.lineWidth = 3.0;
    yAxisLayer.fillColor = [[UIColor clearColor] CGColor];
    [graphView.layer addSublayer:yAxisLayer];
}

- (void)drawXAxis {
    UIBezierPath *xAxis = [UIBezierPath bezierPath];
    [xAxis moveToPoint: CGPointMake(30, graphView.bounds.size.height - 30)];
    [xAxis addLineToPoint: CGPointMake(graphView.bounds.size.width - 30, graphView.bounds.size.height - 30)];
    CAShapeLayer *xAxisLayer = [CAShapeLayer layer];
    xAxisLayer.path = [xAxis CGPath];
    xAxisLayer.strokeColor = [[UIColor blueColor] CGColor];
    xAxisLayer.lineWidth = 3.0;
    xAxisLayer.fillColor = [[UIColor clearColor] CGColor];
    [graphView.layer addSublayer:xAxisLayer];
}

- (void)addXAxisLabels:(int)numLabels withLabels: (NSArray *)labels{
    CGFloat increment = (graphView.bounds.size.width - 60) / numLabels;
    int x = 30;
    int y = graphView.bounds.size.height - 20;
    int height = 15;
    int width = increment;
    for (int i = 0; i < numLabels; i++){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        label.text = labels[i];
        label.textColor = [UIColor colorWithRed:14/255.0 green:201/255.0 blue:39/255.0 alpha:1];
        label.textAlignment = NSTextAlignmentCenter;
        [label.font fontWithSize:5];
        [graphView addSubview:label];
        x += increment;
    }
    
}

- (void)drawLineFromX:(int)x1 andY:(int)y1 toX:(int)x2 andY:(int)y2{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint: CGPointMake(x1, y1)];
    [path addLineToPoint: CGPointMake(x2, y2)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [path CGPath];
    shapeLayer.strokeColor = [[UIColor blueColor] CGColor];
    shapeLayer.lineWidth = 1.0;
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    [graphView.layer addSublayer:shapeLayer];
}

- (int)findMaxValue:(NSMutableArray *)array{
    int maxValue = 0;
    for (int i = 0; i < [array count]; i++){
        if ([[array objectAtIndex:i] integerValue] > maxValue){
            maxValue = [[array objectAtIndex:i] intValue];
        }
    }
    return maxValue;
}

-(int)findUpperBound:(int) maxValue{
    int upperBound = 20;
    bool foundUpperBound = false;
    while(!foundUpperBound){
        if(maxValue <= upperBound){
            foundUpperBound = true;
        }else{
            upperBound += 20;
        }
    }
    return upperBound;
}

- (void)addYAxisLabels:(int)numLabels withLabels: (NSMutableArray *)labels{
    
    //find max yVal
    int maxValue = [self findMaxValue:labels];

    //find upper bound for yVals
    int upperBound = [self findUpperBound:maxValue];
    
    CGFloat increment = (graphView.bounds.size.height - 80) / numLabels;
    int labInc = upperBound / numLabels;
    int labVal = upperBound;
    int x = 5;
    int y = 50;
    int height = 25;
    int width = 25;
    for (int i = 0; i < numLabels; i++){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        label.text = [NSString stringWithFormat:@"%d",labVal];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithRed:14/255.0 green:201/255.0 blue:39/255.0 alpha:1];
        [label.font fontWithSize:5];
        [graphView addSubview:label];
        [self drawLineFromX:30 andY:y toX:graphView.bounds.size.width - 30 andY:y];
        y += increment;
        labVal = labVal - labInc;
    }
    
}

- (void)drawBars:(int) numBars withValues:(NSMutableArray *)barVals{
    
    //find max yVal
    int maxValue = [self findMaxValue:barVals];
    //find upperBound
    int upperBound = [self findUpperBound:maxValue];
    double bumpHeight = (graphView.bounds.size.height - 80)/upperBound;
    CGFloat barWidth = (graphView.bounds.size.width - 60) / numBars;
    double x = 30;
    double y = graphView.bounds.size.height - 30;
    double height = bumpHeight;
    double width = barWidth;
    for(int i = 0; i < numBars; i++){
        UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(x + 5, y, width - 5, -(height * [[barVals objectAtIndex:i] integerValue]))];
        barView.backgroundColor = [UIColor colorWithRed:251/255.0 green:10/255.0 blue:95/255.0 alpha:1];
        barView.layer.cornerRadius = 5;
        barView.layer.masksToBounds = YES;
        UILabel *barLabel = [[UILabel alloc] initWithFrame:barView.bounds];
        barLabel.text = [NSString stringWithFormat:@"%ld",(long)[[barVals objectAtIndex:i] integerValue]];
        barLabel.textColor = [UIColor blueColor];
        barLabel.textAlignment = NSTextAlignmentCenter;
        [barView addSubview:barLabel];
        [graphView addSubview:barView];
        x += barWidth;
    }
    
}

- (CGFloat)widthOfString:(NSString *)string withFont:(NSFont *)font {
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    return [[[NSAttributedString alloc] initWithString:string attributes:attributes] size].width;
}


-(void)loadBumpsPerDayWithCompletion: (void(^)(NSMutableArray* response))completion {
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://52.14.0.153/api/get_bumps_by_location_and_day_of_week.php"]];
    [request setHTTPMethod:@"POST"];
    
    NSString *post = [[NSString alloc] initWithFormat:@"location_id=%@&submit=", _location.googlePlacesID]; ///change string to location_id; hardcoded for Jolly
    [request setHTTPBody:[post dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest: request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"data: %@", dataString);
        
        NSArray *components = [dataString componentsSeparatedByString:@","];
        NSString *monday = [components[1] substringFromIndex:[components[1] length] -1];
        NSString *tuesday = [components[2] substringFromIndex:[components[2] length] -1];
        NSString *wednesday = [components[3] substringFromIndex:[components[3] length] -1];
        NSString *thursday = [components[4] substringFromIndex:[components[4] length] -1];
        NSString *friday = [components[5] substringFromIndex:[components[5] length] -1];
        NSString *saturday = [components[6] substringFromIndex:[components[6] length] -1];
        NSString *sunday = [components[7] substringFromIndex:[components[7] length] -1];
        yVals = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:[monday intValue]], [NSNumber numberWithInt:[tuesday intValue]], [NSNumber numberWithInt:[wednesday intValue]], [NSNumber numberWithInt:[thursday intValue]], [NSNumber numberWithInt:[friday intValue]], [NSNumber numberWithInt:[saturday intValue]], [NSNumber numberWithInt:[sunday intValue]], nil];
        completion(yVals);
    }];
    
    
    [task resume];
}

@end
