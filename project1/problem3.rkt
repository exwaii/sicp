#lang sicp

;Problem 3: Flight Time
; Given an initial upward velocity (in meters per second, or m/s) and initial elevation or
; height (in meters, or m), write a procedure that computes how long the baseball will be in
; flight. Remember that gravity is a downward acceleration of 9.8m/s2
; . Note that to solve
; this you will need a root of a quadratic equation. Try using root1, and using root2.
; Only one of these solutions makes sense. Which one? And why? Use this to create a
; correct version of the procedure below.

(define (square x) (* x x))

(define root1
  (lambda (a b c)
    (/
     (- (sqrt (- (square b) (* 4 a c))) b)
     (* 2.0 a)
     )))


(define root2
  (lambda (a b c)
    (/
     (- (* -1 b) (sqrt (- (square b) (* 4 a c))))
     (* 2.0 a)
     )))

(define time-to-impact
  (lambda (vertical-velocity elevation)
    (let ((r1 (root1 -4.9 vertical-velocity elevation)) (r2 (root2 -4.9 vertical-velocity elevation)))
    (if (>= r1 r2) r1 r2)
    )
    ))

; y(t) = -9.8/2 * t^2 + vertical-velocity * t + elevation
; want to find t s.t y(t) = 0 and t is > 0

(time-to-impact -12 10)

; In some cases, we may want to know how long it takes for the ball to drop to a particular
; height, other than 0. Using your previous procedure as a template, write a procedure that
; computes the time for the ball to reach a given target elevation.


(define time-to-height
  (lambda (vertical-velocity elevation target-elevation)
    (if (and (> target-elevation elevation) (< vertical-velocity 0)) (error "unable to reach elevation"))
    (let ((r1 (root1 -4.9 vertical-velocity (- elevation target-elevation))) (r2 (root2 -4.9 vertical-velocity (- elevation target-elevation))))
    (if (>= r1 r2) r1 r2)
    )))

(time-to-height -12 10 15)

; y(t) = -9.8/2 * t^2 + vertical-velocity * t + elevation
; want to find t s.t y(t) = target-elevation and t is > 0 -> same as solving -9.8/2 * t^2 + vertical-velocity * t + elevation - target-elevation