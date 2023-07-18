#lang sicp

;Exercise 1.37.  a. An infinite continued fraction is an expression of the form

; As an example, one can show that the infinite continued fraction expansion with the Ni and the Di all equal to 1 produces 1/, where  is the golden ratio (described in section 1.2.2). One way to approximate an infinite continued fraction is to truncate the expansion after a given number of terms. Such a truncation -- a so-called k-term finite continued fraction -- has the form

; Suppose that n and d are procedures of one argument (the term index i) that return the Ni and Di of the terms of the continued fraction. Define a procedure cont-frac such that evaluating (cont-frac n d k) computes the value of the k-term finite continued fraction. Check your procedure by approximating 1/ using

(define (cont-frac n d k)
  (define (inner i)
    (if (> i k) 0
        (/ (n i) (+ (d i) (inner (+ i 1)))
           )
        )
    )
  (inner 1)
  )

(/ 1 (cont-frac (lambda (i) 1.0)
                (lambda (i) 1.0)
                100)
   )
; 1.618033988749895

; for successive values of k. How large must you make k in order to get an approximation that is accurate to 4 decimal places?

; to 4 decimal places is 1.6180 at k = 12

(/ 1 (cont-frac (lambda (i) 1.0)
                (lambda (i) 1.0)
                12)
   )
; 1.6180555555555558

; b. If your cont-frac procedure generates a recursive process, write one that generates an iterative process. If it generates an iterative process, write one that generates a recursive process.

(define (cont-frac-iter n d k)
  (define (inner-iter i result)
    (if (> i k) result
        (inner-iter (+ i 1) (/ (n i) (+ (d i) result)))
           
        )
    )
  (inner-iter 1 0)
  )

(/ 1 (cont-frac-iter (lambda (i) 1.0)
                (lambda (i) 1.0)
                100)
   )