#1
(define (fast-exp b n)
        ;; Computes b^n tail recursively by the method of repeated squaring.
        (define (fast-exp-tail b n result)
                (cond
                    ((= n 0) result)
                    ((even? n) (fast-exp-tail (square b) (/ n 2) result))
                    (else (fast-exp-tail b (- n 1) (* b result)))))
        (fast-exp-tail b n 1)
    )

#2
(define (reverse lst)
    (define (reverse-tail sofar rest)
            (if (null? rest)
                sofar
                (reverse-tail (cons (car rest) sofar) (cdr rest))))
    (reverse-tail nil lst)
)

(expect (reverse '(1 2 3)) (3 2 1))
(expect (reverse '(0 9 1 2)) (2 1 9 0))

#3
(define (distance city-a city-b)
    (let ((lat-a (get-lat city-a))
            (lon-a (get-lon city-a))
            (lat-b (get-lat city-b))
            (lon-b (get-lon city-b)))
        (sqrt (+ (expt (- lat-a lat-b) 2) (expt (- lon-a lon-b) 2))))
)

#4
(define (closer-city lat lon city-a city-b)
    (let ((new-city (make-city 'arb lat lon))
            (dista (distance city-a (make-city 'arb lat lon)))
            (distb (distance city-b (make-city 'arb lat lon))))
        (if (< dista distb)
            (get-name city-a)
            (get-name city-b)))
)