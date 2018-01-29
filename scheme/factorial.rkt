#lang racket
;;factorial as an example of tail recursion

(define (fact n)
  (if (= n 1)
      1
      (* n (fact (- n 1)))))

;;lists

(define (list*2 ls)
  (if (null? ls)
      '()
      (cons (* 2 (car ls))
            (list*2 (cdr ls)))))