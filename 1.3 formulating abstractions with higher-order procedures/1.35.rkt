#lang sicp

; fixed point of x -> 1 + 1/x means x = 1 + 1/x or x^2 = x + 1 -> x^2 - x - 1 = 0
; quadratic formula -> (1+-sqrt(5))/2
; otherwise, by line segment definition
; |--------------------|-----------------|
;          a                b
; ratio s.t ratio of longer length to total line is same as ratio of longer length to smaller
; or: a/b = (a+b)/a 
; a/b = 1 + b/a
; let x = a/b then x = 1 + 1/x (equivalent definition)


; 1 + 1/x



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

(fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.0)

;1.6180327868852458