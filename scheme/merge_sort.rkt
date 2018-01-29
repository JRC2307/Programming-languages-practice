#lang racket

(define (merge-sort alon)
	(cond
		[(empty? alon) empty ]
		[(empty? (rest alon)) alon]
		[(intercalate (merge-sort (split_even alon)) 
									(merge-sort (split_odd alon)) )]))

(define (split_even list)
	(cond
		[(empty? list) list]
		[(empty? (rest list)) empty ]
		[(cons (first (rest list)) (split_even (rest (rest list))) )]))

(define (split_odd list)
	(cond
		[(empty? list) list]
		[(empty? (rest list)) (cons (first list) empty) ]
		[(cons (first list) (split_odd (rest (rest list))) )]))

(define (intercalate A B)
	(cond
		[(empty? A) B]
		[(empty? B) A]
		[(< (first A) (first B)) (cons (first A) (intercalate (rest A) B) )]
		[else (cons (first B) (intercalate (rest B) A) )]))

(merge-sort '(9 2 0 1 4 453 12))