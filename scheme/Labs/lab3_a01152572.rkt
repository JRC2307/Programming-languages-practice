#lang racket

;-----------Lab 3-------------;
;---------Deep lists----------;
;-------Javier Rodriguez------;
;----------A01152572----------;


;;;Define function deep-reverse which receives a deep list. The function returns a list of lists with its elements in reverse order. 
;;(deep-reverse '(a (b (c d)) e (f g))) 
;   > ((g f) e ((d c) b) a)
(define (deep-reverse list)
  (deep-reverse2 list empty))

(define (deep-reverse2 list x)
  (cond
    [(empty? list) x]
    [(not (pair? list))list]
    [(deep-reverse2 (cdr list)
                    (cons (deep-reverse2 (car list) empty) x))]))
 

;;;Define function flatten that receives a deep list and return a list containing all the elements in a single 1 level list
;; (flatten '(a (b (c d)) e (f g))) 
;;  > (a b c d e f g) 
(define (flatten list)
  (cond
    [(empty? list) empty]
    [(pair? list)(append (flatten(car list)) (flatten(cdr list)))]
    [else (cons list empty)]))


;;;Define the function count-levels which counts the max depth of a tree 
;;(count-levels '(a
;;(b 
;;   (c) (d))
;;(e 
;;   (f) (g)))) 
;;> 3
(define (count-levels list)
  (cond
    [(null? (cdr list)) 1]
    [else (add1 (apply max (map count-levels (cdr list))))]))


;;;Define the function count-max-arity which counts the max number of children a single node of the tree has
;;(count-max-arity '(a
;;(b 
;;(c) (d))
;;(e 
;;(f) (g) (h) (i)))) 
;;> 4

(define (count-max-arity list)
  (cond
    [(empty? (cdr list)) 0]
    [else (- (apply max(map count-depth (cdr list))) 1)]))

(define (count-depth list)
  (if (empty? list) 0
  (add1 (count-depth (cdr list)))))