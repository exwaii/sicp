#lang sicp

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (make-interval a b) (cons a b))

(define (lower-bound interval) (car interval))
(define (upper-bound interval) (cdr interval))

(define (sub-interval x y) ; lower x - upper y is smallset, upper x - lower y largest
  (make-interval (- (lower-bound x) (upper-bound y)) (- (upper-bound x) (lower-bound y)))
  )

(define (width interval) (/ (- (upper-bound interval) (lower-bound interval)) 2))

(define (div-interval x y)
  (if (or (= (upper-bound y) 0) (= (lower-bound y) 0)) (error "division by zero - second interval spans zero"))
  (mul-interval x
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))))

; Exercise 2.11.  In passing, Ben also cryptically comments: ``By testing the signs of the endpoints of the intervals, it is possible to break mul-interval into nine cases, only one of which requires more than two multiplications.'' Rewrite this procedure using Ben's suggestion.
; + + + + -> min low times low max upp times upp
; + + - + -> min upp times low max upp times upp
; + + - - -> min upp times low max low times upp
; - + + + -> min low times upp max upp times upp
; - + - + -> min (min low times upp or upp times low) max (max low times low or upp times upp)
; - + - - -> min upp times low max low times low
; - - + + -> min low times upp max upp times low
; - - - + -> min low times upp max low times low
; - - - - -> min upp times upp max low times low

(define (mul-interval x y)
  (let ((l1 (lower-bound x))
        (u1 (upper-bound x))
        (l2 (lower-bound y))
        (u2 (upper-bound y)))
    (cond ((and (>= l1 0) (>= u1 0) (>= l2 0) (>= u2 0)) (make-interval (* l1 l2) (* u1 u2)))
          ((and (>= l1 0) (>= u1 0) (< l2 0) (>= u2 0)) (make-interval (* u1 l2) (* u1 u2)))
          ((and (>= l1 0) (>= u1 0) (< l2 0) (< u2 0)) (make-interval (* u1 l2) (* l1 u2)))
          ((and (< l1 0) (>= u1 0) (>= l2 0) (>= u2 0)) (make-interval (* l1 u2) (* u1 u2)))
          ((and (< l1 0) (>= u1 0) (< l2 0) (>= u2 0)) (make-interval (min (* l1 u2) (* u1 l2)) (max (* l1 l2) (* u1 u2))))
          ((and (< l1 0) (>= u1 0) (< l2 0) (< u2 0)) (make-interval (* u1 l2) (* l1 l2)))
          ((and (< l1 0) (< u1 0) (>= l2 0) (>= u2 0)) (make-interval (* l1 u2) (* u1 l2)))
          ((and (< l1 0) (< u1 0) (< l2 0) (>= u2 0)) (make-interval (* l1 u2) (* l1 l2)))
          ((and (< l1 0) (< u1 0) (< l2 0) (< u2 0)) (make-interval (* u1 u2) (* l1 l2)))
          )
    )
  )



(define (mul-interval-test x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))



(define (assert test)
  (if (not test)
      (error "Test failed")))

(define (run-tests)
  (let ((i1 (make-interval 2 5))
        (i2 (make-interval 3 6))
        (i3 (make-interval -1 4))
        (i4 (make-interval -3 -2))
        (i5 (make-interval -5 2))
        (i6 (make-interval 0 4)))

    (let ((test1 (equal? (mul-interval i1 i2) (mul-interval-test i1 i2)))
          (test2 (equal? (mul-interval i1 i3) (mul-interval-test i1 i3)))
          (test3 (equal? (mul-interval i1 i4) (mul-interval-test i1 i4)))
          (test4 (equal? (mul-interval i1 i5) (mul-interval-test i1 i5)))
          (test5 (equal? (mul-interval i2 i3) (mul-interval-test i2 i3)))
          (test6 (equal? (mul-interval i2 i4) (mul-interval-test i2 i4)))
          (test7 (equal? (mul-interval i2 i5) (mul-interval-test i2 i5)))
          (test8 (equal? (mul-interval i3 i4) (mul-interval-test i3 i4)))
          (test9 (equal? (mul-interval i3 i5) (mul-interval-test i3 i5)))
          (test10 (equal? (mul-interval i1 i6) (mul-interval-test i1 i6))))

      (assert test1)
      (assert test2)
      (assert test3)
      (assert test4)
      (assert test5)
      (assert test6)
      (assert test7)
      (assert test8)
      (assert test9)
      (assert test10) ; all pass :D :D

      )
    ))



(run-tests)