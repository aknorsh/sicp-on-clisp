(defmacro dm (&body body)
  `(defmacro ,@body))

(defmacro mac (expr)
  `(pprint (macroexpand-1 ',expr)))

(defmacro section (name &body body)
  `(defun ,name ()
     (progn ,@body)))

;#################################
; Problem utils
;#################################

(defun test (actual expected)
  (if (eq actual expected)
      (print 'ok)
      (print 'wrong)))

;#################################
; Scheme -> Common Lisp macro
;#################################

(defmacro define (&body body)
  (if (listp (car body))
      `(defun ,(caar body) ,(cdar body) ,@(cdr body))
      `(defparameter ,@body)))

