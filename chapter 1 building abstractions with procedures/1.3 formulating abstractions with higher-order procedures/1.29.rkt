#lang sicp

;Exercise 1.29.  Simpson's Rule is a more accurate method of numerical integration than the method illustrated above. Using Simpson's Rule, the integral of a function f between a and b is approximated as

; (h/3)[y0+4y1+2y2+4y3+2y4+⋯+2yn−2+4yn−1+yn]

; where h = (b - a)/n, for some even integer n, and yk = f(a + kh). (Increasing n increases the accuracy of the approximation.) Define a procedure that takes as arguments f, a, b, and n and returns the value of the integral, computed using Simpson's Rule. Use your procedure to integrate cube between 0 and 1 (with n = 100 and n = 1000), and compare the results to those of the integral procedure shown above.


(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))
; don't get why you need a next that isn't just + 1...
; since in sigma notation, you just sum from a to b incrementing once anyways
; ohh sigma notation forms the basis of for loops in python !


(define (simpson f a b n)
  (let* ((h (/ (- b a) n))
         (next (lambda (x) (+ x 1)))
         (term (lambda (k) (cond ((or (= k 0) (= k n)) (f (+ a (* k h))))
                                 ((even? k) (* 2 (f (+ a (* k h)))))
                                 (else (* 4 (f (+ a (* k h)))))
                                 )
                 )
               )
         )
    (* (/ h 3.0) (sum term 0 next n))
    )
  )

(define (cube x) (* x x x))
(simpson cube 0 1 100) ;0.25
(simpson cube 0 1 1000) ;0.25