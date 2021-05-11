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
//    ListNode* list = List::createList({1,4,5});
//    ListNode* list2 = List::createList({1,3,4});
//    ListNode* list3 = List::createList({2,6});
    /* 二叉树 */
//    int a[] = {5,1,7};
//    int b[] = {1,NULL,2,NULL,3};
//    TreeNode *tree1 = Tree::creatBTree(a, 0,sizeof(a)/sizeof(int));
//    TreeNode *tree2 = Tree::creatBTree(b, 0, sizeof(b)/sizeof(int));
    
    /* 字符串 */
//    vector<string> s_v = {"06","226","122","3278","327","10","101","2101","1123"};
//    string s = "11223";
//    string st1 = s1.substr(0,4);
//    string st2 = s1.substr(4,s1.length() - 4);
//    cout << st1 << "," << st2 <<endl;
    
    /* 数组 */
    
//    vector<vector<string>> vvc = {
//        {".",".",".",".","5",".",".","1","."},
//        {".","4",".","3",".",".",".",".","."},
//        {".",".",".",".",".","3",".",".","1"},
//        {"8",".",".",".",".",".",".","2","."},
//        {".",".","2",".","7",".",".",".","."},
//        {".","1","5",".",".",".",".",".","."},
//        {".",".",".",".",".","2",".",".","."},
//        {".","2",".","9",".",".",".",".","."},
//        {".",".","4",".",".",".",".",".","."}};
//    vector<vector<int>> v = {{1,2,2,1},{3,1,2},{1,3,2},{2,4},{3,1,2},{1,3,1,1}};
//    vector<int> v1 = {1,3};
//    vector<int> v2 = {2};
    vector<vector<int>> null_v = {{-1,3}};
//    for (int s : v) {
    auto ans = leetCode.findNumberIn2DArray(null_v,3);
    cout<< "ans:" << ans << endl;
//    }
    
    
//    cout << "ans :";
//    for(auto a : ans){
//        cout << a << ",";
//    }
//    cout << endl;

    
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
//    while(m--){
//        fxxker.sixsixsixsixsixsix(x);
//    }
//
    
    return 0;
}

