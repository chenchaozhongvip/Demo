//
//  ViewController.m
//  RuntimeDemo
//
//  Created by chenchaozhong on 2017/3/13.
//  Copyright © 2017年 chenchaozhong. All rights reserved.
//

#import "ViewController.h"

#import <objc/runtime.h>

@interface ViewController ()<UIScrollViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scroll.backgroundColor = [UIColor redColor];
    scroll.decelerationRate = UIScrollViewDecelerationRateFast;
    scroll.delegate = self;

    //scroll.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
    [self.view addSubview:scroll];
    scroll.contentSize = CGSizeMake(self.view.frame.size.width, 1000);
    UIView *green = [[UIView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, 1000)];
    green.backgroundColor = [UIColor greenColor];
    [scroll addSubview:green];

    [scroll addObserver:self forKeyPath:@"bounds" options:NSKeyValueObservingOptionNew context:nil];
    
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"bounds"]) {
        UIScrollView *scroll = (UIScrollView *)object;
        if (scroll.isDecelerating && scroll.bounds.origin.x == 0) {
            
        }
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"bounds:%@",NSStringFromCGRect(scrollView.bounds));
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
