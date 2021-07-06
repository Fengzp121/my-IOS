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
                    if(t->left)que.push(t->left);
                    if(t->right)que.push(t->right);
                }
                que.pop();
            }
        }
        std::cout << s << std::endl;
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
    std::string serialize(TreeNode* root) {
        std::string ans = "";
        bfs(root,ans);
        return ans;
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

class MedianFinder {
private:
    std::deque<int> _nums;
    int maxValue;
    int minValue;
    //记录下中位数？好像不可取
    //多用一个数据结构来作为存储
    
    // 最大堆，存储左边一半的数据，堆顶为最大值
    std::priority_queue<int, std::vector<int>, std::less<int>> maxHeap;
    // 最小堆， 存储右边一半的数据，堆顶为最小值
    std::priority_queue<int, std::vector<int>, std::greater<int>> minHeap;
    
public:
    /** initialize your data structure here. */
    MedianFinder() {
        
    }
    
    void addNum(int num) {
        if(_nums.empty()){
            _nums.push_back(num);
            minValue = num;
            maxValue = num;
            return;
        }
        if(num <= minValue){
            minValue = num;
            _nums.push_front(num);
            return;
        }else if(num > maxValue){
            maxValue = num;
            _nums.push_back(num);
            return;
        }
        for (auto it = _nums.begin(); it != _nums.end(); ++it) {
            if(*it >= num){
                _nums.insert(it, num);
                break;
            }
        }
        
    }
    
    double findMedian() {
        int size = (int)_nums.size();
        double median = 0;
        if(size % 2 == 0){
            if(size == 2)return (minValue + maxValue)/2.0;
            int val1 = _nums.at(size/2);
            int val2 = _nums.at(size/2 - 1);
            median = (val1 + val2)/2.0;
        }else{
            if(size == 1)return minValue;
            median = _nums.at(size/2);
        }
        return median;
    }
};

//["LRUCache","put","put","get","put","get","put","get","get","get"]
//[[2],[1,1],[2,2],[1],[3,3],[2],[4,4],[1],[3],[4]]
//["LRUCache","put","put","get","put","get","put","get","get","get"]
//[[2],[1,0],[2,2],[1],[3,3],[2],[4,4],[1],[3],[4]]
//["LRUCache","put","put","get","put","get","get"]
//[[2],[2,1],[1,1],[2],[4,1],[1],[2]]
//["LRUCache","put","put","put","put","get","get"]
//[[2],[2,1],[1,1],[2,3],[4,1],[1],[2]]
class LRUCache {
private:
    std::unordered_map<int,std::deque<std::vector<int>>::iterator> _objMap;//存放key-value
    std::deque<std::vector<int>> _deq;  //存放key-value
    int _capacity;         //缓存的最大容量
    int _sum;              //总量，每次put的时候都要
public:
    LRUCache(int capacity) {
        _capacity = capacity;
        _sum = 0;
    }
    
    int get(int key) {
        int value = 0;
        if(_objMap.count(key)){
            value = (*_objMap[key])[1];
            _deq.erase(_objMap[key]);
            _deq.push_front({key,value});
            _objMap[key] = _deq.begin();
        }else{
            value = -1;
        }
        return value;
    }
    
    void put(int key, int value) {
        
        if(_objMap.count(key)){
            _deq.erase(_objMap[key]);
            _deq.push_front({key,value});
            _objMap[key] = _deq.begin();
        }else{
            _deq.push_front({key,value});
            _objMap[key] = _deq.begin();
            sum++;
        }
        if(_sum > _capacity){
            _sum--;
            int t_key = _deq.back()[0];
            _deq.pop_back();
            _objMap.erase(t_key);
        }
    }
};



#endif /* Struts_h */
