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
    static TreeNode * dfs_creatTree(int data[], int index, int n)
    {
        TreeNode * pNode = NULL;
        
        if(index < n && data[index] != -1) //数组中-1 表示该节点为空
        {
            pNode = (TreeNode *)malloc(sizeof(TreeNode));
            if(pNode == NULL)
                return NULL;
            if(data[index] == -1)
                return NULL;
            
            //将二叉树按照层序遍历, 依次标序号, 从0开始
            pNode->val = data[index];
            pNode->left = dfs_creatTree(data, 2 * index + 1, n);
            pNode->right = dfs_creatTree(data, 2 * index + 2, n);
        }
        return pNode;
    }
    
    static TreeNode *bfs_createTree(int data[], int len){
        TreeNode * pNode = new TreeNode(data[0]);
        std::queue<TreeNode *> que;
        que.push(pNode);
        int i = 0;
        while (!que.empty()) {
            int size = (int)que.size();
            for (int j = 0; j < size; j++) {
                TreeNode *t = que.front();
                if(2 * i + 1 < len && t){
                    t->left = data[2 * i + 1] != -1 ? new TreeNode(data[2 * i + 1]):NULL;
                    if(t->left)que.push(t->left);
                }
                if(2 * i + 2 < len && t){
                    t->right = data[2 * i + 2] != -1 ? new TreeNode(data[2 * i + 2]):NULL;
                    if(t->right)que.push(t->right);
                }
                i++;
                que.pop();
            }
        }
        return pNode;
    }
    
    static TreeNode *bfs_createTree(std::vector<int>& data, int len){
        TreeNode * pNode = new TreeNode(data[0]);
        std::queue<TreeNode *> que;
        que.push(pNode);
        int i = 1;
        while(i < len){
            TreeNode *t = que.front();
            que.pop();
            if(data[i++] != -1){
                t->left = new TreeNode(data[i-1]);
                que.push(t->left);
            }
            if(i < len && data[i++] != -1){
                t->right = new TreeNode(data[i-1]);
                que.push(t->right);
            }
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


class CQueue {
private:
    std::stack<int> s1;
    std::stack<int> s2;
public:
    CQueue() {

    }
    
    void appendTail(int value) {
        s1.push(value);
    }
    
    int deleteHead() {
        if(!s2.empty()){
            int pop = s2.top();
            s2.pop();
            return pop;
        }
        if(s1.empty()) return -1;
        while(!s1.empty()){
            s2.push(s1.top());
            s1.pop();
        }
        int pop = s2.top();
        s2.pop();
        return pop;
    }
};

class Codec {
private:
    void dfs(TreeNode* root, std::string& s) {
        if(!root){
            s += "null,";
        }else{
            s += std::to_string(root->val)+",";
            dfs(root->left,s);
            dfs(root->right,s);
        }
    }

    void bfs(TreeNode *root, std::string& s){
        std::queue<TreeNode *> que;
        que.push(root);
        while(!que.empty()){
            int size = (int)que.size();
            for (int i = 0; i < size; i++) {
                TreeNode *t = que.front();
                s += t?std::to_string(t->val) + ",":"null,";
                if(t){
                    que.push(t->left);
                    que.push(t->right);
                }
                que.pop();
            }
        }
    }

    TreeNode *bfs_createTree(std::vector<int>& data, int len){
        TreeNode * pNode = new TreeNode(data[0]);
        std::queue<TreeNode *> que;
        que.push(pNode);
        int i = 1;
        while(i < len){
            TreeNode *t = que.front();
            if(data[i++] != -1001){
                t->left = new TreeNode(data[i-1]);
                que.push(t->left);
            }
            if(i < len && data[i++] != -1001){
                t->right = new TreeNode(data[i-1]);
                que.push(t->right);
            }
            que.pop();
        }
        return pNode;
    }



public:
    // Encodes a tree to a single string.
//    std::string serialize(TreeNode* root) {
//        std::string ans = "";
//        dfs(root,ans);
//        return ans;
//    }

    std::string serialize(TreeNode* root) {
        if (root == nullptr)
            return "[]";
        
        std::queue<TreeNode*> s;
        std::string sb = "[";
        int cnt = 1;    // 表示队列中非空结点的数量
        
        s.push(root);
        
        while (true) {
            TreeNode* cur = s.front();
            s.pop();
            if (cur == nullptr)
                sb += "null";
            else {
                --cnt;
                sb += to_string(cur->val);
                s.push(cur->left);
                s.push(cur->right);
                if (cur->left != nullptr)
                    ++cnt;
                if (cur->right != nullptr)
                    ++cnt;
            }
            if (cnt == 0 || s.empty())
                return sb + ']';
            sb += ',';
        }
    }
    
    // Decodes your encoded data to tree.
    TreeNode* deserialize(std::string data) {
        std::vector<int> v;
        std::string temp = "";
        for(int i = 0; i < data.size(); i++){
            if(data[i] == ','){
                if(temp == "null"){
                    v.push_back(-1001);
                }else{
                    v.push_back(std::atoi(temp.c_str()));
                }
                temp = "";
            }else{
                temp.push_back(data[i]);
            }
        }
        v.push_back(std::atoi(temp.c_str()));

        return bfs_createTree(v, (int)v.size());
    }
};

//class Codec {
//public:
//    void rserialize(TreeNode* root, std::string& str) {
//        if (root == nullptr) {
//            str += "null,";
//        } else {
//            str += std::to_string(root->val) + ",";
//            rserialize(root->left, str);
//            rserialize(root->right, str);
//        }
//    }
//
//    std::string serialize(TreeNode* root) {
//        std::string ret;
//        rserialize(root, ret);
//        return ret;
//    }
//
//    TreeNode* rdeserialize(std::list<int>& dataArray) {
//        if (dataArray.front() == -1001) {
//            dataArray.erase(dataArray.begin());
//            return nullptr;
//        }
//
//        TreeNode* root = new TreeNode(dataArray.front());
//        dataArray.erase(dataArray.begin());
//        if(dataArray.empty()) return nullptr;
//        root->left = rdeserialize(dataArray);
//        root->right = rdeserialize(dataArray);
//        return root;
//    }
//
//
//
//    TreeNode* deserialize(std::string data) {
//        std::list<int> dataArray;
//        std::string str;
//        for (auto& ch : data) {
//            if (ch == ',') {
//                dataArray.push_back(str == "null"?-1001:std::atoi(str.c_str()));
//                str.clear();
//            } else {
//                str.push_back(ch);
//            }
//        }
//        if (!str.empty()) {
//            dataArray.push_back(std::atoi(str.c_str()));
//            str.clear();
//        }
//        return rdeserialize(dataArray);
//    }
//};

#endif /* Struts_h */
