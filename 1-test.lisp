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

(section p1-5
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
  )

(section p1-6
  (print '1.6)

  (define (new-if predicate then-clause else-clause)
    (cond (predicate then-clause)
          (t else-clause)))
  (define (sqrt-iter guess x)
    (new-if (good-enough? guess x)
            guess
            (sqrt-iter (improve guess x) x)))
  ; (sqrt-iter 1.0 x)
  ;-> (cond ((good-enough? guess x) guess)
  ;         (t (sqrt-iter (..) x))))
  ; Applicative: (good-enough? guess x) is evaluated. => terminate
  ; Normal:      (sqrt-iter () x) may be expanded FOREVER!
  )

(section p1-7
  (print 1.7)
  (define (good-enough? guess x)
    (< (abs (- (* guess guess) x)) 0.001))
  ; Large num: if num is integer, it goes correct.
  ; case: significant digits sqrt(11111111119.0**2) = 11111111111.0
  (defparameter x 11111111111.0)
  (defparameter y 11111111119.0)
  (defparameter xx (* x x))
  (defparameter yy (* y y))
  (print (good-enough? x (* y y)))
  ; Small num:
  ; case: target that is smaller than 0.01 cannot be correct
  ;       -> square makes them smaller than delta (= 0.001)
  (defparameter x 0.01)
  (defparameter y 0.02)
  (defparameter xx (* x x))
  (defparameter yy (* y y))
  (print (good-enough? x (* y y))))

(section p1-8
  (print 1.8)

  (define (good-enough-cube? guess x)
    (< (abs (- (* guess guess guess) x)) 0.0000001))

  (define (improve-cube guess x)
    (/ (+ (/ x (* guess guess))
          (* 2 guess))
       3))

  (define (my-cubic-root-iter guess x)
    (if (good-enough-cube? guess x)
        guess
        (my-cubic-root-iter (improve-cube guess x) x)))

  (define (my-cubic-root tar)
    (my-cubic-root-iter 1.0 tar))

  (test (my-cubic-root 8) 2.0)
  (test (my-cubic-root 27) 3.0)
  (test (my-cubic-root 64) 4.0)
  (test (my-cubic-root 125) 5.0)
  (test (my-cubic-root (* 125 64 27 8)) 120.0))

nil
