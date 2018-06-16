/*
 Пример 1
Дана целочисленная квадратная матрица. Написать на языке swift консольное приложение, обеспечивающее
1) упорядочения ее строк по возрастанию сумм их элементов — код приложения в ветке  version 1» локального репозитория
2) упорядочения ее строк по возрастанию сумм нечетных элементов — код приложения в ветке  version 2» локального репозитория.
*/

import Foundation


var matrix = [[1, 2, 3, 4], [62, -21, 12, 5], [20, 5, 2, 1], [1, 1, 2, 3]]
print(matrix)

matrix.sort(by: {
    return $0.reduce(0, +) > $1.reduce(0, +) // or <
})

print(matrix)
