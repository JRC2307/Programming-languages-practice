#lang racket
(+ 3 4 7 9)

(define (fun1 a b c)
  (* a b c))

(define (sum v b)
  (+ v b))

;;Basic lambda operation
;; or anonnymus function
((lambda (v b) (+ v b)) 67 34)

;;Defined lambda operation
(define add (lambda (v b) (+ v b)))


;; Lambda done by us, exercise

(define (lamb1 a b c)
  (/ (* (+ a b c) a) b))


;; ez
(define (mult1 a b)
  (* a b))
;; simplified lambda
(define mult2 (lambda (a b) (* a b)))
;; extended lambda
(define mult3 (lambda(a)
               lambda(b) (* a b)))

(define lamb (lambda ( a b c) (/ (* (+ a b c) a) b)))

