//
//  HelloWorld.cpp
//  LCOver
//
//  Created by 你吗 on 2021/3/23.
//

#include "HelloWorld.hpp"

void six(list<int> &l){
    while (l.size() < 6) {
        l.push_back(rand() % 33 + 1);
        l.sort();
        l.unique();
    }
    l.push_back(rand() % 16 + 1);
}

void MotherFxxker::sixsixsixsixsixsix(int x){
    list<list<int>> lls;
    while (lls.size() < x) {
        list<int> ls;
        six(ls);
        lls.push_back(ls);
        lls.unique();
    }
    cout << "           随机" << x << "注" << endl;
    cout << "     红球             蓝球" <<endl;
    
    //打印校验数组
    cout << "{";
    for (auto ls : lls) {
        
        for (list<int>::iterator it = ls.begin(); it != ls.end(); ++it) {
            if(it == ls.begin()){
                cout << "{";
            }
            if(it != --ls.end()){
                cout << *it << ",";
            }else{
                cout << *it <<"},";
            }
        }
    }
    cout << "}" << endl;
    for (auto ls : lls) {
        //打印
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

void MotherFxxker::check(vector<int> a,vector<vector<int>> b){
    map<string,string> map = {{"6+1","一等奖"},{"6+0","二等奖"},{"5+1","三等奖"},{"5+0","四等奖"},{"4+1","四等奖"},{"4+0","五等奖"},{"3+1","五等奖"},{"2+1","六等奖"},{"1+1","六等奖"},{"0+1","六等奖"},{"0+0","慈善"}};
    vector<string> ans;
    for(auto bb : b){
        int count = 0;
        string sstr = "";
        for (int i = 0 ; i < a.size() - 1; i++) {
            for (int j = 0; j < a.size() - 1; j++) {
                if(a[i] == bb[j]){
                    count++;
                }
            }
        }
        sstr.append(to_string(count));
        sstr.append("+");
        if(a[6] == bb[6]){
            sstr.append("1");
        }else{
            sstr.append("0");
        }
        if(count <= 3 && a[6] != bb[6])sstr = "0+0";
        ans.push_back(sstr);
    }
    int i = 0;
    for (auto item : ans) {
        ++i;
        cout << "第" << i << "注：" << map[item] << endl;
    }
    
}
