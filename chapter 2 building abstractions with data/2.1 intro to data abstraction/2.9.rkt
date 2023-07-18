#lang sicp

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

(define (make-interval a b) (cons a b))

(define (lower-bound interval) (car interval))
(define (upper-bound interval) (cdr interval))

; Exercise 2.9.  The width of an interval is half of the difference between its upper and lower bounds. The width is a measure of the uncertainty of the number specified by the interval. For some arithmetic operations the width of the result of combining two intervals is a function only of the widths of the argument intervals, whereas for others the width of the combination is not a function of the widths of the argument intervals. Show that the width of the sum (or difference) of two intervals is a function only of the widths of the intervals being added (or subtracted). Give examples to show that this is not true for multiplication or division.


(define (sub-interval x y) ; lower x - upper y is smallset, upper x - lower y largest
    (make-interval (- (lower-bound x) (upper-bound y)) (- (upper-bound x) (lower-bound y)))
)

(define (width interval) (/ (- (upper-bound interval) (lower-bound interval)) 2))

; by definition new interval for add-interval is (make-interval (+ (lower-bound x) (lower-bound y)) (+ (upper-bound x) (upper-bound y))))
; this has a width of 0.5 * ( upper x + upper y - (lower x + lower y)) = width x + width y
; similarly sub-interval is     (make-interval (- (lower-bound x) (upper-bound y)) (- (upper-bound x) (lower-bound y)))
; this has a width of 0.5 * (upper x - lower y - (lower x - upper y)) = 0.5 * (upper x - lower x + upper y - lower x) = width x + width y

; however for multiplication...

(define a (make-interval 2 4)) ; width 2
(define b (make-interval 1 5)) ; width 4
(width (mul-interval a b)) ; 9

(define c (make-interval 0 2)) ; width 2
(define d (make-interval 1 5)) ; width 4
(width (mul-interval c d)) ; 5
; so it is not just a function of the widths

; similarly,
(width (div-interval a b)) ; 1.8
(width (div-interval c d)) ; 1.0

