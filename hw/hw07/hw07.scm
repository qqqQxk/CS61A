(define (filter-lst fn lst)
  'YOUR-CODE-HERE
  (if(null? lst)
    (list)
    (if(fn (car lst))
      (append (list(car lst)) (filter-lst fn (cdr lst)))
      (filter-lst fn (cdr lst))
    )
  )
)

;;; Tests
(define (even? x)
  (= (modulo x 2) 0))
(filter-lst even? '(0 1 1 2 3 5 8))
; expect (0 2 8)


(define (interleave first second)
  'YOUR-CODE-HERE
  (cond
    ((and (null? first) (null? second)) (list))
    ((null? first) (interleave second first))
    ((null? second) first)
    (else (append (list (car first)) (list(car second)) (interleave (cdr first) (cdr second))))
  )
)

(interleave (list 1 3 5) (list 2 4 6))
; expect (1 2 3 4 5 6)

(interleave (list 1 3 5) nil)
; expect (1 3 5)

(interleave (list 1 3 5) (list 2 4))
; expect (1 2 3 4 5)


(define (accumulate combiner start n term)
  'YOUR-CODE-HERE
  (define (calc combiner n term)
    (if(> n 1)
        (combiner (term n) (calc combiner (- n 1) term))
        (term n)
    )
  )
  (combiner start (calc combiner n term))
)


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
