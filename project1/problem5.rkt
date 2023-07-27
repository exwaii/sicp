#lang sicp

(define pi 3.14159)

(define degree2radian
  (lambda (deg)
    (/ (* deg pi) 180.)))


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

(define travel-distance-simple
  (lambda (elevation velocity angle)
    (let ((y-velocity (* velocity (sin (degree2radian angle)))) (x-velocity (* velocity(cos (degree2radian angle)))))
      (* x-velocity (time-to-impact y-velocity elevation))
      )
    )
  )

;Problem 5: What’s the best angle to hit?
; Before we figure out why professional players don’t normally hit 700 foot home runs,
; let’s first see if we can find out the optimal angle at which to launch a baseball, in order
; to have it travel the furthest. Write a procedure find-best-angle that takes as
; arguments an initial elevation and an initial velocity, and which finds the best angle at
; which to hit the baseball to optimize distance traveled. You will probably want to write a
; recursive procedure that tries different angles between 0 and pi/2 radians, sampled every
; 0.01 radians (say) or between 0 and 90 degrees, sampled every 1 degree (depending on
; whether your code works in radians or degrees – either way be sure that you provide the
; right kind of unit to your trigonometric functions).

(define find-best-angle
  (lambda (velocity elevation)
    (define (inner angle curr-max max-angle)
      (if (> angle 90) max-angle
          (let ((result? (travel-distance-simple elevation velocity angle)))
            (if (> result? curr-max) (inner (+ angle 1) result? angle) (inner (+ angle 1) curr-max max-angle))
            )
          )
      )
    (inner 0.01 (travel-distance-simple elevation velocity 0) 0)
    ))

(find-best-angle 45 1) ; 45.01

; Use this for same sample values of elevation and velocity. What conclusion can you
; reach about the optimal angle of hitting?