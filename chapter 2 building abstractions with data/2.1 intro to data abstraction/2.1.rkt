#lang sicp

;Exercise 2.1.  Define a better version of make-rat that handles both positive and negative arguments. Make-rat should normalize the sign so that if the rational number is positive, both the numerator and denominator are positive, and if the rational number is negative, only the numerator is negative.

(define (make-rat n d)
  (let ((g (gcd n d)))
    (if (>= (* n d) 0) (cons (abs (/ n g)) (abs (/ d g)))
        (cons (* -1 (abs (/ n g))) (abs (/ d g)))
        )

    )
  )


(gcd -10 2)

(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))

(define (numer x) (car x))

(define (denom x) (cdr x))

(print-rat (make-rat 2 4))