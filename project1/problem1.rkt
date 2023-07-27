#lang sicp

;Problem 1: Some simple physics

; We are going to begin by modeling how far a baseball can travel – the same physics will
; hold for both hitting a ball and throwing a ball. We are going to simplify things by
; assuming that baseballs don’t spin as they move (clearly false but it makes life much
; easier). This means we can treat the movement of a baseball as if it were restricted to a
; two-dimensional plane. So what happens when a baseball is hit? For the moment, we'll
; model a baseball as a particle that moves along a single dimension with some initial
; position u, some initial velocity v, and some initial acceleration a, as pictured in Figure 1
; below. The equation for the position of the baseball at time t, given a, v, and u is ut = ½ a
; t
; 2
;  + v t + u. Note that this denotes a first order differential equation in time. Later, we can
; apply this equation to either the horizontal (x) component of baseball motion, or the
; vertical (y) component of baseball motion.
; v ut
; a
; Figure 1: Motion of a b in a generic direction.
; Write a procedure that takes as input values for a, v, u, and t and returns as output the
; position of the baseball at time t.
(define (square x) (* x x))

(define position
  (lambda (a v u t)
    (+
     (* (/ a 2.0) (square t))
     (* v t)
     u
     )
    )
  )
; Test your position code for at least the following cases:
(position 0 0 0 0) ; -> 0
(position 0 0 20 0) ; -> 20
(position 0 5 10 10) ; -> 60
(position 2 2 2 2) ; -> 10
(position 5 5 5 5) ; -> 92.5
; The template code file basebot.scm will have these tests, and other test cases for other
; procedures, which you should run (you can add/show your output values). In addition,
; you should add some test cases of your own to these to cover other boundary and typical
; conditions