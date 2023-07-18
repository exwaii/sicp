#lang sicp

;Exercise 1.13.  Prove that Fib(n) is the closest integer to phi^n/sqrt(5), where phi = (1 + sqrt(5))/2. Hint: Let psi = (1 - sqrt(5))/2. Use induction and the definition of the Fibonacci numbers (see section 1.2.2) to prove that Fib(n) = (phi^n - psi^n)/sqrt(5).

; first, inductive proof that fib(n) = (phi^n - psi^n)/sqrt(5)

; base case n = 0 and n = 1. 
; fib(0) = 0 = (1 - 1)/sqrt(5)
; fib(1) = 1 = sqrt(5)/sqrt(5) = (1 + sqrt(5) - (1 - sqrt(5))/2)/sqrt(5) = (phi - psi)/2

; funny lemma
; remember the quadratic formula
; consider the quadratic x^2 - x - 1 = 0
; by the quadratic formula the solutions are x = (1 + sqrt(5))/2 and (1 - sqrt(5))/2, or phi and psi !
; therefore, phi^2 - phi - 1 = 0 and psi^2 - psi - 1 = 0
; phi^2 = phi + 1 and psi^2 = psi + 1
; phi^k = phi^(k-1) + phi^(k-2) and psi^k = psi^(k-1) + psi^(k-2)

; inductive step: assume fib(n) = (phi^n - psi^n)/sqrt(5) for k - 1 and k - 2
; fib(k) = fib(k-1) + fib(k-2) (recurrence relation)
;        = (phi^(k-1) - psi^(k-1))/sqrt(5) + (phi^(k-2) - psi^(k-2))/sqrt(5)
;        = (phi^(k-1) + phi^(k-2) - (psi^(k-1) + psi^(k-2))/sqrt(5)
;        = (phi^k - psi^k)/sqrt(5) by the lemma
; as needed

; then, since fib(n) = (phi^n - psi^n)/sqrt(5) = phi^n/sqrt(5) - psi^n/sqrt(5)
; remains to show that abs(psi^n/sqrt(5)) < 1/2 or equivalently abs(psi)^n < sqrt(5)/2 for fib(n) to be the closest integer to phi^n/sqrt(5)
; notice since 0 > psi = (1 - sqrt(5))/2 > -2/2 = -1 as sqrt(5) < sqrt(9) = 3
; then abs(psi) < 1 and abs(psi)^n < 1 = 2/2 = sqrt(4)/2 < sqrt(5)/2 as needed
