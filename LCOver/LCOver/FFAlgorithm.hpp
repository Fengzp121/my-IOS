//
//  FFAlgorithm.hpp
//  LCOver
//
//  Created by 你吗 on 2021/3/23.
//

#ifndef FFAlgorithm_hpp
#define FFAlgorithm_hpp

#include <stdio.h>
#include <iostream>
#include <vector>

using namespace std;

class SortAlgorithms{
public:
    void bubbleSort(vector<int> &list);
    void selectSort(vector<int> &a);
    void insertSort(vector<int> &a);
    void quickSort(vector<int> &a, int low, int high);
    void quick2Sort(vector<int> &a ,int low, int high);
    void heapSort(vector<int> &a);
    void shellSort(vector<int> &a);
};

#endif /* FFAlgorithm_hpp */
