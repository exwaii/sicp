#lang sicp
; Exercise 2.6.  In case representing pairs as procedures wasn't mind-boggling enough, consider that, in a language that can manipulate procedures, we can get by without numbers (at least insofar as nonnegative integers are concerned) by implementing 0 and the operation of adding 1 as

(define zero (lambda (f) (lambda (x) x))) ; ok, from what i've researched, nth number is a function that takes a function f and applies f n times to x. hence 0 = x

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x))))) ; n+1 = f (f^n(x)) = f^n+1(x)

; from this,
(define one (lambda (f) (lambda (x) (f x))))

; from (add-1 zero) -> (lambda (f) (lambda (x) (f ((zero f) x)))))
                ;   -> (lambda (f) (lambda (x) (f ((lambda (x) x) x)))))
                ;   -> (lambda (f) (lambda (x) (f x))))
                ; yay

(define two (lambda (f) (lambda (x) (f (f x))))) ; following our logic

; from (add-1 one) -> (lambda (f) (lambda (x) (f ((one f) x))))
                ;  -> (lambda (f) (lambda (x) (f ((lambda(x) (f x) x))))
                ;  -> (lambda (f) (lambda (x) (f (f x))))

; This representation is known as Church numerals, after its inventor, Alonzo Church, the logician who invented the  calculus.

; Define one and two directly (not in terms of zero and add-1). (Hint: Use substitution to evaluate (add-1 zero)). Give a direct definition of the addition procedure + (not in terms of repeated application of add-1).



(define (eval-church num)
  ((num inc) 0))

(eval-church zero)
(eval-church one)
(eval-church two)
