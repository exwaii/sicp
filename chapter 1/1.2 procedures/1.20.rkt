#lang sicp

;Exercise 1.20.  The process that a procedure generates is of course dependent on the rules used by the interpreter. As an example, consider the iterative gcd procedure given above. Suppose we were to interpret this procedure using normal-order evaluation, as discussed in section 1.1.5. (The normal-order-evaluation rule for if is described in exercise 1.5.) Using the substitution method (for normal order), illustrate the process generated in evaluating (gcd 206 40) and indicate the remainder operations that are actually performed. How many remainder operations are actually performed in the normal-order evaluation of (gcd 206 40)? In the applicative-order evaluation?

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

; normal-order
; (gcd 206 40)
; (gcd 40 (% 206 40))
; if (= (% 206 40) 0) 
; if (= 6 0) evaluated once
; (gcd (% 206 40) (% 40 (% 206 40)))
; if (= (% 40 (% 206 40)) 0) 
; if (= (% 40 6) 0) evaluated twice 
; if (= 4 0) evaluated thrice
; (gcd (% 40 (% 206 40)) (% (% 206 40) (% 40 (% 206 40)))
; if (= (% (% 206 40) (% 40 (% 206 40)) 0)
; if (= (% (6) (% 40 6)) 0) evaluated 5 times
; if (= (% 6 4) 0) evaluated 6 times
; if (= 2 0) evaluated 7 times
; ...

; how many times is this? every gcd call has new remainder calls to its arguments
; at first gcd(a, b) has 0 in a and 0 in b
; then gcd(b, a % b) has 0 in a and 1 in b 
; then gcd(a % b, b % (a % b)) has 1 in a and 2 in b
; this is like the fibonacci sequence, number of remainders in b -> a, number of remainders in b + number of remainders in a + 1 -> b
; at each gcd call the remainder calls in b are performed (for the if conditional), and for the final one the remainder calls in a are performed (because a is returned)
; and since we know (gcd 206 40) -> (gcd 40 6) -> (gcd 6 4) -> (gcd 4, 2) -> (gcd 2, 0) -> 2
; this is           a=0, b=0     -> a=0, b=1   -> a=1, b=2  -> a=2, b=4   -> a=4, b=7   -> a=4
; 0+1+2+4+7+4 = 18 times

; applicative-order
; (gcd 206 40)
; (gcd 40 (% 206 40)) evaluated once
; (gcd 40 6)
; (gcd 6 (% 40 6)) evaluated twice
; (gcd 6 4)
; (gcd 4 (% 6 4)) evaluated thrice
; (gcd 4 2)
; (gcd 2 (% 4 2) evaluated four times
; (gcd 2 0)
; 2