(load "./util.lisp")

(section p1-1
  (print '1.1)
  (test 10 10)
  (test (- 9 1) 8)
  (test (/ 6 2) 3)
  (test (+ (* 2 4) (- 4 6)) 6)
  (test (define a 3) 'a)
  (test (define b (+ a 1)) 'b)
  (test (+ a b (* a b)) 19)
  (test (= a b) nil)
  (test (if (and (> b a) (< b (* a b)))
            b
            a) b)
  (test (cond ((= a 4) 6)
              ((= b 4) (+ 6 7 a))
              (t 25)) 16)
  (test (+ 2 (if (> b a) b a)) 6)
  (test (* (cond ((> a b) a)
                 ((< a b) b)
                 (t -1))
           (+ a 1)) 16))

(section p1-2
  (print '1.2)
  (print (list
           `(/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5))))) 
               (* 3 (- 6 2) (- 2 7))))))

(section p1-3
  (print '1.3)
  (define (i-like-large-num a b c)
    (cond ((and (<= a b) (<= a c)) (+ (* b b) (* c c)))
          ((and (<= b a) (<= b c)) (+ (* c c) (* a a)))
          (t (+ (* a a) (* b b)))))

  (test (i-like-large-num 1 2 3) 13)
  (test (i-like-large-num 2 3 1) 13)
  (test (i-like-large-num 3 1 2) 13)
  (test (i-like-large-num 3 2 1) 13)
  (test (i-like-large-num 2 1 3) 13)
  (test (i-like-large-num 1 3 2) 13)

  (test (i-like-large-num 1 1 2) 5)
  (test (i-like-large-num 1 2 1) 5)
  (test (i-like-large-num 2 1 1) 5)
  (test (i-like-large-num 1 1 1) 2))

(section p1-4
  (print '1.4)
  ;in common lisp,,,
  (define (a-plus-abs-b a b)
    (let ((target (list (if (> b 0) `+ `-) a b)))
      (eval target)))

  (test (a-plus-abs-b 3 4) 7)
  (test (a-plus-abs-b -3 4) 1)
  (test (a-plus-abs-b 3 -4) 7))

(print '1.5)

;(define (p) (p))
;(define (test x y)
;  (if (= x 0) 0 y))
;(test 0 (p))

; Applicative
; (test 0 (p))
; (if (= 0 0) 0 (p)) ; sub
; (if t 0 (p)) ; eval => eval true case
; 0 ; eval

; Normal
; (test 0 (p))
; (if (= 0 0) 0 (p)) ; sub
; (if (= 0 0) 0 (p)) ; sub (p)
; ...


; (test 0 (p)

nil
