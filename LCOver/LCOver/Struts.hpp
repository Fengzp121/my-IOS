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
private:
    std::vector<int> container;
    //这里是选择使用空间换时间，多增加一个最小数的数组
    int index;
    //每次只压整个数组里最小的数，不管重复
    std::vector<int> min_container;
    
public:
    MinStack():index(0){}
    
    void push(int val) {
        container.push_back(val);
        if(index == 0){
            min_container.push_back(val);
        }else{
            //与栈顶的值比较，如果栈顶还是比较小，就直接再存栈顶
            min_container.push_back(fmin(min_container[index-1],val));
        }
        index++;
    }
    
    void pop() {
        container.pop_back();
        min_container.pop_back();
        index--;
    }
    
    int top() {
        return container[index-1];
    }
    
    int getMin() {
        return min_container[index-1];
    }
};

class Trie {
private:
    std::vector<Trie *> next;
    bool isEnd;
    
    Trie * searchWord(std::string word){
        Trie *p = this;
        for (int i = 0; i < word.size() && p; i++) {
            p = p->next[word[i] - 'a'];
        }
        return p;
    }
    
public:
    
    
    Trie():next(26),isEnd(false){}
    
    void insert(std::string word){
        Trie *p = this;
        for (int i = 0; i < word.size(); i++) {
            if(p->next[word[i] - 'a'] == NULL){
                p->next[word[i] - 'a'] = new Trie();
            }
            p = p->next[word[i] - 'a'];
        }
        p->isEnd = true;
    }
    
    bool search(std::string word){
        Trie *wordptr = this->searchWord(word);
        return wordptr && wordptr->isEnd;
    }
    
    bool startsWith(std::string prefix){
        return this->searchWord(prefix);
    }
};

class Employee {
public:
    int id;
    int importance;
    std::vector<int> subordinates;
};


#endif /* Struts_h */
