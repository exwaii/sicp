#lang sicp

;Exercise 1.24.  Modify the timed-prime-test procedure of exercise 1.22 to use fast-prime? (the Fermat method), and test each of the 12 primes you found in that exercise. Since the Fermat test has (log n) growth, how would you expect the time to test primes near 1,000,000 to compare with the time needed to test primes near 1000? Do your data bear this out? Can you explain any discrepancy you find?

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
  (if (fast-prime? n 100)
      (report-prime (- (runtime) start-time)))
)
(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))       

(define (odd-primality-check start end)
  (define (inner curr)
    (if (<= curr end)
        (begin
          (timed-prime-test curr)
          (inner (+ curr 2))))
    )
  (inner start)
  )

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))


(odd-primality-check 1001 1051)
; smallest primes > 1000 are 1009, 1019, 1021, times taken were 32 29 and 29
(odd-primality-check 10001 10051)
; smallest primes > 10000 are 10007 10009 and 10037. times taken were around 35
(odd-primality-check 100001 100051)
; smallest primes > 100000 are 100003, 100019, 100043. times were aroudn 40
(odd-primality-check 1000001 1000051)
; smallest primes > 1000000 are 1000003, 100033, 1000037. times taken were around 45-60
(odd-primality-check 1000000001 1000000051)
; smallest primes > 1000000000 are 1000000007, 1000000009, 1000000021. times taken were around 70
; log growth is evident as seen below 
; discrepancies is that for 1k~ times are slower than linear case 
(odd-primality-check 1000000000001 1000000000051) ; times are still < 100