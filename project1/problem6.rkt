#lang sicp

;Problem 6: So why aren’t baseball outfields 600 feet deep?
; Let’s go back to our distances. Why are these numbers for distances hit so unrealistic? --
; because we haven’t accounted for air friction or drag. (Of course there are some other
; effects, like spin, but we’ll just stick with drag). Let’s think about this. Newton’s
; equation basically says that the movement of the ball will be governed by:
; Drag + gravity = mass * acceleration
; We can get the mass of a baseball (.15 kg). We know that force due to gravity – mass *
; 9.8 m/sec^2. The force due to drag is given by:
; ½ C rho A vel^2
; where C is the drag coefficient (about 0.5 for baseball sized objects); rho is the density of
; air (about 1.25 kg/m^3 at sea level for moderate humidity – not a bad approximation for
; Boston, but about 1.06 for Denver); A is the cross-sectional area of the baseball (which is
; pi D^2/4, where D is the diameter of a baseball – about 0.074 m). Let’s denote ½ C rho
; A by the constant beta. Then we see that the drag on a baseball is basically proportional
; to the square of the velocity of the ball. So there is more drag when the ball is moving
; faster.
; How can we compute the distance traveled by a baseball, but taking into account this
; drag effect? Basically we have four coupled linear differential equations:
; Let’s let x and y denote the two components of position of the baseball, and let’s let u
; denote the velocity in the horizontal direction, and v denote the velocity in the vertical
; direction. We will let V denote the magnitude of the velocity. Then the equations of
; motion are:
; dx/dt = u
; dy/dt = v
; du/dt = -1/m sqrt(u^2 + v^2) u beta
; dv/dt= -1/m sqrt(u^2 + v^2) v beta - g
; We can rewrite these as
; dx = u dt
; dy = v dt
; du = - 1/m beta sqrt(u^2 + v^2) u dt
; dv = - (1/m sqrt(u^2+v^2) v beta + g) dt
; We also have some initial conditions on these parameters
; x_0 = 0
; y_0 = h
; u_0 = V cos alpha
; v_0 = V sin alpha
; where alpha is the angle of the initial hit with respect to the ground, V is the initial
; velocity, and h is the initial height of the ball.
; To find the distance traveled, we need to integrate these equations. That is, starting with
; the initial values, we want to move forward a small step in time (say 0.01 seconds), and
; compute the change in x and y, given the current estimates for velocity. This will gives
; us the new values of x and y. Similarly, we want to compute the change in u and v, and
; thus, the new values for u and v. We can keep recursively estimating these values until
; the value for y drops below 0, in which case the value for x tells us the distance traveled.
; Based on this idea, write a procedure called integrate, which performs this
; computation. Using this, write a procedure called travel-distance, which given an
; initial elevation, an initial magnitude for the velocity, and an initial angle of launch,
; computes the distance traveled while accounting for drag.
; Use this to determine how far a baseball will travel with an angle of 45 degrees, using
; initial velocities of 45 m/sec, 40 m/sec, 35 m/sec.
; How quickly does the distance drop when the angle changes, i.e., how easily does a home
; run turn into a fly out? Run same examples and report on this. For instance, suppose that
; the outfield fence is 300 feet from home plate, and that the batter has very quick bat
; speed, swing at about 100 mph (or 45 m/sec). For what range of angles will the ball land
; over the fence?
; How much does this change if we were in Denver rather than Boston? Report on some
; examples.
(define (square x) (* x x))

(define pi 3.14159)

(define degree2radian
  (lambda (deg)
    (/ (* deg pi) 180.)))

(define C 0.5)
(define rho 1.06) ; denver
(define D 0.074)
(define A (/ (* pi (square D)) 4))
(define beta (* 0.5 C rho A))

(define m 0.15)

(define dt 0.01)

(define (du u v)
  (* (/ -1 m) (sqrt (+ (square u) (square v))) beta u dt)
  )

(define (dv u v)
  (* (+ (* (/ 1 m) (sqrt (+ (square u) (square v))) v beta) 9.8) dt -1))


(define (dx u) (* u dt))

(define (dy v) (* v dt))


(define (integrate h initial-velocity angle)
  (define (inner x y u v)
    (if (< y 0) x
        (inner (+ x (dx u)) (+ y (dy v)) (+ u (du u v)) (+ v (dv u v)))
        )
    )
  (inner 0 h (* initial-velocity (cos (degree2radian angle))) (* initial-velocity (sin (degree2radian angle))))
  )

(define (travel-distance elevation velocity angle) (integrate elevation velocity angle))

(travel-distance 1 45 45) ;93.78770010795617 boston 101.42759213367684 denver
(travel-distance 1 40 45) ;82.87516916948913 boston 89.06327175789674 denver
(travel-distance 1 35 45) ;71.15953609235684 boston 75.80199732252579 denver