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

#define null -1

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

void pList(ListNode *list){
    while(list){
        cout << list->val << ",";
        list = list->next;
    }
    cout << endl;
}


int main(int argc, const char * argv[]) {
    LeetCode leetCode = LeetCode();
//    Codec codec = Codec();
    //---------------leet---------------
    /* 链表 */
//    ListNode* list = List::createList({7,2,7,7});
//    ListNode* list2 = List::createList({1,3,4});
//    ListNode* list3 = List::createList({2,6});
    /* 二叉树 */
//    int a[] = {1,2,3,null,null,4,5,6};
//    int b[] = {1,NULL,2,NULL,3};1,2,3,null,null,4,5,6
//    TreeNode *tree1 = codec.deserialize("1,2,3,null,null,4,5,6");
//    TreeNode *tree2 = Tree::creatBTree(b, 0, sizeof(b)/sizeof(int));
    
    /* 字符串 */
//    vector<string> s_v = {"06","words and 987","225","-42","-91283472332","91283472332","    123","        -32","3.123","-3.123","+-3.2","+3"};
    string s = "K4(ON(SO3)2)2";
//    vector<string> s_v = {"H2O","K4(ON(SO3)2)2","Mg(OH)2","Be32","H111He49NO35B7N46Li20"};
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
//    vector<string> v1 = {"i", "love", "leetcode", "i", "love", "coding"};
//    vector<int> v2 = {2,1,0};
//    vector<vector<int>> null_v = {2,1,0};
//    vector<vector<int>> v = {{7,0},{4,4},{7,1},{5,0},{6,1},{5,2}};
    //5
    //{{0,2},{2,1},{3,4},{2,3},{1,4},{2,0},{0,4}}
    //3

    
//    TreeNode * ans = codec.deserialize(codec.serialize(tree1));
//    for (string s : s_v) {
        auto ans = leetCode.countOfAtoms(s);
//    pList(ans);
        cout<< "ans:" << ans << endl;
//    }
//    Tree::pTree(tree1);
    
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
//    sortMath.heapSort(a);
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

