(define (split-at lst n)
  'YOUR-CODE-HERE
  (cond
    ((null? lst) (list (list)))
    ((= n 0) (append (list (list)) lst))
    (else (begin
                (define new (split-at (cdr lst) (- n 1)))
                (append (list
                  (cons (car lst) (car new))) (cdr new))
                ))
  )
)


(define (compose-all funcs)
  'YOUR-CODE-HERE
  (define (helper x lst)
    (if (null? lst)
        x
        (helper (apply (car lst) (list x)) (cdr lst))
    )
  )
  (lambda (x) (helper x funcs))
)

