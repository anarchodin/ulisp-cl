(in-package #:ulisp-impl)

;; Rather tricky: save-image load-image edit

(defun ulisp::globals ()
  (let ((ulisp (find-package :ulisp))
	(globals '()))
    (do-symbols (sym ulisp (nreverse globals))
      (when (and (eq (symbol-package sym) ulisp)
		 (boundp sym))
	(push sym globals)))))

(defun ulisp::pprintall ()
  (dolist (global (ulisp::globals))
    (when (fboundp global)
      (pprint (symbol-value global)))))

(defmacro ulisp::defun (name lambda-list &body body)
  "A replacement defun, to deal with uLisp's Lisp-1 tendencies."
  `(let ()
     (declare (special ,name))
     (setq ,name (quote (ulisp::defun ,name ,lambda-list ,@body)))
     (setf (symbol-function (quote ,name)) (labels ((,name ,lambda-list ,@body))
                                             (function ,name)))))

(defun ulisp::funcall (func &rest args)
  "A replacement funcall, to deal with uLisp's Lisp-1 tendencies."
  (cond ((functionp func)
	 (apply func args))
	((and (consp func) (eq (car func) 'ulisp::defun)
	      (fboundp (second func)))
	 (apply (symbol-function (second func)) args))))

(defun ulisp::gc ()
  #+ccl (ccl:gc)
  #+lispworks (hcl:gc-if-needed)
  #+sbcl (sb-ext:gc))

(defvar *lisp-library* '()
  "Used on microcontroller platforms as a way to provide functions that are ready to go on reset.")

(defun ulisp::list-library ()
  (let ((libraries '()))
    (dolist (item *lisp-library* (nreverse libraries))
      (if (eq (car item) 'ulisp::defun)
	  (push (second item) libraries)))))

(defun ulisp::require (name)
  (dolist (item *lisp-library*)
    (if (eq name (second item))
	(return-from ulisp::require item))))

;; A symbol to hack around lack of multiple values returned.
(define-symbol-macro ulisp::nothing (values))

(defmacro ulisp::loop (&body forms)
  "A simple looping facility."
  (let ((label (gensym)))
  `(block nil (tagbody ,label ,@forms (go ,label)))))

;; Arduino funcs?

(defvar *start* #.(get-internal-real-time))
(defconstant *ms-factor* #.(/ internal-time-units-per-second 1000))
(defun ulisp::millis ()
  "Count of milliseconds since the system was started."
  (* (- (get-internal-real-time) *start*) *ms-factor*))
