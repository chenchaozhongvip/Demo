//
//  ViewController.m
//  RunLoopDemo
//
//  Created by chenchaozhong on 2017/3/18.
//  Copyright © 2017年 chenchaozhong. All rights reserved.
//

#import "ViewController.h"
#include <mach/port.h>
#import "DataSort.h"

@interface ViewController ()

@property (nonatomic, strong) NSObject *cc;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@(12),@(22),@(123),@(52),@(2),@(15),@(1234),@(5),nil] ;
//    DataSort *sort = [[DataSort alloc] init];
//
//    NSArray *Arr = [sort radixSort:arr];
    //extern int age;

    //NSLog(@"noti:\n current runloop: %@  cunrrent thread :%@  main: %@",[NSRunLoop currentRunLoop],[NSThread currentThread],[NSRunLoop mainRunLoop]);
//    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noti:) name:@"runloopTest" object:nil];
//    });
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"runloopTest" object:nil];
//    NSLog(@"noti:\n current runloop: %@  cunrrent thread :%@",[NSRunLoop currentRunLoop],[NSThread currentThread]);
    
}

- (void)noti:(NSObject *)not
{
    not = nil;
}

- (void)noti1:(NSObject *)not
{
    not = [NSObject new];;
}
- (void)noti2:(NSObject *)not
{
    NSLog(@"%@",not);
    //dispatch_walltime(, <#int64_t delta#>)
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CFRunLoopObserverRef obserberRef = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity){

        switch (activity) {
            case kCFRunLoopEntry:
                NSLog(@"即将进入runloop");
                break;
            case kCFRunLoopBeforeTimers:
                NSLog(@"即将处理Timer");
                break;
            case kCFRunLoopBeforeSources:
                NSLog(@"即将处理source(事件源)");
                break;
            case kCFRunLoopBeforeWaiting:
                NSLog(@"即将进入休眠");
                break;
            case kCFRunLoopAfterWaiting:
                NSLog(@"即将从休眠中醒来");
                break;
            case kCFRunLoopExit:
                NSLog(@"即将退出runLoop");
                break;
            default:
                break;
        }
        
    });
    
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), obserberRef, kCFRunLoopDefaultMode);
    
    CFRelease(obserberRef);
    
    
}


@end
