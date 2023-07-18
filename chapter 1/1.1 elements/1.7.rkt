#lang sicp


(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
                 x))
  )

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (sqrt x)
  (sqrt-iter 1.0 x))

(define (square x) (* x x))

;Exercise 1.7.  The good-enough? test used in computing square roots will not be very effective for finding the square roots of very small numbers. Also, in real computers, arithmetic operations are almost always performed with limited precision. This makes our test inadequate for very large numbers. Explain these statements, with examples showing how the test fails for small and large numbers. An alternative strategy for implementing good-enough? is to watch how guess changes from one iteration to the next and to stop when the change is a very small fraction of the guess. Design a square-root procedure that uses this kind of end test. Does this work better for small and large numbers?

; test for small numbers
(square (sqrt 0.001))
;0.0017011851721075596
(square (sqrt 0.0001))
; 0.0010438358335233748
(square (sqrt 0.00000001))
;0.000976569160163076

; sqrt(x) gets less accurate as x gets close to or smaller than 0.001, staying at around sqrt(0.001) as x gets smaller than 0.001
; this is because the acceptable range for the guess is 0.001 of x, and as x gets closer to 0.001 guess becomes less and less precise as the range is a significant fraction of x
; as x gets smaller than 0.001, the guess stays at around sqrt(0.001) because the guess only needs to square to 0.001 + x ~= 0.001
; e.g. the guess for sqrt(0.0001) only needs to square to < 0.0011 and the guess for sqrt(0.00000001) only needs to square to < 0.00100001

; test for large numbers
; (square (sqrt 9007199254740992))
; infinite loop
; why does this happen? because for large numbers, floating point arithmetic is less precise as more significant digits
; so even if answer is *close*, because it's less precise, it still won't be within 0.001 of the answer


(define guess 94906265.62425154)
(define x 9007199254740992)
(improve guess x)
; 94906265.62425154
(average 94906265.62425154 (/ 9007199254740992 94906265.62425154))
; 94906265.62425154
(/ 9007199254740992 94906265.62425154)
; 94906265.62425156



; improved version

(define (my-good-enough? guess x)
  (< (abs (- (square guess) x)) (* 0.001 guess)))

(define (my-sqrt-iter guess x)
  (if (my-good-enough? guess x)
      guess
      (my-sqrt-iter (improve guess x)
                 x))
  )

(define (my-sqrt x)
  (my-sqrt-iter 1.0 x))


; test for small numbers
(square (my-sqrt 0.001))
; 0.0010012171682319481
(square (my-sqrt 0.0001))
; 0.00010241881976244732
(square (my-sqrt 0.00000001))
; 9.603479556038137e-7
(square (my-sqrt 9007199254740992))
; 9007199254740990.0

; a lot closer !