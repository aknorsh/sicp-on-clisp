(load "./util.lisp")

; ################################################
; 1.1 プログラミングの要素
; ################################################

;1.1.1 式

; combination = (operator ...operand)
; : prefix notation

(section exp-number
  486
  (+ 137 349)
  (- 1000 334)
  (* 5 99)
  (/ 10 5)
  (+ 2.7 10)
  (+ 21 35 12 7) ; prefix notation with >2 args.
  (* 25 4 12)    ; prefix notation with >2 args.
  (+ (* 3 5) (- 10 6)) ; prefix notation with nest.
  (+ (* 3
        (+ (* 2 4)
           (+ 3 5)))
     (+ (- 10 7)
        6))      ; prefix notation with nest (pretty-printing)
)

;1.1.2 命名と環境

(section exp-variable-eval
  ; if defined, they are saved in global environment.
  (define size 2)
  (* 5 size) 
  (define my-pi 3.14159)
  (define radius 10)
  (* my-pi (* radius radius))
  (define circumference (* 2 my-pi radius)))

;1.1.3 組み合わせの評価

; NORMAL evaluation rule
; 1. eval parts
; 2. apply operator to operands

;---
; evaluation is recursive as its nature
; (tree accumulation)
; all eval step is goas ...
;  -number: result is its value
;  -operand: result is Object with it
; ALL SYMBOLS GET MEANS WITH """ENVIRONMENT"""

; SPECIAL evaluation rule
; such as
;  -define

;1.1.4 複合手続き

(section exp-compound-procedure
  (define (square x)
    (* x x))
  (square 21)
  (square (+ 2 5))
  (square (square 3))
  (define (sum-of-squares x y)
    (+ (square x) (square y)))
  (sum-of-squares 3 4)
  (define (f a)
    (sum-of-squares (+ a 1) (* a 2)))
  (f 5))

;1.1.5 手続き適用の置換モデル

;---
; Appling compound procedure to args means...
; 1. substitute args
; 2. eval it

; APPLICATIVE-ORDER EVALUATION (適用順序評価)
; (f 5)
;-> (sum-of-squares (+ 5 1) (* 5 2)) ; substitute
;-> (sum-of-squares 6 10)            ; eval
;-> (+ (square 6) (square 10))       ; substitute
;-> (+ (* 6 6) (* 10 10))            ; substitute
;-> (+ 36 100)            ; eval
;-> 136                   ; eval

; NORMAL ORDER EVALUATION (正規順序評価)
; (f 5)
;-> (sum-of-squares (+ 5 1) (* 5 2))            ; substitute
;-> (+ (square (+ 5 1)) (square (* 5 2)))       ; substitute
;-> (+ (* (+ 5 1) (+ 5 1)) (* (* 5 2) (* 5 2))) ; substitute
;-> (+ (* 6 6) (* 10 10)) ; eval
;-> (+ 36 100)            ; eval
;-> 136                   ; eval

;1.1.6 条件式と述語

(section case-analysis-with-cond
  ; (cond (...clause))
  ; clause: (<p> <e>)
  ;  p: predicate 述語
  ;  e: consequent expression 結果式
  (define (my-abs x)
    (cond ((> x 0) x)
          ((= x 0) 0)
          ((< x 0) (- x))))
  (define (my-abs2 x)
    (cond ((< x 0) (- x))
          (t x)))
  ; (if <p> <c> <a>)
  ;  a: alternative
  (define (my-abs3 x)
    (if (< x 0)
        (- x)
        x))
  ; (and) (or) (not) -> compound predicates
  ; !(and)(or): SPECIAL case (not procedural)
  )

;1.1.7 例：ニュートン法による平方根

(section my-sqrt-with-newton
  (define (average a b)
    (/ (+ a b) 2))

  (define (improve guess x)
    (average guess (/ x guess)))

  (define (square x)
    (* x x))

  (define (good-enough? guess x)
    (< (abs (- (square guess) x)) 0.001))

  (define (sqrt-iter guess x)
    (if (good-enough? guess x)
        guess
        (sqrt-iter (improve guess x) x)))

  (define (my-sqrt x)
    (sqrt-iter 1.0 x))

  (my-sqrt 9)
  (my-sqrt (+ 100 37))
  (my-sqrt (+ (my-sqrt 2) (my-sqrt 3)))
  (square (my-sqrt 1000)))

;1.1.8 ブラックボックス抽象化としての手続き

;Procedual Abstraction:
; When you call square, you don't have to care about how it's implemented.
; (that is, functions must be BLACK BOXed.)

; Naming of Dummy args should be arbitral
; -> Bound Variable (束縛変数):
;     They are bound in Scope.
;<-> Free variables: not bound. <, -, abs, square,,,
;     Procedure depends on how they work. 

; How to separate them?
; -> Local & inner definition using Block structure.

(section block-and-lexical-scoping
  (define (my-sqrt x)
  ; Just Block it
    (define (good-enough? guess x)
      (< (abs (- (square guess) x)) 0.001))
    (define (improve guess x) (average guess (/ x guess)))
    (define (sqrt-iter guess x)
      (if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x) x)))
    (sqrt-iter 1.0 x))

  (define (my-sqrt x)
  ; Use Lexical Scoping
    (define (good-enough? guess)
      (< (abs (- (square guess) x)) 0.001))
    (define (improve guess)
      (average guess (/ x guess)))
    (define (sqrt-iter guess)
      (if (good-enough? guess)
          guess
          (sqrt-iter (improve guess))))
    (sqrt-iter 1.0))
  ; In fact, it is not Localized. something goes wrong, maybe.
  (my-sqrt 10))

; ################################################
; 1.2 手続きとそれが生成するプロセス
; ################################################

;1.2.1 
