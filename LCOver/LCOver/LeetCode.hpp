//
//  LeetCode.hpp
//  LCOver
//
//  Created by 你吗 on 2021/3/23.
//

#ifndef LeetCode_hpp
#define LeetCode_hpp
#include <iostream>
#include <stdio.h>
#include <vector>
#include <map>
#include <algorithm>
#include <list>
#include <queue>
#include <stack>

#include "Struts.hpp"

using namespace std;

class LeetCode {
public:
    LeetCode(){};
    vector<vector<int>> threeSum(vector<int> &nums);
    vector<vector<int>> fourSum(vector<int>& nums, int target);
    string countAndSay(int n);
    void merge(vector<int>& nums1, int m, vector<int>& nums2, int n);
    string convert(string s, int numRows);
    int mySqrt(int x);
    int majorityElement(vector<int>& nums);
    ListNode* mergeKLists(vector<ListNode*>& lists);
    int lengthOfLongestSubstring(string s);
    bool isValid(string s);
    bool hasCycle(ListNode *head);
    int maxProfit(vector<int>& prices);
    void rotate(vector<vector<int>>& matrix);
    vector<vector<int>> levelOrder(TreeNode* root);
    int maxDepth(TreeNode* root);
    vector<string> generateParenthesis(int n);
    vector<vector<int>> subsets(vector<int>& nums);
    void moveZeroes(vector<int>& nums);
    ListNode* reverseList(ListNode* head);
    int hammingWeight(uint32_t n);
    int hammingDistance(int x, int y);
    int totalHammingDistance(vector<int>& nums);
    TreeNode* mergeTrees(TreeNode* root1, TreeNode* root2);
};

#endif /* LeetCode_hpp */
