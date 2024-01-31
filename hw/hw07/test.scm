(define (no-repeats lst)
  'YOUR-CODE-HERE
  (define ans `())
  (define (rule x lst)
    (if(null? lst)
      #t
      (if(= x (car lst))
        #f
        (rule x (cdr lst))
      )
    )
  )
  (define (conduct lst)
    (if(null? lst)
      (list)
      (if(rule (car lst) ans)
          (begin
            (set! ans (append ans (list (car lst))))
            (conduct (cdr lst))
            ans
          )
          (conduct (cdr lst))
      )
    )
  )
  (conduct lst)
)
(no-repeats (list 5 4 5 4 2 2))