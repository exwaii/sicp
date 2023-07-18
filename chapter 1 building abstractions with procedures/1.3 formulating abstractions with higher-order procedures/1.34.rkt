#lang sicp

;Exercise 1.34.  Suppose we define the procedure

(define (square x) (* x x))

(define (f g)
  (g 2))

;Then we have

(f square)
;4

(f (lambda (z) (* z (+ z 1))))
;6

;What happens if we (perversely) ask the interpreter to evaluate the combination (f f)? Explain.

; it fails, as seen below
; (f f)
; (f 2)
; (2 2)
; 2 is not a procedure

(f f)
; application: not a procedure;
;  expected a procedure that can be applied to arguments
;   given: 2