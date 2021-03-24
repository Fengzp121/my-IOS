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
    //---------------leet---------------
    /* 链表 */
//    ListNode first = ListNode(1);
//    ListNode second = ListNode(2);
//    ListNode thrid = ListNode(3);
//    ListNode fourth = ListNode(4);
//    first.next = &second;
//    second.next = &thrid;
//    thrid.next = &fourth;
    
    /* 二叉树 */
    int a[] = {1,2,3};
    int b[] = {1,NULL,2,NULL,3};
    TreeNode *tree1 = Tree::creatBTree(a, 0, 7);
    TreeNode *tree2 = Tree::creatBTree(b, 0, 7);
    
    /* 字符串 */
//    string s = "{{{]()}}}";
    
    /* 数组 */
//    vector<int> vvc = {1,-2,-5,-4,-3,3,3,5};
//    vector<int> vvcc = {0,1,0,3,12,0};

    LeetCode leetCode = LeetCode();
    
    //Tree::pTree();
    if(leetCode.isSymmetric(tree1)){
        cout << "yes" << endl;
    }
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
//    int x = 10;
//    int m = x;
//    while(--m){
//        fxxker.sixsixsixsixsixsix(x);
//    }
    return 0;
}

