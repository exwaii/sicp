#lang sicp

(define (square x) (* x x))

(define (even? n)
  (= (remainder n 2) 0))

(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))

; Exercise 1.16.  Design a procedure that evolves an iterative exponentiation process that uses successive squaring and uses a logarithmic number of steps, as does fast-expt. (Hint: Using the observation that (bn/2)2 = (b2)n/2, keep, along with the exponent n and the base b, an additional state variable a, and define the state transformation in such a way that the product a bn is unchanged from state to state. At the beginning of the process a is taken to be 1, and the answer is given by the value of a at the end of the process. In general, the technique of defining an invariant quantity that remains unchanged from state to state is a powerful way to think about the design of iterative algorithms.)

(define (fast-expt-iter b n)
  (define (inner a b n)
    (cond ((= n 0) a)
          ((even? n) (inner a (square b) (/ n 2)))
          (else (inner (* b a) b (- n 1)))
          )
    )
    (inner 1 b n)
  )

; got stuck, key observation is that recursive changes power, iterative changes base... wow...

(fast-expt 2 4)
(fast-expt 5 5)
(fast-expt-iter 2 4)
(fast-expt-iter 5 5)
;16, 3125
