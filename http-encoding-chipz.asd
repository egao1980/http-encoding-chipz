(defsystem "http-encoding-chipz"
  :version "0.1.1"
  :description "gzip/deflate Content-Encoding adapter over compression-protocol"
  :author "egao1980"
  :license "MIT"
  :depends-on ("http-protocol" "compression-protocol" "compression-backend-chipz")

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
