#lang sicp

;Exercise 1.3.  Define a procedure that takes three numbers as arguments and returns the sum of the squares of the two larger numbers.

(define (square x) (* x x))

(define (square-sum-larger a b c)
  (cond ((and (<= a b) (<= a c)) (+ (square b) (square c)))
        ((and (<= b a) (<= b c)) (+ (square a) (square c)))
        (else (+ (square a) (square b))
              )
        )
  )

(square-sum-larger 3 3 3)