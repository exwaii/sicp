#lang sicp

;Exercise 1.41.  Define a procedure double that takes a procedure of one argument as argument and returns a procedure that applies the original procedure twice. For example, if inc is a procedure that adds 1 to its argument, then (double inc) should be a procedure that adds 2. What value is returned by

(define (double f) (lambda (x) (f (f x))))

((double inc) 4) ; 6

(((double (double double)) inc) 5)

; first, (double double) -> (double (double x))
; or maybe f instead of x, eh
; (double (double double)) -> (double (double (double x))) -> (double (double (double (double x))))
; so (((double (double double)) inc) 5) -> ((double (double (double (double inc)))) 5) -> 5 + 16 = 21