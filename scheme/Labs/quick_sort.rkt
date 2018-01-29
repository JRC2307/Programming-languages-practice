#lang racket

(define (quick-sort alon)
	(cond
		[(empty? alon) empty ]
		[else (append (quick-sort (smaller-items alon (first alon) ))
									(list (first alon))
									(quick-sort (larger-items alon (first alon))))]))

(define (larger-items alon threshold)
	(cond
		[(empty? alon) empty ]
		[else (if (> (first alon) threshold)
							(cons (first alon) (larger-items (rest alon) threshold) )
							(larger-items (rest alon) threshold))]))

(define (smaller-items alon threshold)
	(cond
		[(empty? alon) empty ]
		[(< (first alon) threshold) (cons (first alon) (smaller-items (rest alon) threshold)) ]
		[(smaller-items (rest alon) threshold)]))

(quick-sort '(9 2 0 1 4 453 12))