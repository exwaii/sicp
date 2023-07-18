#lang sicp

;Exercise 2.5.  Show that we can represent pairs of nonnegative integers using only numbers and arithmetic operations if we represent the pair a and b as the integer that is the product 2^a*3^b. Give the corresponding definitions of the procedures cons, car, and cdr.

; for 2^a*3^b -> a, divide 2^a*3^b until odd (remainder 2 nonzer0) and count number of times
; for 2^a*3^b -> b, divide until remainder 3 (remainder 3 nonzer0) and count number of times

(define (pow x n)
  (define (inner result x n)
    (if (= n 0) result (inner (* x result) x (- n 1)))
    )
  (inner 1 x n)
  )

(define (cons a b) (* (pow 2 a) (pow 3 b)))

(define (car z)
  (if (even? z) (+ 1 (car (/ z 2)))
      0
      )
  )

(define (cdr z)
  (if (= (remainder z 3) 0) (+ 1 (cdr (/ z 3)))
      0
      )
  )

; test

(car (cons 5 6)) ;5
(cdr (cons 5 6)) ;6



; proof the function f(a, b) -> 2^a*3^b is injective (if f(a, b) = f(c, d), b=c and c=d)
; assume f(a, b) = f(c, d) and (b!=c or c!=d)
; 2^a*3^b = 2^c*3^d
; 2^(a-c) = 3^(d-b)
; not possible unless a-c = d-b = 0
