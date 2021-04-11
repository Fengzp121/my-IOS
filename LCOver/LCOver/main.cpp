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

ListNode* copyRandomList(ListNode* head) {
    unordered_map<ListNode *, ListNode *> hashmap;
    
    ListNode *ans = new ListNode(-1);
    ListNode *temp = ans;
    //创建普通链表
    while (head) {
        ListNode *t = new ListNode(head->val);
        cout << head << endl;
        hashmap[t] = head;
        temp->next = t;
        temp = t;
        head = head->next;
    }
    
    temp = ans->next;
    while (temp) {
        ListNode *t = NULL;
        if(hashmap[temp]){
            t = new ListNode(hashmap[temp]->val);
        }
        temp->random = t;
        temp = temp->next;
    }
    
    return ans->next;
}

int main(int argc, const char * argv[]) {
    LeetCode leetCode = LeetCode();
    
    //---------------leet---------------
    /* 链表 */
    ListNode* list = List::createList({0,1,0,3,12,0});
    ListNode* list1 = copyRandomList(list);
    while (list1) {
        cout << list1 << endl;
        list1 = list1->next;
    }
    /* 二叉树 */
//    int a[] = {1,2,3,4,NULL,NULL,5};
//    int b[] = {1,NULL,2,NULL,3};
//    TreeNode *tree1 = Tree::creatBTree(a, 0, 7);
//    TreeNode *tree2 = Tree::creatBTree(b, 0, 7);
    
    /* 字符串 */
//    string s = "{{{]()}}}";
    
    /* 数组 */
//    vector<int> vvc = {2,0,2,2,2,2};
//    vector<int> vvcc = {0,1,0,3,12,0};
    
//    p("结果", vvcc);
    int a = leetCode.nthUglyNumber(10);
    cout<< "ans:" << a << endl;
    
    
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

