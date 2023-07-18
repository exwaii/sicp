#lang sicp

;Exercise 1.22.  Most Lisp implementations include a primitive called runtime that returns an integer that specifies the amount of time the system has been running (measured, for example, in microseconds). The following timed-prime-test procedure, when called with an integer n, prints n and checks to see if n is prime. If n is prime, the procedure prints three asterisks followed by the amount of time used in performing the test.

(define (prime? n)
  (= n (smallest-divisor n)))
(define (square x) (* x x))
(define (smallest-divisor n)
  (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))
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

;Using this procedure, write a procedure search-for-primes that checks the primality of consecutive odd integers in a specified range. Use your procedure to find the three smallest primes larger than 1000; larger than 10,000; larger than 100,000; larger than 1,000,000. Note the time needed to test each prime. Since the testing algorithm has order of growth of (n), you should expect that testing for primes around 10,000 should take about 10 times as long as testing for primes around 1000. Do your timing data bear this out? How well do the data for 100,000 and 1,000,000 support the n prediction? Is your result compatible with the notion that programs on your machine run in time proportional to the number of steps required for the computation?

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
; smallest primes > 1000 are 1009, 1019, 1021, times taken were 1 3 and 2
(odd-primality-check 10001 10051)
; smallest primes > 10000 are 10007 10009 and 10037. times taken were aroundt he same
(odd-primality-check 100001 100051)
; smallest primes > 100000 are 100003, 100019, 100043. times are also around the same
(odd-primality-check 1000001 1000051)
; smallest primes > 1000000 are 1000003, 100033, 1000037. times taken have doubled (around 6-7)
(odd-primality-check 1000000001 1000000051)
; smallest primes > 1000000000 are 1000000007, 1000000009, 1000000021. times taken increased a magnitude (around 170)

;results are not proportional to linear, maybe because of optimisations or maybe because numbers are not large enough