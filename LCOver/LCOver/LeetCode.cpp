//
//  LeetCode.cpp
//  LCOver
//
//  Created by 你吗 on 2021/3/23.
//

#include "LeetCode.hpp"

vector<vector<int>> LeetCode::threeSum(vector<int> &nums){
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


vector<vector<int>> LeetCode::fourSum(vector<int>& nums, int target) {
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


string LeetCode::countAndSay(int n){
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

void LeetCode::merge(vector<int>& nums1, int m, vector<int>& nums2, int n) {
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


string LeetCode::convert(string s, int numRows) {
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





int LeetCode::mySqrt(int x){
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

int LeetCode::majorityElement(vector<int>& nums){
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
ListNode* LeetCode::mergeKLists(vector<ListNode*>& lists) {
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

int LeetCode::lengthOfLongestSubstring(string s) {
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

bool LeetCode::isValid(string s){
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

bool LeetCode::hasCycle(ListNode *head) {
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
int LeetCode::maxProfit(vector<int>& prices) {
    int len = (int)prices.size();
    vector<int> nums;
    int ans = 0;
    int count = 0;
    //只能买卖一次
    for (int i = 1; i < len; i++) {
        nums.push_back(prices[i] - prices[i-1]);
        count += nums[i-1];
    }
    if(count <= 0) return 0;
    int l = 0,r = (int)nums.size() - 1;
    while (l < r) {
        if(nums[l] > 0){
            
        }
        int x = nums[l] > 0 ? count - nums[l] : count + nums[l];
    }
    
    return ans;
}

void LeetCode::rotate(vector<vector<int>>& matrix) {
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



int LeetCode::maxDepth(TreeNode* root) {
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
vector<string> LeetCode::generateParenthesis(int n) {
    string s;
    for (int i = 0; i < n; ++i) {
        s.append("(");
        s.append(")");
    }
    return {};
}

vector<vector<int>> LeetCode::subsets(vector<int>& nums) {
    vector<vector<int>> ans;
    int len = (int)nums.size();
    vector<int> temp;
//    ans.push_back({});
//    for (int i = 0; i < len; i++) {
//        int ansLen = (int)ans.size();
//        for(int j = 0; j < ansLen; j++){
//            temp = ans[j];
//            temp.push_back(nums[i]);
//            ans.push_back(temp);
//        }
//    }
//    return ans;
    //总共有 2^n -1 种组合,有 len 种类型的组合长度 , 这个是用来做位运算的那种
    int size = 1<<len;
    for (int i = 0; i < size; i++) {
        temp.clear();
        for (int j = 0; j < size; j++) {
            if(i & (1<<j)) temp.push_back(nums[j]);
        }
        ans.push_back(temp);
    }
    return ans;
}

//THINGKING
vector<int> subsetsWithDup_t;           //中间数组
vector<vector<int>> subsetsWithDup_ans; //存储答案的数组
void subsetsWithDup_dfs(int depth,vector<int> &nums){
    subsetsWithDup_ans.push_back(subsetsWithDup_t);
    for (int i = depth; i < nums.size(); i++) {
        //感觉做了很多重复操
        if(i > depth && nums[i] == nums[i-1]){
            continue;
        }
        subsetsWithDup_t.push_back(nums[i]);
        subsetsWithDup_dfs(i + 1, nums);
        subsetsWithDup_t.pop_back();
    }
}

vector<vector<int>> LeetCode::subsetsWithDup(vector<int>& nums){
    if(nums.empty()) return {};
    sort(nums.begin(),nums.end());
    subsetsWithDup_dfs(0, nums);
    return subsetsWithDup_ans;
}

vector<vector<int>> subsetsWithDup2(vector<int>& nums){
    sort(nums.begin(), nums.end());
    vector<vector<int>> ans;
    vector<int> temp;
    int len = (int)nums.size();
    int size = 1<<len;
    for (int i = 0; i < size; i++) {
        temp.clear();
        bool flag = true;
        for (int j = 0; j < len; j++) {
            if(i & (1<<j)){
                if(j>0 && nums[j] == nums[j-1] && (i >> (j-1)) & 1 == 0 ){
                    flag = false;
                    break;
                }
                temp.push_back(nums[j]);
            }
        }
        if(flag) ans.push_back(temp);
    }
    return ans;
}



void LeetCode::moveZeroes(vector<int>& nums){
    int size = (int)nums.size();
    //        for (int i = 0; i < size; i++) {
    //            if(i + 1 < size && nums[i] == 0 && nums[i + 1] != 0){
    //                swap(nums[i], nums[i+1]);
    //            }else{
    //                for (int j = i; j < size; j++) {
    //                    if(nums[j] != 0){
    //                        swap(nums[j], nums[i]);
    //                        if(j == size - 1) return;
    //                        break;
    //                    }else if(j == size - 1){
    //                        return;
    //                    }
    //                }
    //            }
    //        }
    
    int j = 0;
    for (int i = 0; i < size; i++) {
        if(nums[i] != 0){
            nums[j] = nums[i];
            if(i != j) nums[i] = 0;
            j++;
        }
    }
}

ListNode* LeetCode::reverseList(ListNode* head) {
    
    //magic,魔法罢了，就看看，这种代码会被人打死
    //        for (ans = NULL; head; swap(head, ans)) {
    //            swap(ans, head->next);
    //        }
    
    //比较好理解的
    //        ListNode *curr = head;
    //        while (curr) {
    //            ListNode *next = curr->next;
    //            curr->next = ans;
    //            ans = curr;
    //            curr = next;
    //        }
    
    //递归的方法。。。慢点再理解
    if(!head || !head->next){
        return head;
    }
    ListNode *ans = reverseList(head->next);
    head->next->next = head;
    head->next = nullptr;
    return ans;
}

int LeetCode::hammingWeight(uint32_t n){
    int ans = 0;
    while(n){
        //这里n&1是为了看n最后一位是否为1，1与1==1，所以ans+1了。
        ans += n&1;
        //n向右移一位
        n >>= 1;
    }
    return ans;
    // return __builtin_popcount(n);
    
}

int LeetCode::hammingDistance(int x, int y) {
    //先异或一下，然后就变成一个数的汉明重量了
    int z = x ^ y;
    int ans = 0;
    while(z){
        ans += z&1;
        z >>= 1;
    }
    return ans;
}

//不懂这在说🔨，为什么第i位的汉明总距是 t * (n - t),t是一共有多少个0，n-t个1
int LeetCode::totalHammingDistance(vector<int>& nums){
    if(nums.empty()) return 0;
    
    int sum = 0, len = (int)nums.size();
    vector<int> cnt(32,0);
    for (auto item : nums) {
        int i = 0;
        while (item) {
            cnt[i] += (item & 0x1);
            item >>= 1;
            i++;
        }
    }
    for (auto &&k : cnt) {
        sum += k * (len - k);
    }
    return sum;
}


TreeNode* LeetCode::mergeTrees(TreeNode* root1, TreeNode* root2) {
    //这里可以简化一下的。其实。但是算了
    if(root1 && root2){
        root1->val += root2->val;
    }else if (root1 && !root2){
        root1 = root2;
        return root1;
    }else if (root2 && !root2){
        return root1;
    }else if(!root1 && !root2){
        return nullptr;
    }
    root1->left = mergeTrees(root1->left,root2->left);
    root1->right = mergeTrees(root1->right,root2->right);
   
    return root1;
}

vector<int> LeetCode::findDisappearedNumbers(vector<int>& nums){
    vector<int> ans;
    int len = (int)nums.size();
    for (int i = 0; i < len; i++) {
        //把nums[i] % len 是为了把数组中下标为nums[i]位置的数字变更大。
        //就比如 nums[0] = 4 的时候，3 % 7 = 3，下标位3的位置是已经被占用了，所以不是缺失的
        int n = (nums[i] - 1) % len;
        //让下标位3的位置加多一个 len的大小，让循环 mod 到这位置的时候也不影响到该数字的占位情况。
        nums[n] += len;
    }
    for (int i = 0; i < len; i++) {
        if(nums[i] <= len){
            ans.push_back(i+1);
        }
    }
    
    return ans;
}

bool checkSymmetric(TreeNode *left, TreeNode *right){
    //先检查两个节点是否都为空
    if(!left && !right)return true;
    //其中一个为空就不是对称
    if(!left || !right)return false;
    //如果两个变量一样，然后继续递归，按照对称性进行递归，就是从最左最右，逐渐向内内敛
    return left->val == right->val&&checkSymmetric(left->left, right->right)&&checkSymmetric(left->right, right->left);
}

bool LeetCode::isSymmetric(TreeNode* root){
    if(!root) return false;
    //这是递归的方法
    return checkSymmetric(root->left, root->right);
    
    //这是遍历的方法
//    queue<TreeNode *> queue;
//    queue.push(root->left);
//    queue.push(root->right);
//    TreeNode *lcnt,*rcnt;
//    while (!queue.empty()) {
//            lcnt = queue.front();
//            queue.pop();
//            rcnt = queue.front();
//            queue.pop();
//
//            if(!lcnt && !rcnt){
//                continue;
//            }
//            if((!lcnt || !rcnt)|| lcnt->val != rcnt->val){
//                return false;
//            }
//        //每次先插入最左和最右节点，按照对称性来插入
//            queue.push(lcnt->left);
//            queue.push(rcnt->right);
//            queue.push(lcnt->right);
//            queue.push(rcnt->left);
//    }
//    return true;
}

ListNode* LeetCode::getIntersectionNode(ListNode *headA, ListNode *headB){
    if (!headA || !headB) {
        return NULL;
    }
    ListNode *you = headA, *she = headB;
    while (you != she) { // 若是有缘，你们早晚会相遇
        you = you ? you->next : headB; // 当你走到终点时，开始走她走过的路
        she = she ? she->next : headA; // 当她走到终点时，开始走你走过的路
    }
    // 如果你们喜欢彼此，请携手一起走完剩下的旅程（将下面这个 while 块取消注释）。
    // 一路上，时而你踩着她的影子，时而她踩着你的影子。渐渐地，你变成了她，她也变
    // 成了你。
    /* while (she) {
        you = she->next;
        she = you->next;
    } */
    return you;
}

void makeheapify(vector<int> &a, int start, int end){
    int dad = start;
    int son = dad * 2 + 1;
    while (son <= end) {
        //从子节点中选出最大的一个
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

int LeetCode::findKthLargest(vector<int>& nums, int k){
    int len = (int)nums.size();
    //需要在尽量不排序的情况下做
    for (int i = len / 2 -1 ; i >= 0; i--) {
        makeheapify(nums, i, len - 1);
    }
    for (int i = len - 1; i > 0; i--){
        swap(nums[0], nums[i]);
        //排了len - i 次后就可以返回了，因为最小堆的特性就是先排后面的
        if(k == len - i){
            break;
        }
        makeheapify(nums, 0, i - 1);
    }
    return nums[len - k];
}

vector<int> LeetCode::reversePrint(ListNode *head){
    // 这是用栈或者数组的方式存
//    vector<int> ans, temps;
//    while (head) {
//        temps.push_back(head->val);
//        head = head->next;
//    }
//    int len = (int)temps.size();
//    for (int i = len - 1; i >= 0; i--) {
//        ans.push_back(temps[i]);
//    }
//    return ans;
    
    // 这是用倒置链表的方式
    ListNode *p = NULL, *q = head;
    vector<int> ans;
    while (q) {
        ListNode *temp = q->next;
        q->next = p;
        p = q;
        q = temp;
    }
    while (p) {
        ans.push_back(p->val);
        p = p->next;
    }
    return ans;
}

string LeetCode::replaceSpace(string s){
    string ans = "";
    for (char c : s) {
        if(c == ' '){
            ans.append("%20");
        }else{
            ans.push_back(c);
        }
    }
    return ans;
}

uint32_t LeetCode::reverseBits(uint32_t n) {
    // 建议这一段背下来。有点变态
    const uint32_t M1 = 0x55555555; // 01010101010101010101010101010101
    const uint32_t M2 = 0x33333333; // 00110011001100110011001100110011
    const uint32_t M4 = 0x0f0f0f0f; // 00001111000011110000111100001111
    const uint32_t M8 = 0x00ff00ff; // 00000000111111110000000011111111
    n = n >> 1 & M1 | (n & M1) << 1;
    n = n >> 2 & M2 | (n & M2) << 2;
    n = n >> 4 & M4 | (n & M4) << 4;
    n = n >> 8 & M8 | (n & M8) << 8;
    return n >> 16 | n << 16;


    
//    uint32_t ans = 0;
//    int k = 32;
//    while (n) {
//        if(n&1){
//            //取第k位加1
//            ans |= (1<<(k-1));
//        }
//        k--;
//        n >>= 1;
//    }
//    return ans;
}



void LeetCode::flatten(TreeNode* root) {
    if(!root) return;
    // 先后序遍历二叉树
    //这里不需要判空是因为当前是从底递归回来的，所以空的节点已经直接返回
    flatten(root->left);
    flatten(root->right);
    //然后进行交换两个左右节点
    //并且记录下当前右子树的根节点
    TreeNode *temp = root->right;
    root->right = root->left;
    root->left = NULL;
    //这时候这个子树已经被接长过
    //所以要找到这个子树的最后一个节点
    while (root->right) {
        root = root->right;
    }
    //将记录的右子树的根节点拼接上去
    root->right = temp;
}



//首先，先序遍历数组中第一个数肯定是根结点
//但是不知道左子树中会有多少个结点，所以需要用中序遍历数组来决定有多少个结点
//所以需要在中序数组中找到根结点的位置
//l1
//3, 9, 20, 15, 7
//l2 i          r2
//9, 3, 15, 20, 7
unordered_map<int, int> buildTree_index;
TreeNode* createTree(vector<int> numsA, vector<int> numsB,int l1,int r1,int l2,int r2){
    if(l1 > r1) return NULL;
    int i = buildTree_index[numsA[l1]];
    TreeNode *root = new TreeNode(numsB[i]);
    root->left = createTree(numsA, numsB, l1+1, l1+i-l2, l2, i-1);
    root->right= createTree(numsA, numsB, l1+i-l2+1, r1, i+1, r2);
    return root;
}

TreeNode* LeetCode::buildTree(vector<int>& preorder, vector<int>& inorder) {
    int len = (int)preorder.size();
    //将中序数组存在hash_map中，方便寻找某节点的位置
    for(int i = 0; i < len; i++){
        buildTree_index[inorder[i]] = i;
    }
    return createTree(preorder, inorder, 0, len - 1, 0, len - 1);
}

int LeetCode::climbStairs(int n) {
        if(n == 1 || n == 2){
            return n;
        }
        // 用递归的方式
        // return climbStairs(n-1) + climbStairs(n-2);

        // 用dp，滑动数组
        // int a[n+1];
        // a[0] = 1;
        // a[1] = 2;
        // for(int i = 2; i < n; i++){
        //     a[i] = a[i-1] + a[i-2];
        // }
        // return a[n-1];

        //这里甚至只需要记录前两个状态就好了，数组都不需要了
        int first = 1, second = 2;
        int third = 0;
        for(int i = 2; i < n; i++){
            third = first + second;
            first = second;
            second = third;
        }
        return third;
    }

// 建议直接拉黑这种题目
int LeetCode::sumNums(int n) {
    // 实质就是 n*(n + 1) / 2 的换一种写法
    // 这里使用bool 数组也可以
   char arr[n][n+1];
   return (int)sizeof(arr)>>1;
}

vector<int> LeetCode::levelOrder(TreeNode *root){
    vector<int> ans;
    if(!root) return ans;
    queue<TreeNode *> queue;
    queue.push(root);
    ans.push_back(root->val);
    TreeNode * temp;
    int size = 0;
    while(!queue.empty()){
        size = (int)queue.size();
        for (int i = 0; i < size; i++) {
            temp = queue.front();
            if(temp->left){
                queue.push(temp->left);
                ans.push_back(temp->left->val);
            }
            if(temp->right){
                queue.push(temp->right);
                ans.push_back(temp->right->val);
            }
            queue.pop();
        }
    }
    return ans;
}

vector<vector<int>> LeetCode::levelOrderI(TreeNode* root) {
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


vector<vector<int>> levelOrderII(TreeNode* root) {
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


int LeetCode::clumsy(int N){
    int ans = 0;
    int temp = N;
    N--;
    int count = (N / 4)+ 1;
    for (int j = 0; j < count; j++) {
        int i = 0;
        if(i == 0 && N>=1){
            temp *= N;
            N--;
            i++;
        }
        if(i == 1 && N>=1) {
            temp /= N;
            N--;
            i++;
        }
        if(i == 2 && N>=1){
            ans += N;
            N--;
            i++;
        }
        if(j >= 1){
            ans -= temp;
        }else{
            ans += temp;
        }
        temp = N;
        if(i == 3 && N>=1){
            N--;
        }
    }
    return ans;
    
    //分类找规律
    if(N == 1) return 1;
    else if(N == 2) return 2;
    else if(N == 3) return 6;
    else if(N == 4) return 7;
    
    if(N % 4 == 0)return N;
    else if (N % 4 <= 2) return N + 2;
    else return N-1;

}
//
vector<int> LeetCode::exchange(vector<int>& nums) {
    if (nums.size() <= 1) {
        return nums;
    }
    // 从左右开始遍历？
    int i = 0 , j = (int)nums.size() - 1;
    while(i<j){
        if(i < j && nums[j] % 2 == 0){
            j--;
        }
        if(i < j && nums[i] % 2) {
            i++;
        }
        if(nums[i] % 2 == 0 && nums[j] % 2){
            swap(nums[i], nums[j]);
            i++;
            j--;
        }
    }
    
    return nums;
}

TreeNode* LeetCode::mirrorTree(TreeNode* root) {
    if(!root) return NULL;
    mirrorTree(root->left);
    mirrorTree(root->right);
    swap(root->left, root->right);
    return root;
}


ListNode* LeetCode::reverseKGroup(ListNode* head, int k) {
    if (k == 1 || !head) {
        return head;
    }
    //统计当前节点是否还够k个，不够就立刻返回
    ListNode*q = head;
    int count = 0;
    while (q) {
        count++;
        q = q->next;
    }
    if(count < k) return head;
    //反转链表的k个节点
    ListNode *p = head;
    ListNode *ans = NULL;
    int index = k;
    while(index-- && p){
        ListNode *t = p->next;
        p->next = ans;
        ans = p;
        p = t;
    }
    //获取到ans的末指针
    ListNode *s = ans;
    while (s->next) {
        s = s->next;
    }
    //递归完成剩余的链表
    s->next = reverseKGroup(p, k);
    return ans;
}

ListNode* LeetCode::getKthFromEnd(ListNode* head, int k) {
    ListNode* q = head;
    for(int i = 0; i < k; i++)
    q = q->next;
    if(!q) return head;
    while(q){
        q = q->next;
        head = head->next;
    }
    return head;
}

//TODO
//int LeetCode::trap(vector<int>& height) {
//    if(height.empty()) return 0;
//    int sum = *height.begin(); int curIndex = 0;
//    stack<int> stack;
//    for (int i = 1; i < height.size(); i++) {
//        if(height[curIndex] > height[i]){
//            sum = sum + height[curIndex] - height[i];
//        }else{
//            //sum = sum + height[curIndex] - height[i - 1];
//            stack.push(sum);
//            sum = 0;
//            curIndex = i;
//        }
//    }
//    int ans = 0;
//    for (int i = 0; i < stack.size(); i++) {
//        ans += stack.top();
//        stack.pop();
//    }
//    
//    int i = 0; j = (int)height.size()-1;
//    while (i<j) {
//        
//    }
//    return ans;
//}

ListNode* LeetCode::swapPairs(ListNode* head) {
    if(!head || !head->next) return head;
    ListNode *ans = NULL,*p = head;
    int len = 2;
    while (len-- && p){
        ListNode *t = p->next;
        p->next = ans;
        ans = p;
        p = t;
    }
    ans->next->next = swapPairs(p);
    return ans;
}

int LeetCode::removeDuplicates(vector<int>& nums){
    int len = (int)nums.size();
    if(len < 2) return len;
    //双指针指向
    int slow = 2;
    int fast = 2;
    while (fast < len) {
        if(nums[fast] != nums[slow - 2]){
            nums[slow] = nums[fast];
            slow++;
        }
        fast++;
    }
    return slow;
}
