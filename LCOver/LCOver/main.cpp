//
//  main.cpp
//  LCOver
//
//  Created by 你吗 on 2021/3/19.
//

#include <iostream>
#include <vector>
#include <map>
#include <algorithm>
#include <list>
#include <iomanip>
#include <queue>
#include <stack>

#include "HelloWorld.hpp"
#include "LeetCode.hpp"
#include "FFAlgorithm.hpp"


using namespace std;


void p(string s,vector<int> a){
    cout << s;
    for(auto item : a){
        cout << item << ",";
    }
    cout << endl;
}

void p(string s,int a[],int len){
    cout << s;
    for(int i = 0; i < len; i++){
        cout << a[i] << ",";
    }
    cout << endl;
}


int main(int argc, const char * argv[]) {
    LeetCode leetCode = LeetCode();
    
    //---------------leet---------------
    /* 链表 */
//    ListNode* list = List::createList({1});
    
    /* 二叉树 */
    //int a[] = {1,2,5,3,4,NULL,6};
//    int b[] = {1,NULL,2,NULL,3};
    //TreeNode *tree1 = Tree::creatBTree(a, 0, 7);
//    TreeNode *tree2 = Tree::creatBTree(b, 0, 7);
    
    /* 字符串 */
//    string s = "{{{]()}}}";
    
    /* 数组 */
    vector<int> vvc = {2,3,6,7};
//    vector<int> vvcc = {0,1,0,3,12,0};
    
    
//    p("结果", vvcc);

    
    
    //---------------排序---------------
//    vector<int> a = {3,5,2,4,1,6,7};
//    int randomLength = 10;
//    vector<int> randomList;
//    while (--randomLength) {
//        randomList.push_back(rand() % 100 - 50);
//    }
//    sortList = randomList;
//    SortAlgorithms sortMath;
//    p("原数组：", a);
//    sortMath.shellSort(a);
//    p("排序结果：",a);

    
    
    //---------------运气游戏---------------
//    MotherFxxker fxxker;
//    int x = 5;
//    int m = 10;
//    while(--m){
//        fxxker.sixsixsixsixsixsix(x);
//    }
    //fxxker.check({4,7,9,22,30,31,13}, {{4,7,9,22,30,31,13},{5,7,12,15,16,31,11},{1,3,7,9,12,29,4},{1,7,10,23,24,29,6},{8,15,23,24,25,28,15}});
    return 0;
}

