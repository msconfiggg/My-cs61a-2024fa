#1
(define (over-or-under num1 num2)
    (if (< num1 num2)
        -1
    (if (= num1 num2)
        0 1))
)

(define (over-or-under num1 num2)
    (cond 
        ((< num1 num2) -1)
        ((= num1 num2) 0)
        (else 1))
)

#2
(define (make-adder num)
    (lambda (inc) (+ inc num))
)

#3
(define (composed f g)
    (lambda (x) (f (g x)))
)

#4
(define (repeat f n)
    (if (= n 1)
        f
        (composed f (repeat f (- n 1))))
)

(define (repeat f n)
    (if (< n 1)
        (lambda (x) x)
        (composed f (repeat f (- n 1))))
)

#5
(define (max a b) (if (> a b) a b))
(define (min a b) (if (> a b) b a))
(define (gcd a b)
    (if (= (modulo (max a b) (min a b)) 0)
        (min a b)
        (gcd (min a b) (modulo (max a b) (min a b))))
)

(define (gcd a b)
  (cond ((zero? a) b)
        ((zero? b) a)
        ((= (modulo (max a b) (min a b)) 0) (min a b))
        (else (gcd (min a b) (modulo (max a b) (min a b)))))
)

#6
(define (duplicate lst)
    (if (null? lst)
        lst
        (cons (car lst) (cons (car lst) (duplicate (cdr lst)))))
)

(expect (duplicate '(1 2 3)) (1 1 2 2 3 3))
(expect (duplicate '(1 1)) (1 1 1 1))

#7
(define (deep-map fn s)
    (if (null? s)
    s
    (if (list? (car s))
        (cons (deep-map fn (car s)) (deep-map fn (cdr s)))
        (cons (fn (car s)) (deep-map fn (cdr s)))))
)