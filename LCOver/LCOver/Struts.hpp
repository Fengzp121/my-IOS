//
//  Struts.h
//  LCOver
//
//  Created by 你吗 on 2021/3/23.
//

#ifndef Struts_h
#define Struts_h

struct ListNode {
    int val;
    ListNode *next;
    ListNode() : val(0), next(nullptr) {}
    ListNode(int x) : val(x), next(nullptr) {}
    ListNode(int x, ListNode *next) : val(x), next(next) {}
};

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode() : val(0), left(nullptr), right(nullptr) {}
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
    TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
};

class List {
public:
    static ListNode *createList(std::vector<int> data){
        ListNode *head = new ListNode(-1);
        ListNode *tail = head;
        for (int i = 0; i < data.size(); i++) {
            ListNode* t = new ListNode(data[i]);
            tail->next = t;
            tail = t;
        }
        return head->next;
    }
};

class Tree {
public:
    static TreeNode * creatBTree(int data[], int index, int n)
    {
        TreeNode * pNode = NULL;
        
        if(index < n && data[index] != -1) //数组中-1 表示该节点为空
        {
            pNode = (TreeNode *)malloc(sizeof(TreeNode));
            if(pNode == NULL)
                return NULL;
            if(data[index] == NULL)
                return NULL;
            
            //将二叉树按照层序遍历, 依次标序号, 从0开始
            pNode->val = data[index];
            pNode->left = creatBTree(data, 2 * index + 1, n);
            pNode->right = creatBTree(data, 2 * index + 2, n);
        }
        return pNode;
    }
    
    static void pTree(TreeNode *node){
        if(!node) {
            std::cout << "NULL,";
            return;
        }
        std::cout << node->val << ",";
        pTree(node->left);
        pTree(node->right);
    }
};



class MinStack {
public:
    /** initialize your data structure here. */
    int val;
    MinStack *step;
    
    MinStack():val(0),step(nullptr) {}
    
    void push(int val) {
        this->val = val;
        
    }
    
    void pop() {

    }
    
    int top() {
        return 0;
    }
    
    int getMin() {
        return 0;
    }
};



#endif /* Struts_h */
