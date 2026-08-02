(defpackage #:http-encoding-chipz
  (:use #:cl #:http-protocol)
  (:export #:+codings+))
(in-package #:http-encoding-chipz)

(defparameter +codings+ '(:gzip :deflate)
  "Codings this backend implements.")
