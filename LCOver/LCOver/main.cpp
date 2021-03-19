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

using namespace std;

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

class LeetCode {
public:
    LeetCode(){}
    
    vector<vector<int>> threeSum(vector<int> &nums){
        vector<vector<int>> ans;
        int size = (int)nums.size();
        sort(nums.begin(), nums.end());
        int traget;//第一个数
        for (int i = 0; i < size; i++) {
            //这里的目的就是去重，把重复的数字去掉
            if(i > 0 && nums[i] == nums[i - 1]) continue;
            //因为数组是已经排序过的。当traget > 0时，后面的数都是正数了，所以可以退出循环了
            if ((traget = nums[i]) > 0) break;
            //双指针，用来取后两个数，两头向中间取值
            int l = i + 1, r = size - 1;
            while (l < r) {
                //这里如果小于0，就代表nums[l] + nums[r] 太小了，所以左指针向右移
                if(nums[l] + nums[r] + traget < 0) ++l;
                //这里就是大于0，两个相加太大了，右指针左移
                else if(nums[l] + nums[r] + traget > 0) --r;
                else{
                    ans.push_back({nums[l],nums[r],traget});
                    ++l;
                    --r;
                    //这里也是去重
                    while (l < r && nums[l] == nums[l - 1]) ++l;
                    while (l < r && nums[r] == nums[r + 1]) --r;
                }
            }
        }
        return ans;
        
        
//        //用hashmap的方法，但是一开始不进行排序，时间复杂度太高了
//        vector<vector<int>> ans;
//        if (nums.size() < 3 || nums.empty()){
//            return ans;
//        }
//        int size = (int)nums.size();
////        sort(nums.begin(), nums.end());
//        //用来区别组合数组的
//        map<string,unsigned int> sumArrMap;
//        map<unsigned int,unsigned int> nusMap;
////        vector<int> temp = {0,0,0};
//        int i,j,n1,minx,maxx,xxd;
//        //第一次两数之和
//
//        for ( i = 0; i < size - 2; i++) {
//            n1 = nums[i];   //第一个数
//            nusMap.clear();
//            //第二次两数之和
//            for ( j = i + 1; j < size; j++) {
//                xxd = -n1 - nums[j];
//                if(nusMap.count(xxd) > 0){ //第二个数
////                    auto start = std::chrono::steady_clock::now();
//                    minx = min(n1, min(nums[j], xxd));
//                    maxx = max(n1,max(nums[j], xxd));
//                    string key = to_string(minx).append(to_string(maxx));
////                    auto end = std::chrono::steady_clock::now();
////                    std::chrono::duration<double, std::micro> elapsed = end - start; // std::micro 表示以微秒为时间单位
////                    std::cout<< "time: "  << elapsed.count() << "us" << std::endl;
//
//                    if(sumArrMap[key] > 0){
//                        continue;
//                    }
//                    sumArrMap[key] = 1;
//                    ans.push_back({n1,nums[j],xxd});
//
//                }else{
//                    nusMap[nums[j]] = j;    //第三个数
//
//                }
//            }
//        }
//
//        return ans;
    }
    
    
    vector<vector<int>> fourSum(vector<int>& nums, int target) {
        vector<vector<int>> ans;
        sort(nums.begin(),nums.end());
        int len = (int)nums.size();
        //多增加一层循环，然后当成三数之和
        for (int i = 0; i < len; i++) {
            //每一层都需要做去重操作
            if(i > 0 && nums[i] == nums[i - 1]) continue;
            int threeSum = target - nums[i];
            //三数之和的逻辑
            for (int j = i + 1; j < len; j++) {
                //去重操作
                if(j > i + 1 && nums[j] == nums[j - 1]) continue;
                int l = j + 1,r = len - 1;
                //两数之和
                while (l < r) {
                    if(nums[l] + nums[r] + nums[j] < threeSum) ++l;
                    else if(nums[l] + nums[r] + nums[j] > threeSum) --r;
                    else{
                        ans.push_back({nums[l] , nums[r] , nums[j], nums[i]});
                        ++l;
                        --r;
                        while (l < r && nums[l] == nums[l - 1]) ++l;
                        while (l < r && nums[r] == nums[r + 1]) --r;
                    }
                }
            }
            
        }
        return ans;
    }
    
    
    string countAndSay(int n){
        string str = "1";
        for (int j = 1; j < n; ++j) {
            string new_str = "";
            unsigned long i = 0;
            int count = 0;
            char key = str[0];
            for (auto s : str){

                if(s == key ){
                    count++;
                    
                }else{
                    
                    new_str.append(to_string(count));
                    new_str.push_back(key);
                    key = s;
                    count = 1;
                }
                if (i == str.length() - 1){
                    new_str.append(to_string(count));
                    new_str.push_back(key);
                    str = new_str;
                }
                ++i;
            }
            str = new_str;
        }
        return str;
    }
    
    void merge(vector<int>& nums1, int m, vector<int>& nums2, int n) {
//        int i = 0;
//        int j = 0;
//        if(n == 0){
//            return;
//        }
//
        //排序大法
//        for (int i = 0; i < n; i++) {
//            nums1[i+m] = nums2[i];
//        }
//        sort(nums1.begin(), nums1.end());
        
        //不排序，新建一个数组作存储
//        vector<int> nums;
//        int count = 0;
//        while (count !=  m + n) {//push总数为m+n时退出循环
//
//            //限制j不能访问越界，并且判断两者大小决定push哪个
//            if(j != n && (i >= m || nums1[i] > nums2[j])){
//                nums.push_back(nums2[j]);
//                j++;
//            }else{
//                nums.push_back(nums1[i]);
//                i++;
//            }
//            count++;
//        }
//        nums1 = nums;
        
        
        //倒插法
       // int last = m + n-1;
    }
        

    string convert(string s, int numRows) {
        //第一行和最下面一行的递增关系是 2(n-1) 中间会是n-1的某个倍数
        //因此，只需要将(i / (n - 1)  % 2 ) != 2  应该就可以判断是否是首尾行还是中间了
        
        //但是中间要怎么谁先谁后呢
        //     i % (n - 1) //这个倒是没想到。。。
//        string temp;
//        if(s.empty() || numRows < 1) return temp;
//        if(numRows == 1) return s;
//        vector<string> arrs(numRows);
//        int ans = 0;
//        int crl = 0;
//        for (int i = 0; i < s.length(); ++i) {
//            ans = i / (numRows - 1);
//            crl = i % (numRows - 1);
//            //如果是o数
//            if(ans % 2 == 0){
//                arrs[crl].push_back(s[i]);
//            }else{
//                //
//                arrs[numRows - crl - 1].push_back(s[i]);
//            }
//        }
//        for (int i = 0; i < arrs.size(); ++i) {
//            temp += arrs[i];
//        }
//        return temp;
        
        //用距离的想法来弄
        if(s.empty() || numRows <= 1) return s;
        int distance = 2 * numRows - 2;
        int handdistance = distance/2;
        int size = (int)s.size();
        string res = "";
        for (int i=0; i<numRows; i++) {
            int distancebuf = distance - 2*i;
            if (i == 0 || i == numRows-1) {
                for (int j=0; i+j*distance<size; j++) {
                    res.push_back(s[i+j*distance]);
                }
            } else if (2*i == numRows-1){
                for (int j=0; i+j*handdistance<size; j++) {
                    res.push_back(s[i+j*handdistance]);
                }
            } else{
                for (int j=0; i + j*distance<size; j++) {
                    res.push_back(s[i + j*distance]);
                    if (i + j*distance + distancebuf < size) {
                        res.push_back(s[i + j*distance + distancebuf]);
                    }
                }
            }
        }
        return res;
    }

    
    

    
    int mySqrt(int x){
        //api大法
        //return sqrt(x);
        
        //每个都算一次
//        if (x <= 1) {
//            return x;
//        }
//        long int i = 1;
//        while (i) {
//            long int temp = i;
//            i *= i;
//            if (i < x) {
//                i /= temp;
//                ++i;
//            }else if(i == x){
//                return (int)i / temp;
//            }else{
//                i /= temp;
//                i--;
//                return (int)i;
//            }
//        }
//
//        return 1;
        
        //将过滤掉一部分
        if(x <= 1) return x;
        int low = 0;
        int high = x;
        while (low < high) {
            if(low+1 == high)return low;
            long int mid = (low+high)/2;
            if(mid * mid > x)high = mid;
            else if (mid * mid < x)low = mid;
            else return mid;
        }
        return 0;
    }
    
    int majorityElement(vector<int>& nums){
        //排序法
        //因为nums里面出现最多的数会出现nums.size()/2
        //因此，排序后，中间的数是必然会覆盖最多的数的。
//        sort(nums.begin(),nums.end());
//        return nums[nums.size()/2];
        
        //hashmap法
        //将每一个出现的数用一个hashmap统计起来
        //每次和count做匹配，如果当前相加后的数比count大，就将众数换了
//        int indexNum = 0,maxCount = 0;
//        map<int,int> numsMap;
//        for(int i = 0; i < nums.size(); ++i){
//            ++numsMap[nums[i]];
//            if(numsMap[nums[i]] > maxCount){
//                maxCount = numsMap[nums[i]];
//                indexNum = nums[i];
//            }
//        }
//        return indexNum;
        
        //投票法
        //不懂。。。
        //大概就是每次匹配candidate的值，如果相同x与candidate，count+1否者count-1 并且如果小于0就重新赋值candidate和count
        //这样最后比较多的数的count就会保持“正数”，输出的也就是众数了
        //因为每次
        int count = 0,candidate = -1;
        for (int a : nums) {
            if(a == candidate){
                ++count;
            }else if(--count < 0){
                candidate = a;
                count = 1;
            }
        }
        return candidate;
    }
    
    //TODO:合并K个生序链表
    ListNode* mergeKLists(vector<ListNode*>& lists) {
//        if(lists.size() == 0) return nullptr;
//        ListNode *nlist = lists[0];
//        while (1) {
//            return nullptr;
//        }
//        for(int i = 0; i < lists.size(); ++i){
//            if(lists[i] == nullptr){
//                continue;
//            }
////            if(nlist.val <= lists[i]->val){
////                nlist.next = lists[i];
////            }
//            lists[i] = lists[i]->next;
//        }
        return nullptr;
    }
    
    int lengthOfLongestSubstring(string s) {
        if(s.length() <= 1) return (int)s.length();
        //记录字符上一次出现的位子
        vector<int> last(128,-1);
        int n = (int)s.length();
        int res = 0;
        int start = 0;//窗口开始的位置
        for (int i = 0; i < n; ++i) {
            int index = s.at(i);
            start = max(start, last[index]);
            res = max(res, i - start + 1);
            last[index] = i + 1;
        }
        return res;
    }
    
    bool isValid(string s){
        if (s.length() <= 1) {
            return false;
        }
        //使用栈的特性
        stack<char> stack;
        for (auto c : s) {
            //先压入
            if(stack.size() == 0){
                stack.push(c);
                continue;
            }
            char top = stack.top();
            if(top == '{' && c == '}'){
                stack.pop();
            }else if (top == '[' && c == ']'){
                stack.pop();
            }else if (top == '(' && c == ')'){
                stack.pop();
            }else{
                stack.push(c);
            }
        }
        
        return stack.size() == 0;
    }
    
    bool hasCycle(ListNode *head) {
        //可以用hashmap的方法，当然也可以用set的方法
        //但是这种方法只能用在元素只出现一次的情况
//        if(head == nullptr || head->next == nullptr)
//            return false;
//        map<int,int> map;
//        while(head->next != nullptr){
//            if(map.count(head->val) > 0){
//                return true;
//            }
//            map[head->val] = head->val;
//            head = head->next;
//        }
//        return false;
        
        //快慢指针的方法
        //如果链表内有环，快指针会在某个节点追上慢指针
        //如果没有环，快指针会很快到达终点，null
        if(head == nullptr || head->next == nullptr)
            return false;
        ListNode *fast = head->next;
        ListNode *slow = head;
        while(fast != slow){
            if(fast == nullptr || fast->next == nullptr){
                return false;
            }
            slow = slow->next;
            fast = fast->next->next;
        }
        return true;
    }
    
    //TODO:股票最大收益
    int maxProfit(vector<int>& prices) {
        
        return 0;
    }
    
    void rotate(vector<vector<int>>& matrix) {
        int len = (int)matrix.size();
        //先看矩阵的深度有多大，要执行多少圈
        for(int i = 0; i <= len / 2; i++){
            //每一层执行多少次
            for (int j = i; j < len - i - 1; j++) {
                int temp = matrix[i][j];
                matrix[i][j] = matrix[len-j-1][i];
                matrix[len-j-1][i] = matrix[len-i-1][len-j-1];
                matrix[len-i-1][len-j-1] = matrix[j][len-i-1];
                matrix[j][len-i-1] = temp;
            }
        }
    }
    
    vector<vector<int>> levelOrder(TreeNode* root) {
        vector<vector<int>> vvec;
        if(!root) return vvec;
        queue<TreeNode *> tqueue;
        tqueue.push(root);
        vvec.push_back({root->val});
        while (!tqueue.empty()) {
            int size = (int)tqueue.size();
            vector<int> temp;
            for (int i = 0; i < size; ++i) {
                TreeNode *node = tqueue.front();
                if(node->left != NULL){
                    tqueue.push(node->left);
                    temp.push_back(node->left->val);
                }
                if(node->right != NULL){
                    tqueue.push(node->right);
                    temp.push_back(node->right->val);
                }
                tqueue.pop();
            }
            if(tqueue.size() > 0)
                vvec.push_back(temp);
        }
        return vvec;
    }
    
 
    int maxDepth(TreeNode* root) {
        //DFS
//        if(!root) return 0;
//        int maxLD = 0;
//        int maxRD = 0;
//        if(root && root->left != nullptr)
//            maxLD += maxDepth(root->left);
//        if(root && root->right != nullptr)
//            maxRD += maxDepth(root->right);
//
//        return max(maxRD,maxLD) + 1;
        
        //BFS
        //使用一个队列，利用先进先出的结构，将根节点放进去。
        //然后每有一个子节点就放进去，并且让队列头出队
        //统计每一次外循坏（就是到下一层的时候 +1）
        if(!root) return 0;
        int max = 0;
        queue<TreeNode *> tqueue;
        tqueue.push(root);
        while (!tqueue.empty()) {
            int size = (int)tqueue.size();
            for (int i = 0; i < size; ++i) {
                TreeNode *node = tqueue.front();
                if(node->left != NULL)
                    tqueue.push(node->left);
                if(node->right != NULL)
                    tqueue.push(node->right);
                tqueue.pop();
            }
            max++;
        }
        return max;
    }
    
    //TODO:生成括号
    vector<string> generateParenthesis(int n) {
        string s;
        for (int i = 0; i < n; ++i) {
            s.append("(");
            s.append(")");
        }
        return {};
    }
    
    //TODO:子集、回溯算法
    vector<vector<int>> subsets(vector<int>& nums) {
        vector<vector<int>> ans;
        int size = (int)nums.size();
        ans.push_back({});
        for(int i = 0; i < size; ++i){
            ans.push_back({nums[i]});
        }
        for (int i = 0; i < size; ++i) {
            ans.push_back({nums[i],nums[i+1]});
        }
        
        for (int i = 0; i < size; ++i) {
            vector<int> temp;
            for (int j = i; j < size - 1; ++j) {
                temp.push_back(nums[j]);
            }
            if(temp.size() > 0)
                ans.push_back(temp);
        }
        return ans;
    }
    
    void moveZeroes(vector<int>& nums){
        int size = (int)nums.size();
        for (int i = 0; i < size; i++) {
            if(i + 1 < size && nums[i] == 0 && nums[i + 1] != 0){
                swap(nums[i], nums[i+1]);
            }else{
                for (int j = i; j < size; j++) {
                    if(nums[j] != 0){
                        swap(nums[j], nums[i]);
                        if(j == size - 1) return;
                        break;
                    }else if(j == size - 1){
                        return;
                    }
                }
            }
        }
        
        int j = 0;
        for (int i = 0; i < size; i++) {
            if(nums[i] != 0){
                nums[j] = nums[i];
                if(i != j) nums[i] = 0;
                j++;
            }
        }
    }
    
};

class SortAlgorithms{
public:
    void bubbleSort(vector<int> &list){
        int a = 0;
        bool flag = false;
        for(int i = 0; i < list.size(); i++){
            flag = false;
            for (int j = 0; j < list.size() - 1 - i; j++) {
                if(list[j] > list[j + 1]){
                    int temp = list[j];
                    list[j] = list[j + 1];
                    list[j + 1] = temp;
                    flag = true;
                }
                a++;
            }
            if(!flag) {
                cout<< "提前退出的交换次数:" << a << endl;
                return;
            }
        }
        cout<< "交换次数:" << a << endl;
    }
    
    void selectSort(vector<int> &a){
        int size = (int)a.size();
        for (int i = 0; i < size; i++) {
            //先设定一个初始的最小下标
            int min = i;
            for (int j = i + 1; j < size; j++) {
                //找出这里面最小的，从i + 1开始找
                if(a[min] > a[j]){
                    //找到之后就交换一下下标
                    min = j;
                }
            }
            //一次循环结束后获得最小的下标，如果min不等于当前下表（因为交换也没意义）
            if (min != i) {
                //交换一下
                swap(a[min], a[i]);
            }
        }
    }
    
    void insertSort(vector<int> &a){
        for(int i = 1; i < a.size(); i++){
            //先设定一个基准
            int key = a[i];
            //对基准之前的数进行排序
            int j = i - 1;
            //如果之前的数比基准大，就与基准进行交换
            while (j >= 0 && a[j] > key) {
                a[j+1] = a[j];
                j--;
            }
            //最后将基准赋值到无法再交换的位置
            a[j+1] = key;
        }
    }
    
    

    void quickSort(vector<int> &a, int low, int high){
        if(low < high){
            int pivot = partion(a, low, high);
            quickSort(a, low, pivot - 1);
            quickSort(a, pivot + 1, high);
        }
    }
    
    int partion(vector<int> &a, int low, int high){
        //先设置基准，使用最左边的作为基准
        int pviot = a[low];
        while (low < high) {
            //从右边开始遍历，直到基准，然后跳出循环
            while (a[high] >= pviot && low < high) high--;
            //将大的比基准小的元素换到基准的左边去，这里 a[low] 已经被记录
            a[low] = a[high];
            //然后从左再遍历一次
            while (a[low] <= pviot && low < high) low++;
            //发现比基准大的丢到右边
            a[high] = a[low];
        }
        //将基准复制给最后换位置的数值
        a[low] = pviot;
        return low;
    }
    
    void quick2Sort(vector<int> &a ,int low, int high){
        if(low < high){
            int i = low, j = high, pviot = a[low];
            while (i < j) {
                while (a[j] >= pviot && i < j) j--;
                a[i] = a[j];
                while (a[i] <= pviot && i < j) i++;
                a[j] = a[i];
            }
            a[i] = pviot;
            quick2Sort(a, low, i - 1);
            quick2Sort(a, i + 1, high);
        }
    }
    
    void heapify(vector<int> &a, int start, int end){
        int dad = start;
        int son = dad * 2 + 1;
        while (son <= end) {
            //从子节点中选出大的一个
            if (son + 1 <= end && a[son] < a[son + 1]) {
                son++;
            }
            //看看父节点和子节点的比较
            if (a[dad] > a[son]){
                return;
            }else{
                //交换，然后再进行下一个节点
                swap(a[son], a[dad]);
                dad = son;
                son = dad * 2 + 1;
            }
        }
    }
    
    void heapSort(vector<int> &a){
        int len = (int)a.size();
        //堆初始化，i从最后一个父节点开始调整，将最大的数切换到根节点，
        for (int i = len / 2 - 1; i >= 0; i--) {
            heapify(a, i, len - 1);
        }
        //将最大的节点和最后一个数进行交换
        for (int i = len - 1; i > 0; i--) {
            swap(a[0], a[i]);
            heapify(a, 0, i - 1);
        }
    }
    
    void shellSort(vector<int> &a){
        int len = (int)a.size();
        //控制增量
        for (int gap = len / 2; gap > 0; gap /= 2) {
            //根据增量划分数组
            for (int i = gap;  i < len; i++) {
                //对划分的数组进行插入排序
                for (int j = i - gap; j >= 0 && a[j] > a[j+gap]; j -= gap) {
                    swap(a[j], a[j+gap]);
                }
            }
        }
    }
    
    //TODO:radixSort、mergeSort
    
};

class MotherFxlaoxker {
public:
    void six(list<int> &l){
        while (l.size() < 6) {
            l.push_back(rand() % 33 + 1);
            l.sort();
            l.unique();
        }
        l.push_back(rand() % 16 + 1);
    }
    
    void sixsixsixsixsixsix(int x){
        list<list<int>> lls;
        while (lls.size() < x) {
            list<int> ls;
            six(ls);
            lls.push_back(ls);
            lls.unique();
        }
        cout << "           随机" << x << "注" << endl;
        cout << "     红球             蓝球" <<endl;
        for (auto ls : lls) {
            for (list<int>::iterator it = ls.begin(); it != ls.end(); ++it) {
                if(it == --ls.end()){
                    cout<< "    ";
                }
                if(*it < 10){
                    cout<< 0;
                }
                cout << *it << " ";
            }
            cout << endl;
        }
    }
};



int main(int argc, const char * argv[]) {
    //---------------leet---------------
//    ListNode first = ListNode(1);
//    ListNode second = ListNode(2);
//    first.next = &second;
//    string s = "{{{]()}}}";
    vector<int> vvc = {1,-2,-5,-4,-3,3,3,5};
    vector<int> vvcc = {0,1,0,3,12,0};

    LeetCode leetCode = LeetCode();
    leetCode.moveZeroes(vvcc);
    p("结果", vvcc);
    
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

