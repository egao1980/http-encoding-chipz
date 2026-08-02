(defsystem "http-encoding-chipz"
  :version "0.1.0"
  :description "gzip/deflate Content-Encoding backend for http-protocol (chipz + salza2)"
  :author "egao1980"
  :license "MIT"
  :depends-on ("http-protocol" "chipz" "salza2")
  :serial t
  :pathname "src"
  :components ((:file "package")
               (:file "backend"))
  :in-order-to ((test-op (test-op "http-encoding-chipz/tests"))))

(defsystem "http-encoding-chipz/tests"
  :depends-on ("http-encoding-chipz" "http-protocol/conformance" "rove")
  :pathname "tests"
  :serial t
  :components ((:file "package")
               (:file "conformance"))
  :perform (test-op (o c)
             (unless (symbol-call :http-encoding-chipz/tests :run-conformance)
               (error "http-protocol/conformance failed for chipz"))))
