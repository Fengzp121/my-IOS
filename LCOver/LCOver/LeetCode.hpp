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
#include <deque>
#include <unordered_map>
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
    int maxDepth(TreeNode* root);
    vector<string> generateParenthesis(int n);
    vector<vector<int>> subsets(vector<int>& nums);
    vector<vector<int>> subsetsWithDup(vector<int>& nums);
    void moveZeroes(vector<int>& nums);
    ListNode* reverseList(ListNode* head);
    int hammingWeight(uint32_t n);
    int hammingDistance(int x, int y);
    int totalHammingDistance(vector<int>& nums);
    TreeNode* mergeTrees(TreeNode* root1, TreeNode* root2);
    vector<int> findDisappearedNumbers(vector<int>& nums);
    bool isSymmetric(TreeNode* root);
    ListNode *getIntersectionNode(ListNode *headA, ListNode *headB);
    int findKthLargest(vector<int>& nums, int k);
    vector<int> reversePrint(ListNode* head);
    string replaceSpace(string s);
    uint32_t reverseBits(uint32_t n);
    void flatten(TreeNode* root);
    TreeNode* buildTree(vector<int>& preorder, vector<int>& inorder);
    int climbStairs(int n);
    int sumNums(int n);
    vector<int> levelOrder(TreeNode* root);
    vector<vector<int>> levelOrderI(TreeNode* root);
    vector<vector<int>> levelOrderII(TreeNode* root);
    vector<vector<int>> levelOrderIII(TreeNode* root);
    int clumsy(int N);
    vector<int> exchange(vector<int>& nums);
    TreeNode* mirrorTree(TreeNode* root);
    ListNode* reverseKGroup(ListNode* head, int k);
    ListNode* getKthFromEnd(ListNode* head, int k);
    //int trap(vector<int>& height);
    ListNode* swapPairs(ListNode* head);
    int removeDuplicates(vector<int>& nums);
    int searchI(vector<int>& nums, int target);
    bool searchII(vector<int>& nums, int target);
    int findMinI(vector<int>& nums);
    int findMinII(vector<int>& nums);
    bool isUgly(int n);
    int nthUglyNumber(int n);
    int nthUglyNumber(int n, int a, int b, int c);
    string largestNumber(vector<int>& nums);
    int minDiffInBST(TreeNode* root);
    int arrangeCoins(int n);
    int findInMountainArray(int target, vector<int> &mountainArr);
};

#endif /* LeetCode_hpp */
