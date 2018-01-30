#lang racket

;-----------Lab 2-------------;
;---Head and tail recursion---;
;-------Javier Rodriguez------;
;----------A01152572----------;

;;;; 1)
;;;Power with head recursion
;;(power-head 4 3) should return 64
(define (power-head a b)
  (cond
    ((= b 1) a)
    ((= b 0) 1)
    (else (* a ( power-head a(- b 1))))
    ))

;;;Power with tail recursion
;;(power-tail 4 3) should return 64
(define (power-tail a b)
  (power-tail-two a b 1))

 (define (power-tail-two a b tot)
   (cond
     ((= b 0) tot)
     (else (power-tail-two a(- b 1)(* a tot)))
     ))

;;;; 2)
;;; Function third, returtns the third element of a list
;;(third (cons 1(cons 2 (cons 3 (cons 4 (cons 5 empty))))))
(define (third list)
  (car (cdr(cdr list))))

;;;; 3)
;;;Function just-two?, returns true if a list contains onlu two elements
;; (just-two? (cons 1(cons 2 (cons 3 (cons 4 (cons 5 empty)))))) should return #f
;; (just-two? (cons 1(cons 2 (cons 3 (cons 4 (cons 5 empty)))))) should return #t
(define (just-two? list)
  (cond
    [(= (length list) 2) #t]
    [else #f ]
   )
 )

;;;; 4)
;;;Function how-many-x? recieves a list and shoould return the number of elemnts that match x
;;(define list-how(cons 1(cons 2(cons 3(cons 4(cons 5 empty))))))
;;(how-many-x? list 3) should return 2


(define (how-many-x? list-how x y)
  
  (cond
    [(empty? list-how) y]
    [(= (car list-how) x) ((how-many-x?(cdr list-how) x (+ y 1)))]
    [else (how-many-x? (cdr list-how) x y)]
    )
  )

;;;; 5)function all-x? to check if all elements in a list is x
(define (all-x? list-all x)
  (cond
    [(empty? list-all) #t]
    [(= (car list-all) x)(all-x? (cdr list-all) x)]
    [else #f]
    )
  )

;;;; 6) function get, recieves a list and a postiion, return value of position in that list
;;; (get '(1 2 3 4) 3) Should return 3
(define (get list x)
  (cond
    [(empty? list) -1]
    [(= x 1) (car list)]
    [else (get (cdr list) (- x 1))]))


;;;;7) Define the function append that receives 2 lists A and B. The function return only 1 list with the elements of A followed by the elements of B.
;; (append '(a b c d) '(e f g))  should return (a b c d e f g) 
;;(append  '( ) '(a b c)) should return (a b c)
(define (append la lb)
 (if (null? la) lb
  (cons (car la) (append (cdr la) lb))))

;;;;8)Define the function invert which inverts the order of the elements in a list
;; (invert '(a b c d)) should return (d c b a) 
;;(invert '( )) should return ( )
(define (inverse lst)
  (if (null? lst) '()
    (append (inverse (cdr lst)) (list(car lst)))))
     ;;The append function from exercise 7 comes in real handy in here


;;;;9)Define the function sign that receives a list of numbers and returns a list of 1 or -1 depending on whether each number is greater or lesser than 0.
;;(sign '(2 -4 -6)) should return (1 -1 -1)
(define (sign list)
  (cond
    [(empty? list) '()]
    [(< (car list) 0)(cons -1(sign (cdr list)))]
    [(> (car list) 0)(cons 1(sign (cdr list)))]
  ))  

;;;;10)Define the function negatives that receives a list of positive numbers and returns a list with the corresponding negative numbers.
;;(negatives '(2 -4 6)) should return (-2 -4 -6)
(define (negatives list)
  (cond
    [(empty? list) '()]
    [(< (car list) 0)(cons (car list)(negatives (cdr list)))]
    [(>= (car list) 0)(cons(* -1(car list))(negatives(cdr list)))]))
  