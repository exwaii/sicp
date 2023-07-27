#lang sicp

;After debugging her program, Alyssa shows it to a potential user, who complains that her program solves the wrong problem. He wants a program that can deal with numbers represented as a center value and an additive tolerance; for example, he wants to work with intervals such as 3.5± 0.15 rather than [3.35, 3.65]. Alyssa returns to her desk and fixes this problem by supplying an alternate constructor and alternate selectors:


(define (make-interval a b) (cons a b))

(define (lower-bound interval) (car interval))
(define (upper-bound interval) (cdr interval))

(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))
(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))
(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (mul-interval x 
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))))

(define (sub-interval x y) ; lower x - upper y is smallset, upper x - lower y largest
    (make-interval (- (lower-bound x) (upper-bound y)) (- (upper-bound x) (lower-bound y))))

; Unfortunately, most of Alyssa's users are engineers. Real engineering situations usually involve measurements with only a small uncertainty, measured as the ratio of the width of the interval to the midpoint of the interval. Engineers usually specify percentage tolerances on the parameters of devices, as in the resistor specifications given earlier.

; Exercise 2.12.  Define a constructor make-center-percent that takes a center and a percentage tolerance and produces the desired interval. You must also define a selector percent that produces the percentage tolerance for a given interval. The center selector is the same as the one shown above.

(define (make-center-percent c p) (make-interval (- c (* c (/ p 100))) (+ c (* c (/ p 100)))))

(define (percent i) (/ (- (center i) (lower-bound i)) center))