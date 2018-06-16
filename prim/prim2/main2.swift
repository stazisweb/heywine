//
//  main.swift
//  2
//
//  Created by Кривогузов Владислав on 15.06.18.
//  Copyright © 2018 Кривогузов Владислав. All rights reserved.
//

import Foundation

var str = "Раз Дваа ТрИиИи Четырее"

func branch1(string str: String) -> Double{
    let wordArray = str.split{$0 == " "}.map(String.init)
    var averageCharCount = 0.0
    for word in wordArray {
        averageCharCount+=Double(word.count)
    }
    averageCharCount/=Double(wordArray.count)
    return averageCharCount
}
/**
 - returns: Словарь из слов с количством гласных больше 3
 */
func branch2(string str: String) -> [String: Int]{
    let wordArray = str.split{$0 == " "}.map(String.init)
    var dic = [String: Int]();
    for word in wordArray{
            dic[word]=0
            for c in word{
                switch String(c).lowercased(){
                case "а","о","е","у","ы","э","я","и","ю":
                    dic[word] = dic[word]! + 1
                default: break
                }
            }
    }
    return dic.filter({$0.value>3})
}
print(str)
print("Средняя длина слова \(branch1(string: str))")
let dic = branch2(string: str)
print("Число слов, где гласных больше 3 = \(dic.count)")
print("Вот эти слова \(dic)")
