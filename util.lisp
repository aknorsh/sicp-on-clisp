(defmacro dm (&body body)
  `(defmacro ,@body))

(defmacro mac (expr)
  `(pprint (macroexpand-1 ',expr)))

(defmacro section (name &body body)
  `(defun ,name ()
     (progn ,@body)))

;#################################
; Scheme -> Common Lisp macro
;#################################

(defmacro define (&body body)
  (if (listp (car body))
      `(defun ,(caar body) ,(cdar body) ,@(cdr body))
      `(defparameter ,@body)))
