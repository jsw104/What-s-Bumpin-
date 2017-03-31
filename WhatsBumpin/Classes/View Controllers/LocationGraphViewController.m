//
//  LocationGraphViewController.m
//  WhatsBumpin
//
//  Created by Justin Wang on 3/20/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import "LocationGraphViewController.h"
#import "Charts-swift.h"


NSArray *hours;
NSMutableArray *tuesday;
NSMutableArray *wednesday;
NSString *currentDayOfWeek;
NSMutableArray *dataSets;


@interface LocationGraphViewController()<ChartViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet LineChartView *lineChartView;
@property (weak, nonatomic) IBOutlet UILabel *chart1Title;

@end

@implementation LocationGraphViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //Title
    self.title = self.location.name;
    NSString *title = self.location.name;
    title = [title stringByAppendingString:@" Data Trends"];
    _titleLabel.text = title;
    
    //chart1Title
    currentDayOfWeek = @"Tuesday";
    _chart1Title.text = @"Bumps Per Hour By Day Of Week";
    _chart1Title.textColor = [UIColor redColor];
    
    //Prepare Data
    hours = [NSArray arrayWithObjects:@"2am", @"4am", @"6am", @"8am", @"10am", @"12pm", @"2pm", @"4pm", @"6pm", @"8pm", @"10pm", @"12am", nil];
    //dollars = [NSArray arrayWithObjects: @1453.0, @2352, @5431, @1442, @5451, @6468, @1173, @5678, @9234, @1345, @9411, @2212, nil];

    
    tuesday = [[NSMutableArray alloc] initWithCapacity:0];
    [tuesday addObject:[NSNumber numberWithDouble:100]];
    [tuesday addObject:[NSNumber numberWithDouble:4]];
    [tuesday addObject:[NSNumber numberWithDouble:0]];
    [tuesday addObject:[NSNumber numberWithDouble:1]];
    [tuesday addObject:[NSNumber numberWithDouble:2]];
    [tuesday addObject:[NSNumber numberWithDouble:5]];
    [tuesday addObject:[NSNumber numberWithDouble:10]];
    [tuesday addObject:[NSNumber numberWithDouble:20]];
    [tuesday addObject:[NSNumber numberWithDouble:30]];
    [tuesday addObject:[NSNumber numberWithDouble:50]];
    [tuesday addObject:[NSNumber numberWithDouble:80]];
    [tuesday addObject:[NSNumber numberWithDouble:130]];
    
    wednesday= [[NSMutableArray alloc] initWithCapacity:0];
    [wednesday addObject:[NSNumber numberWithDouble:10]];
    [wednesday addObject:[NSNumber numberWithDouble:40]];
    [wednesday addObject:[NSNumber numberWithDouble:100]];
    [wednesday addObject:[NSNumber numberWithDouble:200]];
    [wednesday addObject:[NSNumber numberWithDouble:150]];
    [wednesday addObject:[NSNumber numberWithDouble:100]];
    [wednesday addObject:[NSNumber numberWithDouble:50]];
    [wednesday addObject:[NSNumber numberWithDouble:70]];
    [wednesday addObject:[NSNumber numberWithDouble:80]];
    [wednesday addObject:[NSNumber numberWithDouble:50]];
    [wednesday addObject:[NSNumber numberWithDouble:40]];
    [wednesday addObject:[NSNumber numberWithDouble:10]];

    //Setting up graph
    self.lineChartView.delegate = self;
    self.lineChartView.descriptionText = @"Tap node for details";
    self.lineChartView.descriptionTextColor = [UIColor whiteColor];
    self.lineChartView.gridBackgroundColor = [UIColor darkGrayColor];
    self.lineChartView.rightAxis.enabled = NO;
    self.lineChartView.xAxis.enabled = NO;
    
    
    
    dataSets = [[NSMutableArray alloc] init];
    
    [self setChartData:hours forValues:tuesday withColor:[UIColor redColor] onDay:currentDayOfWeek];
    [self setChartData:hours forValues:wednesday withColor:[UIColor greenColor] onDay:@"Wednesday"];
    //[self setLineChartView:_lineChartView];
    
    //set up x-axis
    self.lineChartView.xAxis.valueFormatter = [[ChartIndexAxisValueFormatter alloc] initWithValues:hours];
    self.lineChartView.xAxis.labelPosition = XAxisLabelPositionBottom;
    self.lineChartView.xAxis.drawGridLinesEnabled = YES;
    self.lineChartView.xAxis.granularity = 1.0;

}

- (void)setChartData:(NSArray*)hours forValues:(NSMutableArray*)values  withColor:(UIColor*)color onDay:(NSString*)day{
    //create array of data entries
    NSMutableArray *yVals1 = [[NSMutableArray alloc] init];
    for (int i = 0; i < [hours count]; i++){
        NSLog(@"%@", [values objectAtIndex:i]);
        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:[[values objectAtIndex:i]doubleValue]];
        //ChartDataEntry *entry = [[ChartDataEntry alloc] initWith]
        [yVals1 addObject:entry];
    }
    
    //create a data set with our array
    LineChartDataSet *set1 = [[LineChartDataSet alloc] initWithValues:yVals1 label:day];
    [set1 setColor:color];
    set1.axisDependency = AxisDependencyLeft;
    [set1 setCircleColor:color];
    set1.lineWidth = 2.0;
    set1.circleRadius = 6.0;
    set1.fillAlpha= 65/255.0;
    set1.fillColor = color;
    set1.highlightColor = [UIColor whiteColor];
    set1.drawCircleHoleEnabled = YES;
    
    //create array to store our LineChartDataSets
    [dataSets addObject:set1];
    
    //pass our months in for our x-axis label value along with our dataSets
    LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
    [data setValueTextColor:[UIColor whiteColor]];
    
    //finally set our data
    self.lineChartView.data = data;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
