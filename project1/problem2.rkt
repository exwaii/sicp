#lang sicp

;Problem 2: Basic Math
; One of our goals is to determine how far a baseball will travel in the air, if it is hit with
; some initial velocity at some initial angle with respect to the ground. To do this, we will
; need to know when the baseball hits the ground, and for that we'll want to find when the y
; coordinate of the baseball's position reaches zero. This can be discovered by finding the
; roots of the y position equation, and selecting the one that is larger (later in time). The
; proper tool for this is the quadratic formula. Given the coefficients of the quadratic
; u
; equation az
; 2
;  + bz + c = 0, write a procedure to find one of the roots (call this root1), and
; another procedure to find the other root (call this root2).

(define (square x) (* x x))


(define root1
  (lambda (a b c)
    (/
    (- (sqrt (- (square b) (* 4 a c))) b)
    (* 2.0 a)
    )))
(define root2
  (lambda (a b c)
    (/
    (- (* -1 b) (sqrt (- (square b) (* 4 a c))))
    (* 2.0 a)
    )))

(root1 1 -5 6)
(root2 1 -5 6)
; You may notice that, depending on how you wrote your procedures, for some test cases
; you get an error. For example, try (root1 5 3 6). What happens? If you get an error,
; which is likely if you wrote your code the straightforward way, figure out how to change
; it so that your procedure returns a false value in those cases where there is not a valid
; solution

(root1 5 3 6) ;-0.3+1.0535653752852738i lmao
(root1 1 0 1) ; 0.0+1.0i
;it works for complex roots too !