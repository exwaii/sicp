#lang sicp

;Exercise 1.32.

; a. Show that sum and product (exercise 1.31) are both special cases of a still more general notion called accumulate that combines a collection of terms, using some general accumulation function:

; (accumulate combiner null-value term a next b)

; Accumulate takes as arguments the same term and range specifications as sum and product, together with a combiner procedure (of two arguments) that specifies how the current term is to be combined with the accumulation of the preceding terms and a null-value that specifies what base value to use when the terms run out. Write accumulate and show how sum and product can both be defined as simple calls to accumulate.

(define (accumulate combiner null-value term a next b)
  (define (iter k result)
    (if (> k b)
        result
        (iter (next k) (combiner result (term k)))
        )
    )
  (iter a null-value)
  )

;test
(define (product term a next b)
  (accumulate * 1 term a next b))
(define (factorial n)
  (product identity 1 inc n)
  )
(factorial 6) ;720


; b. If your accumulate procedure generates a recursive process, write one that generates an iterative process. If it generates an iterative process, write one that generates a recursive process.

(define (accumulate-recur combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a) (accumulate-recur combiner null-value term (next a) next b))
      )
  )
  ;test
(define (product-recur term a next b)
  (accumulate-recur * 1 term a next b))
(define (factorial-recur n)
  (product identity 1 inc n)
  )
(factorial-recur 6) ;720