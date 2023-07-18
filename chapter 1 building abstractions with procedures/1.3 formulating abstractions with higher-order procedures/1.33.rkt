#lang sicp

;Exercise 1.33.  You can obtain an even more general version of accumulate (exercise 1.32) by introducing the notion of a filter on the terms to be combined. That is, combine only those terms derived from values in the range that satisfy a specified condition. The resulting filtered-accumulate abstraction takes the same arguments as accumulate, together with an additional predicate of one argument that specifies the filter. Write filtered-accumulate as a procedure. Show how to express the following using filtered-accumulate:

; a. the sum of the squares of the prime numbers in the interval a to b (assuming that you have a prime? predicate already written)
(define (filtered-accumulate filter combiner null-value term a next b)
  (cond ((> a b) null-value)
        ((filter a) (combiner (term a) (filtered-accumulate filter combiner null-value term (next a) next b)))
        (else (filtered-accumulate filter combiner null-value term (next a) next b))
        )
  )

(define (prime? n)
  (= n (smallest-divisor n)))
(define (square x) (* x x))
(define (smallest-divisor n)
  (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))
(define (divides? a b)
  (= (remainder b a) 0))

(define (sum-primes-squares a b)
  (filtered-accumulate prime? + 0 square a inc b))

(sum-primes-squares 1 7)
; 1^2 + 2^2 + 3^2 + 5^2 + 7^2 = 88

; b. the product of all the positive integers less than n that are relatively prime to n (i.e., all positive integers i < n such that GCD(i,n) = 1).

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (identity x) x)

(define (coprime-product n)
  (define (coprime? i) (= (gcd i n) 1))
  (filtered-accumulate coprime? * 1 identity 1 inc (- n 1))
  )

(coprime-product 12)

; 1 * 5 * 7 * 11 = 385