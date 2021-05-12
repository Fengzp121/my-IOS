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


ListNode* LeetCode::mergeKLists(vector<ListNode*>& lists) {
    if(lists.size() == 0) return nullptr;
    ListNode *fastlist = NULL;
    ListNode *slowlist = NULL;
    int index = 0;
    for (ListNode *list : lists) {
        index++;
        if(list){
            fastlist = list->next;
            slowlist = list;
            break;
        }
    }
    for(int i = index; i < lists.size(); ++i){
        ListNode *currentList = lists[i];
        if(currentList == nullptr){
            continue;
        }
        ListNode *tflist = fastlist;
        ListNode *tslist = slowlist;
        while (currentList) {
            if((!tflist || currentList->val <= tflist->val) && currentList->val >= tslist->val){
                ListNode *temp = tslist->next;
                tslist->next = new ListNode(currentList->val);
                tslist->next->next = temp;
                tflist = tslist->next;
                currentList = currentList->next;
            }else{
                tflist = tflist->next;
                tslist = tslist->next;
            }
            
        }
        fastlist = slowlist->next;
    }
    return slowlist;
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
//7,1,5,3,6,4
int LeetCode::maxProfit(vector<int>& prices) {
    int inf = 1e9;
    int minprice = inf, maxprofit = 0;
    for (int price: prices) {
        //最高点卖出
        maxprofit = max(maxprofit, price - minprice);
        //最低点买入
        minprice = min(price, minprice);
    }
    return maxprofit;
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

string generateParenthesis_dfs(){
    
    return "";
}

vector<string> LeetCode::generateParenthesis(int n) {
    vector<string> ans;
    string s = "()";
    ans.push_back(s);
    int sum = 2;
    for(int i = 1; i < n; i++){
        vector<string> temp_ans = ans;
        ans.clear();
        for(string temp_s : temp_ans){
            int j = 0;
            for (int k = 0; k < sum; k++) {
                string t = temp_s;
                t.insert(j, "()");
                ans.push_back(t);
                j++;
            }
        }
        sum++;
    }
    return ans;
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
    //这是107的反转
//    vector<vector<int>> ans;
//    int v_size = (int)vvec.size();
//    for(int i = 0; i < v_size; i++){
//        ans.push_back(vvec.back());
//        vvec.pop_back();
//    }
//    return ans;
    return vvec;
}

vector<vector<int>> LeetCode::levelOrderIII(TreeNode* root) {
    vector<vector<int>> ans;
    if(!root) return ans;
    vector<int> temp;
    deque<TreeNode *> deque;
    deque.push_back(root);
    bool flag = false;
    while (!deque.empty()) {
        int size = (int)deque.size();
        for (int i = 0; i < size; i++) {
            if(flag){
                TreeNode *tempNode = deque.front();
                if(tempNode->right){deque.push_back(tempNode->right);}
                if(tempNode->left){deque.push_back(tempNode->left);}
                temp.push_back(tempNode->val);
                deque.pop_front();
            }else{
                TreeNode *tempNode = deque.back();
                if(tempNode->left){ deque.push_front(tempNode->left);}
                if(tempNode->right){deque.push_front(tempNode->right);}
                temp.push_back(tempNode->val);
                deque.pop_back();
            }
        }
        flag = !flag;
        ans.push_back(temp);
        temp.clear();
    }
    
    return ans;
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

//这只能用在生序排序数组中，这种旋转数组还得加工一下
//如果能找到一某段被旋转后的序列，就可以直接用这段
//但是怎么找到旋转的序列呢
int quickSearch(vector<int>&nums,int target,int low,int high){
    int maxL = high;
    while (low <= high) {
        int middle = (low + high) / 2;
        if(target == nums[middle]){
            return middle;
        }
        // 先看看是否夹杂旋转段？
        if(nums[0] <= nums[middle]){
            //然后看target的位置决定取左边段还是右边段
            //如果target比mid小并且target比起初位置大，就代表target在mid左段
            if(target < nums[middle] && nums[0] <= target)
                high = middle - 1;
            else
                low = middle + 1;
        }else{
            if(target > nums[middle] && nums[maxL] >= target)
                low = middle + 1;
            else
                high = middle - 1;
        }
    }
    return -1;
}

int LeetCode::searchI(vector<int>& nums, int target){
//    for (int i = 0; i < nums.size(); i++) {
//        if(nums[i] == target){
//            return i;
//        }
//    }
    return quickSearch(nums, target, 0,(int)nums.size() - 1);
}

bool LeetCode::searchII(vector<int>& nums, int target){
    //    for (int i = 0; i < nums.size(); i++) {
    //        if(nums[i] == target){
    //            return true;
    //        }
    //    }
    //    return false;
    int n = (int)nums.size();
    if (n == 0) {
        return false;
    }
    if (n == 1) {
        return nums[0] == target;
    }
    int l = 0, r = n - 1;
    while (l <= r) {
        int mid = (l + r) / 2;
        if (nums[mid] == target) {
            return true;
        }
        //多了一步去重
        if (nums[l] == nums[mid] && nums[mid] == nums[r]) {
            ++l;
            --r;
            //这里变成用l为index作为衡量下标
        } else if (nums[l] <= nums[mid]) {
            if (nums[l] <= target && target < nums[mid]) {
                r = mid - 1;
            } else {
                l = mid + 1;
            }
        } else {
            if (nums[mid] < target && target <= nums[n - 1]) {
                l = mid + 1;
            } else {
                r = mid - 1;
            }
        }
    }
    return false;
}

int LeetCode::findMinI(vector<int>& nums){
    int len = (int)nums.size();
    int l = 0, r = len - 1;
    int mid = 0;
    while (l < r) {
        mid = (l + r) / 2;
        if(nums[mid] < nums[r]){
            r = mid;
        }else{
            l = mid + 1;
        }
        
    }
    return nums[l];
}

int LeetCode::findMinII(vector<int>& nums){
    int l = 0, r = (int)nums.size() - 1;
    int mid = 0;
    while (l < r) {
        mid = (l + r )/ 2;
        //去重处理，如果两端和中心都是一样的。
        if(nums[mid] == nums[l] && nums[l] == nums[r]) {
            l++; r--;
            continue;
        }
        //这里比I多了一个=号，因为可能会有重复的连续的出现
        if(nums[mid] <= nums[r]){
            r = mid;
        }else{
            l = mid + 1;
        }
    }
    return nums[l];
}

bool LeetCode::isUgly(int n) {
    if(n <= 0) return false;
    while (n != 1) {
        if(n % 2 == 0 || n % 3 == 0 || n % 5 == 0){
            if (n % 2 == 0) {
                n /= 2;
            }
            if (n % 3 == 0){
                n /= 3;
            }
            if (n % 5 == 0){
                n /= 5;
            }
        }else{
            return false;
        }
    }
    return true;
}

int LeetCode::nthUglyNumber(int n) {
//    int ans = 1;
//    int count = 1;
//    vector<int> uglyFather = {2,3,5};
//    queue<int> uqueue;//是用队列，但是要用优先队列。这波啊，这波是对stl不够熟悉
//    for(int i = 0; i < n; i++){
//        for (int j = 0; j < uglyFather.size(); j++) {
//
//        }
//    }
//    return 1;
    
    vector<int> dp(n + 1);
    dp[1] = 1;
    int p2 = 1, p3 = 1, p5 = 1;
    for (int i = 2; i <= n; i++) {
        int num2 = dp[p2] * 2, num3 = dp[p3] * 3, num5 = dp[p5] * 5;
        dp[i] = min(min(num2, num3), num5);
        if (dp[i] == num2) {
            p2++;
        }
        if (dp[i] == num3) {
            p3++;
        }
        if (dp[i] == num5) {
            p5++;
        }
    }
    return dp[n];
}

//TODO:这个比丑数2复杂
int LeetCode::nthUglyNumber(int n, int a, int b, int c) {
    vector<int> dp(n+1);
    dp[0] = 1;
    int pa = 0, pb = 0, pc = 0;
    for (int i = 1; i <= n; i++) {
        int numa = dp[pa] * a, numb = dp[pb] * b, numc = dp[pc] * c;
        int numaa = dp[pa] + a, numbb = dp[pb] + b, numcc = dp[pc] + c;
        dp[i] = min(min(min(numa, numb), numc),min(min(numaa, numbb), numcc));
        if (dp[i] == numa || dp[i] == numaa) {
            pa++;
        }
        if (dp[i] == numb || dp[i] == numbb) {
            pb++;
        }
        if (dp[i] == numc || dp[i] == numcc) {
            pc++;
        }
    }
    return dp[n];
}

string LeetCode::largestNumber(vector<int>& nums) {
    string ans = "";
    //先来一个冒泡，其实可以先将数组转换成string数组，然后再进行冒泡排序了，减少to_string的耗时
    for (int i = 0; i < nums.size(); i++) {
        for (int j = i + 1; j < nums.size(); j++) {
            string a = to_string(nums[i]) + to_string(nums[j]);
            string b = to_string(nums[j]) + to_string(nums[i]);
            if (stol(a) < stol(b)) {
                swap(nums[j], nums[i]);
            }
        }
    }
    for (int i = 0; i < nums.size(); i++) {
        if(nums[0] == 0) return "0";
        ans.append(to_string(nums[i]));
    }
    return ans;
}


//中序遍历啊，卧槽。唉还是太菜了。
//每次关于二叉树的要想起dfs（深度优先、中后遍历），bfs（广度优先，前序遍历）
void minDiffInBST_dfs(TreeNode *root,int &ans,int &pre){
    //这里使用的是中序遍历
    if(!root) return;
    minDiffInBST_dfs(root->left,ans,pre);
    if(pre == -1){
        pre = root->val;
    }else{
        ans = min(ans,root->val - pre);
        pre = root->val;
    }
    minDiffInBST_dfs(root->right,ans, pre);
}

int LeetCode::minDiffInBST(TreeNode *root){
    int ans = INT_MAX, pre = -1;
    minDiffInBST_dfs(root,ans,pre);
    return ans;
}

int LeetCode::arrangeCoins(int n) {
//    int ans = 0;
//    while(n >= 1){
//        n -= ans;
//        ans++;
//    }
//    return ans;
    
    
    return (int)(-0.5+sqrt(0.25+2*(long long)n));
}
// 2sum = n^2 + n;


//TODO:这种方法不行，因为数组中最大值的位置是不稳定的，所以可能造成有一段数组还在山峰中，所以还是分类讨论
int midSearch(bool flag, int low, int high, int target, vector<int> &mountainArr){
    while(low <= high){
        int mid = (low + high) / 2;
        int mid_value = mountainArr[mid];
        if(mid_value == target){
            return mid;
        }
        if(flag){
            if(mid_value < target){
                low = mid + 1;
            }else{
                high = mid - 1;
            }
        }else{
            if(mid_value > target){
                high = mid - 1;
            }else{
                low = mid + 1;
            }
        }
        
    }
    return -1;
}

int LeetCode::findInMountainArray(int target, vector<int> &mountainArr) {
    int ans = -1;
    //要分别找两边，可以先找左边的，如果左边存在就可以返回了
    int mid_index = ((int)mountainArr.size() - 1) / 2;
    int low = 0;
    int high = mid_index;
    //这是左边的循环
    ans = midSearch(false,low,high,target,mountainArr);
    if(ans != -1) return ans;
    //这是右边的循环
    low = mid_index + 1;
    high = (int)mountainArr.size() - 1;
    ans = midSearch(true,low,high,target,mountainArr);
    return ans;
}


int LeetCode::rob(vector<int>& nums) {
    int length = (int)nums.size();
    if (length == 1) {
        return nums[0];
    } else if (length == 2) {
        return max(nums[0], nums[1]);
    }
    int first = nums[0],second = max(nums[0], nums[1]);
    //这里可以从0或1开始取，取到都是n
    for (int i = 2; i < nums.size(); i++) {
        int t = second;
        second = max(first + nums[i], second);
        first = t;
    }
    return second;
}

int robIIRange(int start ,int end, vector<int> &nums){
    //每隔一个偷一个,first是存第一个开始的，second是存第二个开始的。
    //每一次都比较是fisrt 总和大还是 second的大
    int first = nums[start];
    int second = max(nums[start], nums[start + 1]);
    for (int i = start + 2; i <= end; i++) {
        int temp = second;
        second = max(first + nums[i], second);
        first = temp;
    }
    return second;
}


int LeetCode::robII(vector<int> &nums){
    int length = (int)nums.size();
    if (length == 1) {
        return nums[0];
    } else if (length == 2) {
        return max(nums[0], nums[1]);
    }
    //0开始偷，偷到n - 2
    //1开始偷，偷到n - 1
    return max(robIIRange(0, length - 2, nums), robIIRange(1, length - 1,nums));
}

//int first = 0;
//int secode = 0;
//void robIII_dfs(TreeNode *root){
//    if(!root)return;
//    robIII_dfs(root->left);
//    robIII_dfs(root->right);
//    int first = root->val;
//    
//}
//int LeetCode::robIII(TreeNode *root){
//    //每隔一层取点
//    robIII_dfs(root);
//    return 0;
//}



// 记忆化搜索存储状态的数组
// -1 表示 false，1 表示 true，0 表示未计算
int isScramble_memo[30][30][31];
string isScramble_s1, isScramble_s2;

bool checkIfSimilar(int i1, int i2, int length) {
    unordered_map<int, int> freq;
    for (int i = i1; i < i1 + length; ++i) {
        ++freq[isScramble_s1[i]];
    }
    for (int i = i2; i < i2 + length; ++i) {
        --freq[isScramble_s2[i]];
    }
    if (any_of(freq.begin(), freq.end(), [](const auto& entry) {return entry.second != 0;})) {
        return false;
    }
    return true;
}

// 第一个字符串从 i1 开始，第二个字符串从 i2 开始，子串的长度为 length，是否和谐
bool isScramble_dfs(int i1, int i2, int length) {
    if (isScramble_memo[i1][i2][length]) {
        return isScramble_memo[i1][i2][length] == 1;
    }
    
    // 判断两个子串是否相等
    if (isScramble_s1.substr(i1, length) == isScramble_s2.substr(i2, length)) {
        isScramble_memo[i1][i2][length] = 1;
        return true;
    }
    
    // 判断是否存在字符 c 在两个子串中出现的次数不同
    if (!checkIfSimilar(i1, i2, length)) {
        isScramble_memo[i1][i2][length] = -1;
        return false;
    }
    
    // 枚举分割位置
    for (int i = 1; i < length; ++i) {
        // 不交换的情况
        if (isScramble_dfs(i1, i2, i) && isScramble_dfs(i1 + i, i2 + i, length - i)) {
            isScramble_memo[i1][i2][length] = 1;
            return true;
        }
        // 交换的情况
        if (isScramble_dfs(i1, i2 + length - i, i) && isScramble_dfs(i1 + i, i2, length - i)) {
            isScramble_memo[i1][i2][length] = 1;
            return true;
        }
    }
    
    isScramble_memo[i1][i2][length] = -1;
    return false;
}

bool LeetCode::isScramble(string s1, string s2) {
    memset(isScramble_memo, 0, sizeof(isScramble_memo));
    isScramble_s1 = s1;
    isScramble_s2 = s2;
    return isScramble_dfs(0, 0, (int)s1.size());
}

int LeetCode::removeDuplicates(vector<int>& nums) {
    if(nums.empty()) return 0;
    int slow = 0;
    for (int fast = 1; fast < nums.size(); fast++){
        if(nums[fast] != nums[slow]){
            slow++;
            nums[slow] = nums[fast];
        }
    }
    return slow + 1;
}

string LeetCode::truncateSentence(string s, int k) {
    int count = 0;
    int i;
    for(i = 0; i < s.size(); i++){
        if(s[i] == ' '){
            count++;
            if(count == k){
                return s.substr(0,i);
            }
        }
    }
    return s.substr(0,i+1);
}

vector<int> LeetCode::findingUsersActiveMinutes(vector<vector<int>>& logs, int k) {
    //我感觉这个min的意思是在某个时分中进行操作。而不是操作了多少分钟的意思
    //所以就是统计多少个不相同的分时。干。。。
    //用hash_map的key存用户id，value用一个set进行去重
    unordered_map<int,unordered_set<int>> umap;
    vector<int> ans(k);
    for (auto& log : logs) {
        umap[log[0]].insert(log[1]);
    }
    for (auto iter = umap.begin(); iter != umap.end() ; ++iter) {
        ans[iter->second.size() - 1] += 1;
    }
    return ans;
    //{{0,5},{1,2},{0,2},{0,5},{1,3}}
}

//TODO:找到nums中与target最接近的值，这里要用贪心算法的。。
int minAbsoluteSumDiff_search(vector<int>& nums, int target){
    int low = 0, high = (int)nums.size() - 1;
    int temp = INT32_MAX;
    while (low <= high) {
        //感觉这边用小的大的都可以啊
        int mid = (low + high) / 2;
        if(abs(target - nums[mid]) < temp){
            
        }
    }
    return low;
}

int LeetCode::minAbsoluteSumDiff(vector<int>& nums1, vector<int>& nums2) {
    //对第一个数组进行排序吧。。。然后进行二分查找。
    sort(nums1.begin(), nums1.begin());
//    sort(nums2.begin(), nums2.begin());
    int ans = 0;
    for (int i = 0; i < nums1.size(); i++) {
        
    }
    return ans;
}

int LeetCode::removeElement(vector<int>& nums, int val){
    int slow = 0;
    for (int fast = 0; fast < nums.size(); fast++) {
        if(nums[fast] == val){
            nums[slow] = nums[fast];
            slow++;
        }
    }
    return slow;
}

bool LeetCode::searchMatrix(vector<vector<int>>& matrix, int target){
    if(matrix.empty()) return false;
    vector<int> temp = matrix.front();
    //先对矩阵第一个元素进行遍历
    for(int i = 1; i < matrix.size(); i++){
        //如果这行大于等于target。就代表，要么在该行首位，要么在上一行
        if(matrix[i].front() >= target){
            if(matrix[i].front() == target){
                return true;
            }
            temp = matrix[i-1];
            break;
        }else{
            //如果都不是就每一行都重新赋值，因为有可能在最后一行大的里面，上面的条件赋值不了
            temp = matrix[i];
        }
    }
    for(int i = 0; i < temp.size(); i++){
        if(temp[i] == target) return true;
    }
    return false;
}

int LeetCode::subarraySum(vector<int>& nums, int k) {
    int ans = 0;
    
    //暴力法
//    for(int i = 0; i < nums.size(); i++){
//        int count = 0;
//        for (int j = i; j < nums.size(); j++) {
//            count += nums[j];
//            if(count == k){
//                ans++;
//            }
//        }
//    }
    // 1  1  1
    // k = 2
    // pre = 3
    // ans = 2
    // map = {0,1},{1,1},{2,1},{3,1}
    //前缀和 + 哈希表
    unordered_map<int, int> umap;
    umap[0] = 1;
    int pre = 0;
    for (int i = 0; i < nums.size(); i++) {
        //记录前缀和
        pre += nums[i];
        //当某个 前缀和-k 的数已经出现过的时候，就代表有一个连续数组的和为k了
        //所以要把ans加该 前缀和-k 的统计次数
        if(umap[pre - k]){
            ans += umap[pre - k];
        }
        //加入新的前缀和
        umap[pre] += 1;
    }
    return ans;
}

bool LeetCode::isValidSudoku(vector<vector<string>>& board) {
    //这种是相对暴力的方法，可以使用一个两层for搞定的。
    //但是需要三个hashmap
    
    //先遍历横的
    unordered_map<string, int> row_map;
    unordered_map<string, int> col_map;
    unordered_map<string, int> umap;
    for(int i = 0; i < 9; i++){
        for (int j = 0; j < 9; j++) {
            if(board[i][j] == "."){
                continue;
            }
            if(umap[board[i][j]]) return false;
            else umap[board[i][j]] = 1;
        }
        umap.clear();
    }
    umap.clear();
    //再遍历竖的
    for(int i = 0; i < 9; i++){
        for (int j = 0; j < 9; j++) {
            if(board[j][i] == "."){
                continue;
            }
            if(umap[board[j][i]]) return false;
            else umap[board[j][i]] = 1;
        }
        umap.clear();
    }
    umap.clear();
    //再遍历九宫格的
    for(int i = 0; i < 9; i++){
        int c = i / 3;
        int y = i % 3;
        for (int j = c * 3; j < 3 + (c * 3); j++) {
            for(int k = y * 3; k < 3 + (y * 3); k++){
                if(board[j][k] == "."){
                    continue;
                }
                if(umap[board[j][k]]) return false;
                else umap[board[j][k]] = 1;
            }
        }
        umap.clear();
    }
    return true;
}

int LeetCode::strStr(string haystack, string needle) {
    int h_count = (int)haystack.size();
    int n_count = (int)needle.size();
    if(n_count == 0) return 0;
    vector<int> v(n_count);
    for (int i = 1, j = 0; i < n_count; i++) {
        while (j > 0 && needle[i] != needle[j]) {
            j = v[j - 1];
        }
        if (needle[i] == needle [j]) {
            j++;
        }
    }
    for (int i = 0, j = 0; i < h_count; i++){
        while (j > 0 && haystack[i] != needle[j]) {
            j = v[j - 1];
        }
        if (haystack[i] == needle[j]) {
            j++;
        }
        if (j == n_count) {
            return i - n_count + 1;
        }
    }
    return -1;
}

bool LeetCode::isPalindrome(ListNode *head){
    ListNode *p = NULL, *fast = head, *slow = head;
    //找到链表中间点
    while (fast){//find mid node
        slow = slow->next;
        //这个三元表达式有点骚啊
        fast = fast->next ? fast->next->next: fast->next;
    }
    while (slow) {
        ListNode *temp = slow->next;
        slow->next = p;
        p = slow;
        slow = temp;
    }
    while (p) {
        if(p->val != head->val){
            return false;
        }
        p = p->next;
        head = head->next;
    }
    return true;
}


//和爬楼梯类似
int LeetCode::numDecodings(string s) {
    //这三个东西就是状态，
    //a 是用两个数做解码时的状态，
    //b 是单个数做解码时的状态，
    //c 是总数当前i位的状态，就是总数
    int a = 0, b = 1, c = 0;
    int len = (int)s.size();
    //要用状态转移啊。。。
    
    for (int i = 1; i <= len; i++) {
        c = 0;
        //当就是第第一位不是0⃣️的时候，就记录一次
        if(s[i-1] != 48){
            c += b;
        }
        // 当不超过26并且第二位不是0⃣️的时候也记录一次
        if(i > 1 && s[i-2] != 48 && ((s[i-2] - 48) * 10 + (s[i-1]-48) <= 26)){
            c += a;
        }
        tie(a,b) = {b,c};
    }
    return c;
}

// 这一题也可以用一个数组存放中序遍历的结果，然后遍历数组组成一个答案
// 这里使用了原地更改的方法
void inorder(TreeNode *node, TreeNode*& ans) {
        if (node == nullptr) return;
    //先遍历右子树，因为搜索🌲右边比较大。
        inorder(node->right, ans);
    //这是为了吧根结点也弄进去
        node->right = ans;
        ans = node;
    //然后遍历左子树
        inorder(node->left, ans);
    //遍历完之后就将左节点致空
        node->left = nullptr;
}

TreeNode* LeetCode::increasingBST(TreeNode* root) {
    TreeNode* ans = nullptr;
    inorder(root, ans);
    return ans;
}

int LeetCode::shipWithinDays(vector<int>& weights, int D) {
    // 确定二分查找左右边界
    int left = *max_element(weights.begin(), weights.end());    //找到包裹中最大的货
    int right = accumulate(weights.begin(), weights.end(), 0);  //这是算的累加
    //然后尝试在这个中找最大的载货量
    while (left < right) {
        int mid = (left + right) / 2;
        // need 为需要运送的天数
        // cur 为当前这一天已经运送的包裹重量之和
        int need = 1, cur = 0;
        for (int weight: weights) {
            if (cur + weight > mid) {
                ++need;
                cur = 0;
            }
            cur += weight;
        }
        if (need <= D) {
            right = mid;
        }else {
            left = mid + 1;
        }
    }
    return left;
}

//我是🐷
double LeetCode::findMedianSortedArrays(vector<int>& nums1, vector<int>& nums2){
    int a_len = (int)nums1.size();
    int b_len = (int)nums2.size();
    int len = a_len + b_len;
    vector<int> ans_s;
    int i = 0, j = 0;
    //😂合并数组
    while(i < a_len || j < b_len){
        if(i < a_len && j == b_len){
            ans_s.push_back(nums1[i]);
            i++;
            continue;
        }
        if(j < b_len && i == a_len){
            ans_s.push_back(nums2[j]);
            j++;
            continue;
        }
        if(nums1[i] < nums2[j]){
            ans_s.push_back(nums1[i]);
            i++;
            continue;
        }
        if(nums1[i] > nums2[j]){
            ans_s.push_back(nums2[j]);
            j++;
            continue;
        }
        if(nums1[i] == nums2[j] && i < a_len && j < b_len){
            ans_s.push_back(nums1[i]);
            ans_s.push_back(nums2[j]);
            i++;
            j++;
        }
    }
    //取中位数
    double ans = 0;
    if(len % 2 == 0){
        ans = (double)ans_s[len/2 - 1] + (double)ans_s[len/2];
        ans /= 2;
    }else{
        ans = ans_s[len/2];
    }
    return ans;
}



int LeetCode::rangeSumBST(TreeNode* root, int low, int high) {
    //这题好像，bfs和dfs都可以，但是dfs还可以再优化，因为这是搜索树，如果小于或者大于范围了，可以不再递归
    //BFS
//    int ans = 0;
//    queue<TreeNode *> queue;
//    queue.push(root);
//    while (!queue.empty()) {
//        int size = (int)queue.size();
//        for (int i = 0; i < size; i++) {
//            TreeNode *temp = queue.front();
//            if(temp->val >= low && high >= temp->val){
//                ans += temp->val;
//            }
//            if(temp->left) queue.push(temp->left);
//            if(temp->right)queue.push(temp->right);
//            queue.pop();
//        }
//    }
//    return ans;
    
    //DFS
    if(!root) return 0;
    if(root->val > high) return rangeSumBST(root->left, low, high);
    if(root->val < low) return rangeSumBST(root->right, low, high);
    return root->val + rangeSumBST(root->left, low, high) + rangeSumBST(root->right, low, high);
}




vector<double> LeetCode::averageOfLevels(TreeNode* root) {
    vector<double> ans;
    if(!root) return ans;
    queue<TreeNode *> queue;
    queue.push(root);
    while (!queue.empty()) {
        int size = (int)queue.size();
        double temp_sum = 0.0;
        for (int i = 0; i < size; i++) {
            TreeNode *temp = queue.front();
            temp_sum += temp->val;
            if(temp->left) queue.push(temp->left);
            if(temp->right)queue.push(temp->right);
            queue.pop();
        }
        temp_sum /= (double)size;
        ans.push_back(temp_sum);
    }
    return ans;
}

bool LeetCode::judgeSquareSum(int c) {
    //先对sqrt(c), 然后从1 ^ 2 开始计算。
    //将剩余的看看是否是整数，如果是的话，就直接返回。
    //a 需要用long 类型，因为 a*a 可能会溢出
    //b 是一个int 减 a*a 剩余的所以不会存在溢出的情况
    long a = 0;
    while(c >= (a*a)){
        double b = sqrt(c - (a*a));
        if(b - (int)b == 0){
            return true;
        }
        a++;
    }
    return false;
}


int LeetCode::singleNumber(vector<int>& nums) {
    int a = 0, b = 0;
    for (auto x : nums) {
        b = (b ^ x) & ~a;
        a = (a ^ x) & ~b;
    }
    return b;
}

int LeetCode::minOperations(vector<int>& nums) {
    int ans = 0;
    for(int i = 1; i < nums.size(); i++){
        if(nums[i] > nums[i-1]){
            continue;
        }
        ans = ans + nums[i-1] - nums[i] + 1;
        nums[i] = nums[i - 1] + 1;
    }
    return ans;
}

vector<int> LeetCode::countPoints(vector<vector<int>>& points, vector<vector<int>>& queries) {
    vector<int> ans;
    for (int i = 0; i < queries.size(); i++) {
        int sum_point = 0;
        for (int j = 0; j < points.size(); j++) {
            //(x-a)^2 + (y-b)^2 = r^2;
            if((((queries[i][0] - points[j][0]) * (queries[i][0] - points[j][0])) + ((queries[i][1] - points[j][1]) * (queries[i][1] - points[j][1]))) <= (queries[i][2] * queries[i][2])){
                sum_point++;
            }
        }
        ans.push_back(sum_point);
    }
    return ans;
}

int xor_builder(int x,int max){
    int ans = 0;
    while (max >= 0) {
        //直接用最大的与数组中异或结果相异或，如果存在一个ans比max小的就返回
        ans = x ^ max;
        if(ans <= max)break;
        //如果没有就继续找是否有比max再小一点的，直到0
        max--;
    }
    return ans;
}

// 数组内每个元素进行异或，得出一个可以让异或结果最大的数，这个数就是答案
vector<int> LeetCode::getMaximumXor(vector<int>& nums, int maximumBit) {
    vector<int> ans;
    //用一个stack倒着装全部异或的结果，最后再遍历一次放到vector中
    stack<int> xor_stack;
    int max_k = (2 << (maximumBit - 1)) - 1;
    //这里抽取了第一个数出来所以要先对这个数计算一下。
    int first = nums[0];
    xor_stack.push(xor_builder(first,max_k));
    for (int i = 1; i < nums.size(); i++) {
        first ^= nums[i];
        //我在这里就可以算了啊
        xor_stack.push(xor_builder(first,max_k));
    }
    
    for(int i = 0; i < nums.size(); i++){
        ans.push_back(xor_stack.top());
        xor_stack.pop();
    }
    return ans;
}

int LeetCode::numberOfMatches(int n) {
    if(n <= 1) return 0;
    int ans = 0;
    while (n > 2) {
        int t = n / 2;
        ans += t;
        n -= t;
    }
    return ans + 1;
}


vector<int> LeetCode::decode(vector<int>& encoded, int first) {
    vector<int> ans;
    ans.push_back(first);
    for (int i = 0; i < encoded.size(); i++) {
        int t = first ^ encoded[i];
        ans.push_back(t);
        first = t;
    }
    return ans;
}

unordered_map<int, Employee*> getImportance_umap;
int getImportance_dfs(int id){
    if(!getImportance_umap[id]) return 0;
    Employee* father = getImportance_umap[id];
    int sum = father->importance;
    for (int sub_id : father->subordinates) {
        sum += getImportance_dfs(sub_id);
    }
    return sum;
}

int LeetCode::getImportance(vector<Employee*> employees, int id) {
    int ans = 0;
    //先将每个员工弄到哈希表
    for (auto employee : employees) {
        getImportance_umap[employee->id] = employee;
    }
    Employee* father = getImportance_umap[id];
    ans += father->importance;
    //遍历这个人以下的sub_id
    for (int sub_id : father->subordinates) {
        ans += getImportance_dfs(sub_id);
    }
    return ans;
}

//[[1,2,2,1],[3,1,2],[1,3,2],[2,4],[3,1,2],[1,3,1,1]]
int LeetCode::leastBricks(vector<vector<int>>& wall) {
    unordered_map<int, int> umap;
    for (int i = 0; i < wall.size(); i++) {
        //墙的大小是有区别的。有的砖会大一点。
        int width = 0;
        for (int j = 0; j < wall[i].size() - 1; j++) {
            //看看第几个位置有洞，插进去
            //第一个位置最后一个位置可能有空隙的
            width += wall[i][j];
            //让width后面的位置+1
            umap[width]++;
        }
    }
    if(umap.empty()) return (int)wall.size();
    int ans = umap.begin()->second;
    for (auto iter = umap.begin(); iter != umap.end() ; ++iter) {
        ans = max(ans, iter->second);
    }
    return (int)wall.size() - ans;
}

int LeetCode::reverse(int x) {
    int ans = 0;
    while(x){
        if(ans < INT_MIN / 10 || ans > INT_MAX / 10){
            return 0;
        }
        ans = ans * 10 + x % 10;
        x /= 10;
    }
    return ans;
}


int LeetCode::xorOperation(int n, int start) {
    int ans = start;
    for(int i = 1; i < n; i++){
        ans = ans ^ (start + 2 * i);
    }
    return ans;
}

int LeetCode::getMinDistance(vector<int>& nums, int target, int start) {
    int ans = INT_MAX;
    for(int i = 0; i < nums.size(); i++){
        if(nums[i] == target){
            ans = min(ans,abs(i - start));
        }
    }
    return ans;
}

vector<int> LeetCode::countBits(int num) {
    vector<int> ans;
    for (int i = 0; i <= num; i++) {
        ans.push_back(__builtin_popcount(i));
    }
    return ans;
}

bool minDays_canMake(vector<int>& bloomDay, int days, int m, int k) {
    int bouquets = 0;
    int flowers = 0;
    int length = (int)bloomDay.size();
    for (int i = 0; i < length && bouquets < m; i++) {
        if (bloomDay[i] <= days) {
            flowers++;
            if (flowers == k) {
                bouquets++;
                flowers = 0;
            }
        } else {
            flowers = 0;
        }
    }
    return bouquets >= m;
}
int LeetCode::minDays(vector<int>& bloomDay, int m, int k) {
    if (m > bloomDay.size() / k) {
        return -1;
    }
    int low = INT_MAX, high = 0;
    int length = (int)bloomDay.size();
    for (int i = 0; i < length; i++) {
        low = min(low, bloomDay[i]);
        high = max(high, bloomDay[i]);
    }
    while (low < high) {
        int days = (high - low) / 2 + low;
        if (minDays_canMake(bloomDay, days, m, k)) {
            high = days;
        } else {
            low = days + 1;
        }
    }
    return low;
}


queue<int> leafSimilar_que;
void leafSimilar_dfs(TreeNode *root, bool popOrpush){
    if(!root) return;
    if(!root->left && !root->right){
        if(popOrpush){
            leafSimilar_que.push(root->val);
        }else{
            if(root->val == leafSimilar_que.front() && !leafSimilar_que.empty()){
                leafSimilar_que.pop();
            }else{
                leafSimilar_que.push(root->val);
            }
        }
        return;
    }
    leafSimilar_dfs(root->left,popOrpush);
    leafSimilar_dfs(root->right,popOrpush);
}
bool LeetCode::leafSimilar(TreeNode* root1, TreeNode* root2) {
    leafSimilar_dfs(root1, true);
    leafSimilar_dfs(root2, false);
    return leafSimilar_que.size() == 0;
}
// 3 ， 1
// 1， 2， 3
//encoded[i] = prem[i] ^ prem[i+1]

//n个数 encoded后生成的encoded数组
//prem中还不是重复的数
vector<int> LeetCode::decode(vector<int>& encoded) {
    int n = (int)encoded.size() + 1;
    int a = 0;
    for (int i = 1; i <= n; i++){
        a ^= i;
    }
    for (int i = n - 2; i >= 0; i-=2) {
        a ^= encoded[i];
    }
    vector<int> prem(n);
    prem[0] = a;
    for (int i = 0; i < n - 1; i++) {
        prem[i + 1] = prem[i] ^ encoded[i];
    }
    return prem;
}

//[
//  [1,   4,  7, 11, 15],
//  [2,   5,  8, 12, 19],
//  [3,   6,  9, 16, 22],
//  [10, 13, 14, 17, 24],
//  [18, 21, 23, 26, 30]
//]

bool LeetCode::findNumberIn2DArray(vector<vector<int>>& matrix, int target) {
    //这种是O(nlogn)
//    for (auto v : matrix) {
//        if(v.empty()) return false;
//        if(v.front() <= target && target <= v.back()){
//            //这里要用二分法
//            int low = 0, high = (int)v.size() - 1;
//            while (low <= high) {
//                int mid = (low+high) / 2;
//                if(v[mid] == target) return true;
//                if(v[mid] < target){
//                    low = mid + 1;
//                }else{
//                    high = mid - 1;
//                }
//            }
//        }
//    }
//    return false;
    
    //这种方法比较屌 O(m+n)
    if(matrix.empty() || matrix[0].empty()){
        return false;
    }
    int col = (int)matrix.size();
    int row_len = (int)matrix[0].size();
    int row = 0;
    while (col >= 0 && row < row_len) {
        if(matrix[row][col] == target) return true;
        if(matrix[row][col] > target){
            col--;
        }else{
            row++;
        }
    }
    return false;
}


vector<int> LeetCode::xorQueries(vector<int>& arr, vector<vector<int>>& queries) {
    //arr是最大三千个，所以设置一个少一个的数组装全部异或的结果
    int temp[arr.size() - 1];
    int t = arr.front();
    for(int i = 1; i < arr.size(); i++){
        t ^= arr[i];
        temp[i-1] = t;
    }
    //如果L从0开始，就直接获取temp中R - 1的index的值
    //如果不是从0开始，就将arr中0-L的index的数，从新异或temp中 R - 1的数得出结果
    vector<int> ans;
    for(auto v : queries){
        if(v[0] == v[1]){
            ans.push_back(arr[v[0]]);
            continue;
        }
        int b = temp[v[1] - 1];
        if(v[0] > 0){
            int a;
            if(v[0] == 1){
                a = arr[0];
            }else{
                a = temp[v[0] - 2];
            }
            ans.push_back(a^b);
        }else{
            ans.push_back(b);
        }
    }
    return ans;
}

bool validateStackSequences(vector<int>& pushed, vector<int>& popped){
    for (int i = 0; i < pushed.size(); i++) {
        
    }
    return true;
}
