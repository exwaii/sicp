#lang sicp

;Exercise 1.31.
; a.  The sum procedure is only the simplest of a vast number of similar abstractions that can be captured as higher-order procedures.51 Write an analogous procedure called product that returns the product of the values of a function at points over a given range. Show how to define factorial in terms of product. Also use product to compute approximations to  using the formula

;π/4=(2⋅4⋅4⋅6⋅6⋅8⋯)/(3⋅3⋅5⋅5⋅7⋅7⋯)

(define (product term a next b)
  (define (iter k result)
    (if (> k b)
        result
        (iter (next k) (* result (term k)))))
  (iter a 1))

(define (factorial n)
  (product identity 1 inc n)
  )
(factorial 6)
;720

(define (pi n)
  (define (kth-term k)
    (/ (- (+ 2 k) (remainder k 2)) (+ 1 k (remainder k 2)))
    )
  (exact->inexact (* 4 (product kth-term 1 inc n)))
  )

(pi 1000) ; 3.1431607055322663

; b.  If your product procedure generates a recursive process, write one that generates an iterative process. If it generates an iterative process, write one that generates a recursive process.

(define (product-recur term a next b)
  (if (> a b) 1
      (* (term a) (product-recur term (next a) next b))
      )
  )

(define (factorial-recur n)
  (product-recur identity 1 inc n)
  )
(factorial-recur 6)
;720