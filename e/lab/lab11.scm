#1
(define (make-kwlist1 keys values)
    (cons keys (cons values nil))
)

(define (get-keys-kwlist1 kwlist)
    (car kwlist)
)

(define (get-values-kwlist1 kwlist)
    (cadr kwlist)
)

(define (make-kwlist2 keys values)
    (if (or (null? keys) (null? values))
        '()
        (cons (list (car keys) (car values))
              (make-kwlist2 (cdr keys) (cdr values))))
)
;这样更简洁，但是cs61a评分系统的map只能接受一个列表
;(define (make-kwlist2 keys values)
;    (map list keys values)
;)

(define (get-keys-kwlist2 kwlist)
    (map car kwlist)
)

(define (get-values-kwlist2 kwlist)
    (map cadr kwlist)
)

#2
(define (add-to-kwlist kwlist key value)
    (make-kwlist (append (get-keys-kwlist kwlist) (list key)) (append (get-values-kwlist kwlist) (list value)))
)

#3
(define (get-first-from-kwlist kwlist key)
    (let ((keys (get-keys-kwlist kwlist)) (values (get-values-kwlist kwlist)))
          (define (helper keys values)
                  (cond
                  ((null? keys) nil)
                  ((eq? (car keys) key) (car values))
                  (else (helper (cdr keys) (cdr values)))))
          (helper keys values))
)
