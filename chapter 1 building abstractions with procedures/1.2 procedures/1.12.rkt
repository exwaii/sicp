#lang sicp

;Exercise 1.12.  The following pattern of numbers is called Pascal's triangle.

;      1
;     1 1
;    1 2 1
;   1 3 3 1
;  1 4 6 4 1
; 1 5 10 10 5 1

;The numbers at the edge of the triangle are all 1, and each number inside the triangle is the sum of the two numbers above it. Write a procedure that computes elements of Pascal's triangle by means of a recursive process.

; nth row, kth column (0-indexed we are programmers lol)
(define (pascal n k)
  (cond ((= n 0) 1)
        ((= k 0) 1)
        ((= k n) 1) ; edge cases (literally)
        (else (+ (pascal (- n 1) (- k 1)) (pascal (- n 1) k)))
        )
  )
(pascal 4 2)
;6
(pascal 5 2)
;10
(pascal 5 3)
;10
