#lang sicp

;Exercise 1.18.  Using the results of exercises 1.16 and 1.17, devise a procedure that generates an iterative process for multiplying two integers in terms of adding, doubling, and halving and uses a logarithmic number of steps.40


(define (double a) (+ a a))
(define (halve a) (/ a 2))
(define (even? n)
  (= (remainder n 2) 0))

(define (* a b)
  (cond ((= b 0) 0)
        ((even? b) (double (* a (halve b))))
        (else (+ a (* a (- b 1))))
        )
  )

(define (m-iter a b)
  (define (inner p a b)
    (cond ((= b 0) p)
          ((even? b) (inner p (double a) (halve b)))
          (else (inner (+ p a) a (- b 1)))
          )
    )
  (inner 0 a b)
  )

(m-iter 3 16)
;48