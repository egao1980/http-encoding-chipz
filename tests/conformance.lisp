(in-package #:http-encoding-chipz/tests)

(defun run-conformance ()
  (http-protocol/conformance:run-for-codings http-encoding-chipz:+codings+))
