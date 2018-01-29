;;   Lab 1 Scheme
;;   Javier Rodriguez
;;   A01152572

#lang racket
;;triangle area
(define (triangle-area r)
(* 3.14 (* r r))
)

;; Define the functions a, b, and c that represent each of the following numerical statement respectively

(define (a n)
  (+ (* n 2) 10))

(define (b n)
  (+ (* (/ 1 2 ) (* n 2))))

(define (c n)
  (- (/ 1 n) 2))


;;quadratic equation(Not needed but good for practice)
(define (quadratic a b c)
  (define root (sqrt (-(expt b 2) (* 4 a c))))
    (/ (+ (- b) root) (* 2 a)))


;;Quadratic Rules
(define (solution a b c)
  (cond
    [(> (* b b) (* 4 (* a c) )) "2 solutions"]
    [(= (* b b) (* 4 (* a c) )) "1 solutions"]
    [(< (* b b) (* 4 (* a c) )) "0 solutions"]))