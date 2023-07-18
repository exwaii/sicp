#lang sicp

;Exercise 1.27.  Demonstrate that the Carmichael numbers listed in footnote 47 really do fool the Fermat test. That is, write a procedure that takes an integer n and tests whether an is congruent to a modulo n for every a<n, and try your procedure on the given Carmichael numbers.

(define (square x) (* x x))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (define (inner a n)
    (cond ((= a n) true)
          ((try-it a) (inner (+ a 1) n))
          (else false))
    )
    (inner 1 n)
  )

(test 561)
(test 1105)
(test 1729)
(test 2465)
(test 2821)
(test 6601)
; all #t