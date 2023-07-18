#lang sicp

;Exercise 1.45.  We saw in section 1.3.3 that attempting to compute square roots by naively finding a fixed point of y -> x/y does not converge, and that this can be fixed by average damping. The same method works for finding cube roots as fixed points of the average-damped y -> x/y2. Unfortunately, the process does not work for fourth roots -- a single average damp is not enough to make a fixed-point search for y -> x/y3 converge. On the other hand, if we average damp twice (i.e., use the average damp of the average damp of y  x/y3) the fixed-point search does converge. Do some experiments to determine how many average damps are required to compute nth roots as a fixed-point search based upon repeated average damping of y  x/yn-1. Use this to implement a simple procedure for computing nth roots using fixed-point, average-damp, and the repeated procedure of exercise 1.43. Assume that any arithmetic operations you need are available as primitives.

(define (average a b) (/ (+ a b) 2))

(define (average-damp f)
  (lambda (x) (average x (f x))))

(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))


(define (cube x) (* x x x))

(define (compose f g) (lambda (x) (f (g x))))

(define (repeated f n)
  (if (= n 1) f (compose f (repeated f (- n 1))))
  )

(define (pow x n)
  (define (inner result x n)
    (if (= n 0) result (inner (* x result) x (- n 1)))
    )
  (inner 1 x n)
  )

(define (nth-root x n)
  (fixed-point ((repeated average-damp (- (floor (log x 2)) 3)) (lambda (y) (/ x (pow y (- n 1)))))
               1.0)) 

; 1024 min 7
; 2048 min 7
; 4096 min 9
; 8192 min 10
; 16384 min 11
; 32768 min 12
; 65536 min 13
; gasp
; initially tried log 10 for some reason
; rule is... log(2) - 3?

(nth-root 81221 123)