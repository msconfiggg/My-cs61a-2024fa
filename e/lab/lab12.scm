#13
(define (no-repeats s)
    (if (null? s)
        s
        (cons (car s) (no-repeats (filter (lambda (x) (not (= x (car s)))) (cdr s)))))
)

#14
(define (without-duplicates lst)
    (if (null? lst) lst
        (cons (car lst) 
                (without-duplicates (filter (lambda (x) (not (= x (car lst)))) (cdr lst)))))
)

#15
(define (reverse lst)
    (if (null? lst)
        lst
        (append (reverse (cdr lst)) (list (car lst))))
)