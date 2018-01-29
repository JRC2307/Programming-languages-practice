#lang racket

(define (sum-coins pennies nickels dimes quarters)
  (+ (* pennies .01) (+ (* nickels .05) (+ (* dimes .1) (* quarters .25)))))

(sum-coins 100 20 10 4)