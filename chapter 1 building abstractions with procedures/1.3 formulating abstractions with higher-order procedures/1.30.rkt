#lang sicp

;Exercise 1.30.  The sum procedure above generates a linear recursion. The procedure can be rewritten so that the sum is performed iteratively. Show how to do this by filling in the missing expressions in the following definition:

(define (sum term a next b)
  (define (iter k result)
    (if (> k b)
        result
        (iter (next k) (+ result (term k)))))
  (iter a 0))

; test

(define (cube x) (* x x x))

(sum cube 1 inc 10)
;3025 :D