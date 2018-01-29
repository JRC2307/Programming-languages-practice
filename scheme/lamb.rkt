#lang racket

(define (fun1 a b c)
  (/ (* (+ a b c) a) b))

(define lamb (lambda ( a b c) (/ (* (+ a b c) a) b)))