#lang sicp
; Problem 4: Flight Distance
; Suppose the baseball is hit with some velocity v, at a starting angle alpha relative to the
; horizontal (in degrees), and from an initial elevation (in meters). We wish to compute the
; distance in the horizontal direction the baseball will travel by the time it lands.
; Remember that some of the velocity vector goes into the x direction, and some into the y,
; as pictured in Figure 2 below.
; y
; elevation
; 0
; α
; vx
; g
; vy
; v
; x
; 0 distance
; Figure 2: Motion of a baseball in two dimensions, acting under gravitational acceleration
; g.
; Checking the Scheme manual, you will find procedures sin and cos. To use these
; (which require angles in radians rather than degrees), you may also find the procedure
; degree2radian useful. It is given below:



(define pi 3.14159)

(define degree2radian
  (lambda (deg)
    (/ (* deg pi) 180.)))

; Write a procedure travel-distance-simple that returns the lateral distance the
; baseball thrown with given velocity, angle, and initial elevation will travel before hitting
; the ground.

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

; Try this out for some values. Note that we are doing everything in metric units (distances
; in meters, weight in kilograms). You may be more accustomed to thinking about
; baseball in English units (e.g. feet). So we have created some simple procedures to
; convert feet to meters and vice versa (see the code file for details).
; Using your code, determine the time to impact of a ball hit at a height of 1 meter (right
; down the middle of the plate) with an initial velocity of 45 m/sec (about 100 mph – about
; what a really good professional player can do – without steroids), at angles of 0, 45 and
; 90 degrees (be sure to use radian units or degree units depending on how you provide
; input to sin and cos, but remember that those procedures expect arguments in units of
; radians).
; How far does the baseball travel in each case? Provide answers both in meters and feet.
; Notice the distance traveled in feet for a ball hit at a 45 degree angle, with this bat speed.
; Seems incredible – right? We’ll come back to this in a little bit.

(travel-distance-simple 1 45 0) ;20.32892781536815
(travel-distance-simple 1 45 45) ;207.6278611514906
(travel-distance-simple 1 45 90) ;0.000549641898961246
(travel-distance-simple 1 45 60) ;179.5248102144831
