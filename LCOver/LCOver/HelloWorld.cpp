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

