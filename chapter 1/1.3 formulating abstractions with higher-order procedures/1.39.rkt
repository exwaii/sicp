#lang sicp

;Exercise 1.39.  A continued fraction representation of the tangent function was published in 1770 by the German mathematician J.H. Lambert:

;tanx=x/(1−x^2/(3−x^2/5−⋱))

;where x is in radians. Define a procedure (tan-cf x k) that computes an approximation to the tangent function based on Lambert's formula. K specifies the number of terms to compute, as in exercise 1.37.

(define (cont-frac n d k)
  (define (inner i)
    (if (> i k) 0
        (/ (n i) (+ (d i) (inner (+ i 1)))
           )
        )
    )
  (inner 1)
  )

(define (square x) (* x x))

(define (tan-cf x k)
    (define (tan-n i) 
    (if (= i 1) x (* -1 (square x))
    )    
    )
    (define (tan-d i) (- (* 2 i) 1))
    (cont-frac tan-n tan-d k)
)

(tan-cf (/ 3.1415 4) 1000) ;0.9999536742781562