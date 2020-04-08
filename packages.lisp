(defpackage #:ulisp-impl
  (:use :common-lisp))

(defpackage #:ulisp
  (:use)
  (:import-from #:common-lisp
		nil t
		+ - * / 1+ 1-
		abs mod random max min
		= /= < > <= >= plusp minusp zerop oddp evenp
		logand logior logxor lognot ash logbitp
		cons first second third rest car cdr
		caar cadr cdar cddr
		caaar caadr cadar caddr cdaar cdadr cddar cdddr
		length reverse nth sort
		let let* lambda defvar
		if cond when unless case not or and
		null atom listp consp numberp streamp eq
		char char-code code-char characterp
		subseq string< string> string= stringp string concatenate
		read-from-string prin1-to-string princ-to-string
		return dolist dotimes mapc mapcar mapcan assoc progn member
		apply eval
		setf push pop incf decf
		makunbound break room trace untrace sleep
		read print princ prin1 pprint terpri read-byte write-byte
		read-line write-line write-string
		;; And floating point.
		sin cos tan asin acos atan sinh cosh tanh exp log sqrt expt
		ceiling floor round truncate float
		floatp integerp))
