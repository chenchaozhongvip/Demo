//
//  DataSort.h
//  ReactiveCocoaDemo
//
//  Created by chenchaozhong on 2017/6/21.
//  Copyright © 2017年 chenchaozhong. All rights reserved.
//

#import <Foundation/Foundation.h>

//const int a ＝ 10; // a的值不可修改
//
//int const a ＝ 10;
//
//const int *a;  // 这个指针指向整形数, 指向的这个整形数不能变
//
//int * const a;  // 这个指针不能变
//
//int const *const a ;

//1 ,2 前两个是一样，即：a是一个常整型数，a的值不可修改；  a=20; => 会报错
//
//3, 第三个意味着a是一个指向常整型数的指针（const修饰指针变量访问的内存空间，即：整型数，不可修改的，但指针可以）；a = 20；=>不会报错；  *a = &a; => 会报错 ;
//
//4, 第四个意思a是一个指向整型数的常指针（也就是说，指针指向的整型数是可以修改的，但指针是不可修改的）a = 20；=>会报错；  *a = &a; => 不会报错  ;
//
//5, 最后一个意味着a是一个指向常整型数的常指针（也就是说，指针指向的整型数是不可修改的，同时指针也是不可修改的）a = 20；=>会报错；  *a = &a; => 会报错  ;

@interface DataSort : NSObject
// 1.插入排序(插入排序)
- (void)insertionSort:(NSMutableArray *)array;

// 2.希尔排序(插入排序)
// 插入排序更高效
- (void)shellSort:(NSMutableArray *)array;

// 3.选择排序(选择排序)
- (void)selectionSort:(NSMutableArray *)array;

// 4.堆排(选择排序)
- (void)heapSort:(NSMutableArray *)array;

// 5.快排 (交换排序, 6.冒泡)
- (void)quickSort:(NSMutableArray *)array;

// 7.归并排序
- (void)mergeSort:(NSMutableArray *)array;

// 8.基数排序
- (NSArray *)radixSort:(NSMutableArray *)array;

// 字符串反转
char *revers(char *str);
@end
