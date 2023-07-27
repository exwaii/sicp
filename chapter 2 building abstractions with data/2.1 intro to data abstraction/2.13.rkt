#lang sicp

;Exercise 2.13.  Show that under the assumption of small percentage tolerances there is a simple formula for the approximate percentage tolerance of the product of two intervals in terms of the tolerances of the factors. You may simplify the problem by assuming that all numbers are positive.

; (c +- p%c) (d +- q%d) = cd +- c * q% * d +- d * p% * c + p% * c * q% * d
; assuming small percentages last term is 0 
; so it is equal to c*d +- (c * q% + d * p%) = cd +- cd * (q/d + p/c)%

(define (make-interval a b) (cons a b))

(define (lower-bound interval) (car interval))
(define (upper-bound interval) (cdr interval))

(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))
(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))
(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

(define (make-center-percent c p) (make-interval (- c (* c (/ p 100))) (+ c (* c (/ p 100)))))

(define (percent i) (/ (- (center i) (lower-bound i)) center))

(define (mul-interval a b) (make-center-percent (* (center a) (center b)) (+ (/ (percent a) (center b)) (/ (percent b) (center a)))) )