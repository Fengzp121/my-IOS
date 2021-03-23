//
//  FFAlgorithm.cpp
//  LCOver
//
//  Created by 你吗 on 2021/3/23.
//

#include "FFAlgorithm.hpp"

void SortAlgorithms::bubbleSort(vector<int> &list){
    int a = 0;
    bool flag = false;
    for(int i = 0; i < list.size(); i++){
        flag = false;
        for (int j = 0; j < list.size() - 1 - i; j++) {
            if(list[j] > list[j + 1]){
                int temp = list[j];
                list[j] = list[j + 1];
                list[j + 1] = temp;
                flag = true;
            }
            a++;
        }
        if(!flag) {
            cout<< "提前退出的交换次数:" << a << endl;
            return;
        }
    }
    cout<< "交换次数:" << a << endl;
}

void SortAlgorithms::selectSort(vector<int> &a){
    int size = (int)a.size();
    for (int i = 0; i < size; i++) {
        //先设定一个初始的最小下标
        int min = i;
        for (int j = i + 1; j < size; j++) {
            //找出这里面最小的，从i + 1开始找
            if(a[min] > a[j]){
                //找到之后就交换一下下标
                min = j;
            }
        }
        //一次循环结束后获得最小的下标，如果min不等于当前下表（因为交换也没意义）
        if (min != i) {
            //交换一下
            swap(a[min], a[i]);
        }
    }
}

void SortAlgorithms::insertSort(vector<int> &a){
    for(int i = 1; i < a.size(); i++){
        //先设定一个基准
        int key = a[i];
        //对基准之前的数进行排序
        int j = i - 1;
        //如果之前的数比基准大，就与基准进行交换
        while (j >= 0 && a[j] > key) {
            a[j+1] = a[j];
            j--;
        }
        //最后将基准赋值到无法再交换的位置
        a[j+1] = key;
    }
}

int partion(vector<int> &a, int low, int high){
    //先设置基准，使用最左边的作为基准
    int pviot = a[low];
    while (low < high) {
        //从右边开始遍历，直到基准，然后跳出循环
        while (a[high] >= pviot && low < high) high--;
        //将大的比基准小的元素换到基准的左边去，这里 a[low] 已经被记录
        a[low] = a[high];
        //然后从左再遍历一次
        while (a[low] <= pviot && low < high) low++;
        //发现比基准大的丢到右边
        a[high] = a[low];
    }
    //将基准复制给最后换位置的数值
    a[low] = pviot;
    return low;
}


void SortAlgorithms::quickSort(vector<int> &a, int low, int high){
    if(low < high){
        int pivot = partion(a, low, high);
        quickSort(a, low, pivot - 1);
        quickSort(a, pivot + 1, high);
    }
}



void SortAlgorithms::quick2Sort(vector<int> &a ,int low, int high){
    if(low < high){
        int i = low, j = high, pviot = a[low];
        while (i < j) {
            while (a[j] >= pviot && i < j) j--;
            a[i] = a[j];
            while (a[i] <= pviot && i < j) i++;
            a[j] = a[i];
        }
        a[i] = pviot;
        quick2Sort(a, low, i - 1);
        quick2Sort(a, i + 1, high);
    }
}

void heapify(vector<int> &a, int start, int end){
    int dad = start;
    int son = dad * 2 + 1;
    while (son <= end) {
        //从子节点中选出大的一个
        if (son + 1 <= end && a[son] < a[son + 1]) {
            son++;
        }
        //看看父节点和子节点的比较
        if (a[dad] > a[son]){
            return;
        }else{
            //交换，然后再进行下一个节点
            swap(a[son], a[dad]);
            dad = son;
            son = dad * 2 + 1;
        }
    }
}

void SortAlgorithms::heapSort(vector<int> &a){
    int len = (int)a.size();
    //堆初始化，i从最后一个父节点开始调整，将最大的数切换到根节点，
    for (int i = len / 2 - 1; i >= 0; i--) {
        heapify(a, i, len - 1);
    }
    //将最大的节点和最后一个数进行交换
    for (int i = len - 1; i > 0; i--) {
        swap(a[0], a[i]);
        heapify(a, 0, i - 1);
    }
}

void SortAlgorithms::shellSort(vector<int> &a){
    int len = (int)a.size();
    //控制增量
    for (int gap = len / 2; gap > 0; gap /= 2) {
        //根据增量划分数组
        for (int i = gap;  i < len; i++) {
            //对划分的数组进行插入排序
            for (int j = i - gap; j >= 0 && a[j] > a[j+gap]; j -= gap) {
                swap(a[j], a[j+gap]);
            }
        }
    }
}

//TODO:radixSort、mergeSort

