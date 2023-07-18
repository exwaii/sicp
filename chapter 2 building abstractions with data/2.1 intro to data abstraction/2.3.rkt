#lang sicp

; Exercise 2.3.  Implement a representation for rectangles in a plane. (Hint: You may want to make use of exercise 2.2.) In terms of your constructors and selectors, create procedures that compute the perimeter and the area of a given rectangle. Now implement a different representation for rectangles. Can you design your system with suitable abstraction barriers, so that the same perimeter and area procedures will work using either representation?

(define (make-point x y) (cons x y))
(define (x-point p) (car p))
(define (y-point p) (cdr p))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ", ")
  (display (y-point p))
  (display ")"))

; (define (gradient p1 p2) (/ (- (y-point p1) (y-point p2)) (- (x-point p1) (x-point p2))))

; assuming the rectangles are nice (their sides are parallel to the axes)

(define (make-rectangular-1 v1 v2) (cons v1 v2)) ; v1 and v2 are opposite corners
(define (print-rectangular-1 rectangle)
  (print-point (car rectangle))
  (print-point (make-point (x-point (car rectangle)) (y-point (cdr rectangle))))
  (print-point (cdr rectangle))
  (print-point (make-point (x-point (cdr rectangle)) (y-point (car rectangle))))
  )
(define (length-1 rectangle) (abs (- (y-point (car rectangle)) (y-point (cdr rectangle)))))
(define (width-1 rectangle) (abs (- (x-point (car rectangle)) (x-point (cdr rectangle)))))

(define (area length width) (* length width))
(define (perimeter length width) (* 2 (+ length width)))

; test for rectangle (0, 0) (0, 4) (3, 4) (3, 0)
; length 3 width 4, area 12 perimeter 14

(define r (make-rectangular-1 (make-point 0 0) (make-point 3 4)))
(area (length-1 r) (width-1 r)) ;12
(perimeter (length-1 r) (width-1 r)) ;14

(define (make-rectangular-2 p length width)
  (cons p (cons length width))
  ) ; p is btm left corner

(define (print-rectangular-2 rectangle)
    (display "Rectangle at point")
    (print-point (car rectangle))
    (display "With length ")
    (display (car (cdr rectangle)))
    (display "and width ")
    (display (cdr (cdr rectangle)))
  )

(define r2 (make-rectangular-2 (make-point 0 0) 3 4))
(define (length-2 rectangle) (car (cdr rectangle)))
(define (width-2 rectangle) (cdr (cdr rectangle)))

(area (length-2 r2) (width-2 r2)) ;12
(perimeter (length-2 r2) (width-2 r2)) ; 14