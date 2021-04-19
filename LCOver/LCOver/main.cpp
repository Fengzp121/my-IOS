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
#include <string>
#include "HelloWorld.hpp"
#include "LeetCode.hpp"
#include "FFAlgorithm.hpp"

#define null NULL

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
//    ListNode* list = List::createList({0,1,0,3,12,0});

    /* 二叉树 */
//    int a[] = {4,1,null,2,null,3};
//    int b[] = {1,NULL,2,NULL,3};
//    TreeNode *tree1 = Tree::creatBTree(a, 0,sizeof(a)/sizeof(int));
//    TreeNode *tree2 = Tree::creatBTree(b, 0, sizeof(b)/sizeof(int));
    
    /* 字符串 */
    string s1 = "abcde";
    string st1 = s1.substr(0,4);
    string st2 = s1.substr(4,s1.length() - 4);
    
    cout << st1 << "," << st2 <<endl;
    /* 数组 */
    
//    vector<int> vvc = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,100,99,98,97,96,95,94,93,92,91,90,89,88,87,86,85,84,83,82};
//    vector<vector<int>> vvcc = {{0,5},{1,2},{0,2},{0,5},{1,3}};
//    vector<vector<int>> vvvccc = {{1},{3}};
    vector<int> v = {1,-1,0};
//    p("结果", vvcc);
    auto ans = leetCode.subarraySum(v,0);
    cout<< "ans:" << ans << endl;
    
    
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
//    int m = 5;
//    while(--m){
//        fxxker.sixsixsixsixsixsix(x);
//    }
//    return 0;
}

