#lang sicp

;Exercise 1.25.  Alyssa P. Hacker complains that we went to a lot of extra work in writing expmod. After all, she says, since we already know how to compute exponentials, we could have simply written

;(define (fast-expt b n)
;   (cond ((= n 0) 1)
;         ((even? n) (square (fast-expt b (/ n 2))))
;         (else (* b (fast-expt b (- n 1))))))

; (define (expmod base exp m)
;   (remainder (fast-expt base exp) m))

; (define (expmod base exp m)
;   (cond ((= exp 0) 1)
;         ((even? exp)
;          (remainder (square (expmod base (/ exp 2) m))
;                     m))
;         (else
;          (remainder (* base (expmod base (- exp 1) m))
;                     m))))        

; Is she correct? Would this procedure serve as well for our fast prime tester? Explain.
; it would be slower as we would be squaring and multiplying potentially very large numbers and then taking its modulus, while expmod takes modhulus every operation to ensure that the size of the integer we are operating on remains small (and fast)