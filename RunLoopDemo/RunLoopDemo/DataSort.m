//
//  DataSort.m
//  ReactiveCocoaDemo
//
//  Created by chenchaozhong on 2017/6/21.
//  Copyright © 2017年 chenchaozhong. All rights reserved.
//

#import "DataSort.h"

@implementation DataSort

// 1.插入排序
- (void)insertionSort:(NSMutableArray *)array
{
    int temp;
    for (int i = 0; i < array.count; i++) {
        temp = [array[i] intValue];
        // i 之前的数组 把i插进去
        for (int j = i; j > 0; j--) {
            if ([array[j-1] intValue] > temp) {
                array[j] = array[j-1];
            } else {
                array[j] = @(temp);
                break;
            }
        }
    }
}

// 2.希尔排序
// 插入排序更高效
- (void)shellSort:(NSMutableArray *)array
{
    int gap = floor(array.count/2);
    while (gap>0) {
        for (int i = gap; i < array.count; i++) {  // 从最后一组开始
            for (int j = i; j > 0; j -= gap) {
                if (array[j - gap] > array[j]) {
                    [self swap:array i:j j:j-gap];
                } else {
                    break;
                }
            }
        }
        gap = floor(gap/2);
    }
}


// 3.选择排序
- (void)selectionSort:(NSMutableArray *)array
{
    int minIndex, minValue;
    
    for (int i = 0; i < array.count - 1; i++) {
        minIndex = i;
        minValue = [array[i] intValue];
        for (int j = i+1; j<array.count; j++) {
            if ([array[j] intValue] < minValue) {
                minIndex = j;
                minValue = [array[j] intValue];
            }
        }
        // 交换
        [self swap:array i:i j:minIndex];
        
    }
}


// 4.堆排
// 二叉堆(完全二叉树)
// 最大堆: 最大值在堆顶  最小堆: 最小值在堆顶

// 3.1
//    如果index是最大: 一个小二叉树排序,变成根最大(这只是最简单的小三角)
//    如果index是最小: 会重新将树调整为最大堆
- (void)maxHeapify:(NSMutableArray *)array index:(int)index heapSize:(NSInteger)heapSize
{
    int iLeft,iRight,iMax;
    while (YES) {
        iMax = index;
        iLeft = 2*index+1;
        iRight = 2*(index+1);
        
        if (iLeft < heapSize && array[iLeft] > array[index]) {
            iMax = iLeft;
        }
        
        // [0000]这里写错过, IMAX位置不是index
        if (iRight < heapSize && array[iRight] > array[iMax]) {
            iMax = iRight;
        }
        
        if (iMax != index) {
            [self swap:array i:iMax j:index];
            index = iMax;
        } else {
            break;
        }
    }
}

// 3.2 建立一个最大堆 疑问? 为什么不直接调用index为0, 解决[0000]位置写错,一次只能保证跟为最大值,并不能保证所有树为最大值
- (void)buildMaxHeap:(NSMutableArray *)array
{
    int parent = floor(array.count/2)-1;
    
    for (int i = parent; i >= 0; i--) {
        // 每个根都进行下比较, 使得根最大
        [self maxHeapify:array index:i heapSize:array.count];
    }
}

- (void)heapSort:(NSMutableArray *)array
{
    // 建立最大堆
    [self buildMaxHeap:array];
    
    for (NSInteger i = array.count - 1; i > 0; i--) {
        [self swap:array i:(int)i j:0];
        [self maxHeapify:array index:0 heapSize:i];
    }
    
}

// 交换排序: 冒泡和快拍
// 5.快速排序
// 分治法, 选择一个"基准", 左小右大
// 2.1交换方法
- (void)swap:(NSMutableArray *)array i:(int)i j:(int)j
{
    int temp = [array[i] intValue];
    array[i] = array[j];
    array[j] = @(temp);
}

// 2.2分割函数
- (int)partiton:(NSMutableArray *)array left:(int)left right:(int)right
{
    int storeIndex = left; // 存储值
    int pivot = [array[right] intValue];
    for (int i = 0; i < array.count; i++) {
        if ([array[i] intValue] < pivot) {
            [self swap:array i:i j:storeIndex]; // 小于轴的都放在左
            storeIndex++;
        }
    }
    // 交换轴的位置
    [self swap:array i:storeIndex j:right];
    return storeIndex;
}

// 2.快排
- (void)quickSort:(NSMutableArray *)array left:(int)left right:(int)right
{
    if (left > right) {
        return ;
    }
    int poivtIndex = [self  partiton:array left:left right:right];
    [self quickSort:array left:left right:poivtIndex-1];
    [self quickSort:array left:poivtIndex+1 right:right];
}
- (void)quickSort:(NSMutableArray *)array
{
    [self quickSort:array left:0 right:(int)array.count-1];
}


// 6.归并排序
- (void)mergeSort:(NSMutableArray *)array
{
    [self mergeSort:array left:0 right:(int)array.count-1];
}
// 分治法
- (void)mergeSort:(NSMutableArray *)array left:(int)left right:(int)right
{
    if (right - left < 1) {
        return;
    }
    int middle = floor((left+right)/2);
    // 左边排序
    [self mergeSort:array left:left right:middle];
    // 右边排序
    [self mergeSort:array left:middle+1 right:right];
    
    while (left <= middle && middle+1 <= right) {
        
        // 右边的数组 往左边插
        // 左边 大于 右边第一个
        if (array[left] >= array[middle+1]) {
            int temp = [array[middle+1] intValue];
            // 左边的整体右移一个单位
            for (int i = middle; i >= left; i--) {
                array[i+1] = array[i];
            }
            array[left] = @(temp);
            // 标识右移
            middle++;
        } else {
            // 标识右移
            left++;
        }
    }
}

// 7.二分查找/折半查找 前提数组有序
- (int)binarySearch:(NSMutableArray *)array left:(int)left right:(int)right temp:(int)temp
{
    if (left > right) {
        return -1;
    }
    int middle = (left + right)/2;
    if ([array[middle] intValue] > temp) {
        return [self binarySearch:array left:left right:middle-1 temp:temp];
    } else if ([array[middle] intValue] < temp) {
        return [self binarySearch:array left:middle+1 right:right temp:temp];
    } else {
        return middle;
    }
    return -1;
}

// 8.基数排序
- (NSArray *)radixSort:(NSMutableArray *)array
{
    // 桶  里面是数组
    NSMutableArray *bucket = [NSMutableArray array];
    
    int max = [array[0] intValue];
    int loop ;
    
    // 找出最大数
    for (int i = 1; i < array.count; i++) {
        if (max < [array[i] intValue]) {
            max = [array[i] intValue];
        }
            
    }
    
    for (int i = 0; i < 10; i++) {
        bucket[i] = [NSMutableArray array];
    }
    
    // 找最大位数 采用字符串化
    loop = (int)[[NSString stringWithFormat:@"%d",max] length];
   
    for (int i = 0; i < loop; i ++ ) {
        for (int j = 0; j < array.count; j++) {
            
            NSString *str = [NSString stringWithFormat:@"%d",[array[j] intValue]];
            if (str.length >= i+1) {
                // 最i位数字是多少, k是第i位数字
                int k = [[str substringWithRange:NSMakeRange(str.length - i - 1, 1)] intValue];
                [bucket[k] addObject:array[j]];
            } else {
                [bucket[0] addObject:array[j]];
            }
            
        }
        
        array = [NSMutableArray array];
        for (int j = 0; j < 10; j++) {
            int t = (int)[bucket[j] count];
            for (int k = 0; k < t; k++) {
                [array addObject:bucket[j][k]];
            }
            bucket[j] = [NSMutableArray array];
        }
        
    }
    return array;
}

char *revers(char *str)
{
    if (!str) {
        return NULL;
    }
    
    int len = strlen(str);
    
    for (int i = 0; i < len/2; i++) {
        char temp = *(str + i);
        *(str + i) = *(str + len - i - 1);
        *(str + len - i - 1) = temp;
    }
    return str;
}

@end
