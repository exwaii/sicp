#lang sicp

;Exercise 1.23.  The smallest-divisor procedure shown at the start of this section does lots of needless testing: After it checks to see if the number is divisible by 2 there is no point in checking to see if it is divisible by any larger even numbers. This suggests that the values used for test-divisor should not be 2, 3, 4, 5, 6, ..., but rather 2, 3, 5, 7, 9, .... To implement this change, define a procedure next that returns 3 if its input is equal to 2 and otherwise returns its input plus 2. Modify the smallest-divisor procedure to use (next test-divisor) instead of (+ test-divisor 1). With timed-prime-test incorporating this modified version of smallest-divisor, run the test for each of the 12 primes found in exercise 1.22. Since this modification halves the number of test steps, you should expect it to run about twice as fast. Is this expectation confirmed? If not, what is the observed ratio of the speeds of the two algorithms, and how do you explain the fact that it is different from 2?

(define (prime? n)
  (= n (smallest-divisor n)))

(define (square x) (* x x))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next-divisor test-divisor)))))

(define (next-divisor n) (if (= n 2) 3 (+ n 2)))

(define (divides? a b)
  (= (remainder b a) 0))
(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))
(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) start-time))))
(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (odd-primality-check start end)
  (define (inner curr)
    (if (<= curr end)
        (begin
          (timed-prime-test curr)
          (inner (+ curr 2))))
    )
  (inner start)
  )

(odd-primality-check 1001 1051)
; smallest primes > 1000 are 1009, 1019, 1021, times taken were 1 1 and 2 (around the same)
(odd-primality-check 10001 10051)
; smallest primes > 10000 are 10007 10009 and 10037. times taken were  1 2 2 (around the same)
(odd-primality-check 100001 100051)
; smallest primes > 100000 are 100003, 100019, 100043. times were 3 3 2 (around the same)
(odd-primality-check 1000001 1000051)
; smallest primes > 1000000 are 1000003, 100033, 1000037. times taken is now 4 4 4 (roughly half)
(odd-primality-check 1000000001 1000000051)
; smallest primes > 1000000000 are 1000000007, 1000000009, 1000000021. times taken were 89 89 89 (around half)

; these timing tests are unreliable, lots of variance