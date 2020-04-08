(defpackage #:ulisp-system
  (:use :cl :asdf))
(in-package #:ulisp-system)

(defsystem "ulisp"
  :description "A trivial implementation of uLisp in Common Lisp."
  :author "Herbert Snorrason"
  :license "CC0"
  :components ((:file "packages")
               (:file "impl")))
