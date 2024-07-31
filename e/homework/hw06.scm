#1
(define (square n) (* n n))

(define (pow base exp)
    (cond
        ((= exp 0) 1)
        ((even? exp) (square (pow base (quotient exp 2))))
        (else (* base (square (pow base (quotient exp 2))))))
)

#2
(define (repeatedly-cube n x)
    (if (zero? n)
        x
        (let
            ((y (repeatedly-cube (- n 1) x)))
            (* y y y))))

#3
(define (cddr s)
    (cdr (cdr s)))

(define (cadr s)
    (car (cdr s))
)

(define (caddr s)
    (car (cdr (cdr s)))
)

#4
(define (ascending? s)
    (cond
        ((null? s) #t)
        ((null? (cdr s)) #t)
        ((> (car s) (car (cdr s))) #f)
        (else (ascending? (cdr s))))
)

#5
(define (my-filter pred s)
    (cond
        ((null? s) s)
        ((pred (car s)) (cons (car s) (my-filter pred (cdr s))))
        (else (my-filter pred (cdr s))))
)

#6
(define (no-repeats s)
    (if (null? s)
        s
        (cons (car s) (no-repeats (filter (lambda (x) (not (= x (car s)))) (cdr s)))))
)

#7
; helper function
; returns the values of lst that are bigger than x
; e.g., (larger-values 3 '(1 2 3 4 5 1 2 3 4 5)) --> (4 5 4 5)
(define (larger-values x lst)
    (cond
        ((null? lst) lst)
        ((> (car lst) x) (cons (car lst) (larger-values x (cdr lst))))
        (else (larger-values x (cdr lst)))))

(define (longest-increasing-subsequence lst)
    ; the following skeleton is optional, remove if you like
    (if (null? lst)
        nil
        (begin
            (define first (car lst))
            (define rest (cdr lst))
            (define large-values-rest
                (longest-increasing-subsequence (larger-values first rest)))
            (define with-first
                (cons first large-values-rest))
            (define without-first
                (longest-increasing-subsequence rest))
            (if (> (length with-first) (length without-first))
                with-first
                without-first))))

#8
;;; > (remove-parens '(((1) 2 3) 4 5 (6 (7)) (8 10)))
;;; (1 2 3 4 5 6 7 8 10)
;;; > (remove-parens '(((a) b (c) ()) (d) e (f (((g)))) (h i)))
;;; (a b c d e f g h i)
(define (remove-parens s)
    (cond
        ( (null? s) s )
        ( (list? (car s)) (append (remove-parens (car s)) (remove-parens (cdr s))))
        ( else (cons (car s) (remove-parens (cdr s))))))

#9
(define (make-necklace beads length)
    ; Returns a list where each value is taken from the BEADS list,
    ; repeating the values BEADS until the list has reached
    ; LENGTH. You can assume that LENGTH is greater than or equal to 1,
    ; and that there is at least one bead in BEADS.
    (if (= length 0)
        '()
        (cons (car beads)
            (make-necklace
            (append (cdr beads) (list(car beads)))
            (- length 1)
            )
        )
    )
)
; Doctests
(expect (make-necklace '(~ *) 3) (~ * ~))
(expect (make-necklace '(~ ^) 4) (~ ^ ~ ^))
(expect (make-necklace '(> 0 <) 9) (> 0 < > 0 < > 0 <))

#10
;;; Construct a repeated call expression from an operator and a list of operands.
;;;
;;; scm> (repeated-call 'f '(2 3 4))
;;; (((f 2) 3) 4)
;;; scm> (repeated-call '(f 2) '(3 4))
;;; (((f 2) 3) 4)
;;; scm> (repeated-call 'f nil)
;;; f
(define (repeated-call operator operands)
    (if (null? operands)
        operator
        (repeated-call (list operator (car operands)) (cdr operands))))

;;; Return a curried version of f that can be called repeatedly num-args times.
;;;
;;; scm> (((((curry 3) +) 4) 5) 6) ; (+ 4 5 6) evaluates to 15
;;; 15
;;; scm> ((curry 0) +) ; (+) evaluates to 0
;;; 0
;;; scm> (((curry 1) +) 3) ; (+ 3) evaluates to 3
;;; 3
;;; scm> (((((curry 3) list) 4) 5) 6) ; (list 4 5 6) evaluates to (4 5 6)
;;; (4 5 6)
(define (curry num-args)
    (lambda (f) (curry-helper num-args (lambda (s) (apply f s)))))
;;; curry-helper's argument g is a one-argument procedure that takes a list.
;;;
;;; scm> ((((curry-helper 3 cdr) 5) 6) 7) ; (cdr '(5 6 7)) => (6 7)
;;; (6 7)
(define (curry-helper num-args g)
    (if (= num-args 0)
        (g '())
        (lambda (x) (curry-helper (- num-args 1) (lambda (s) (g (cons x s)))))))

;;; Take a (possibly nested) call expression s and return
;;; an equivalent expression in which all calls have one argument.
;;;
;;; scm> (one-arg '(abs 3)) ; (abs 3) already takes just 1 argument
;;; (abs 3)
;;;
;;; scm> (+ 4 5 6)
;;; 15
;;; scm> (one-arg '(+ 4 5 6))
;;; (((((curry 3) +) 4) 5) 6)
;;; scm> (eval (one-arg '(+ 4 5 6))) ; Same value as (+ 4 5 6)
;;; 15
;;;
;;; scm> (one-arg '(+ (- 4) (*) (* 5 6)))
;;; (((((curry 3) +) (- 4)) ((curry 0) *)) ((((curry 2) *) 5) 6))
(define (one-arg s)
    (if (number? s) s
        (let ((num-args (- (length s) 1)))
            (if (= num-args 1)
                (list (car s) (one-arg (car (cdr s)))))
                (repeated-call (list (list 'curry num-args) (car s))
                                (map one-arg (cdr s))))))
