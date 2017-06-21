//
//  DataSort.m
//  ReactiveCocoaDemo
//
//  Created by chenchaozhong on 2017/6/21.
//  Copyright © 2017年 chenchaozhong. All rights reserved.
//

#import "DataSort.h"

@implementation DataSort

// 1.选择排序
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
        int temp = [array[i] intValue];
        array[i] = @(minValue);
        array[minIndex] = @(temp);
        
    }
}

// 快速排序
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

// 3.堆排
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

// 4.插入排序
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

// 5.希尔排序
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

// 6.归并排序
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

// 二分查找/折半查找 前提数组有序
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

@end
