(in-package #:http-encoding-chipz)

;;; Specialize http-protocol generics for :gzip / :deflate.

;; salza2 mis-encodes zero-length input (huge garbage); use canonical empties.
(defparameter *empty-gzip*
  (coerce #(#x1f #x8b #x08 #x00 #x00 #x00 #x00 #x00 #x00 #xff
            #x03 #x00 #x00 #x00 #x00 #x00 #x00 #x00 #x00 #x00)
          '(simple-array (unsigned-byte 8) (*))))

(defparameter *empty-zlib*
  ;; CMF/FLG + empty deflate block + adler32(0)=1
  (coerce #(#x78 #x9c #x03 #x00 #x00 #x00 #x00 #x01)
          '(simple-array (unsigned-byte 8) (*))))

(defun %gzip-compress (octets)
  (if (zerop (length octets))
      *empty-gzip*
      (salza2:compress-data octets 'salza2:gzip-compressor)))

(defun %zlib-compress (octets)
  (if (zerop (length octets))
      *empty-zlib*
      (salza2:compress-data octets 'salza2:zlib-compressor)))

(defmethod decode-content-coding ((coding (eql :gzip)) (input stream) &key)
  (chipz:make-decompressing-stream 'chipz:gzip input))

(defmethod decode-content-coding ((coding (eql :gzip)) input &key)
  (chipz:decompress nil 'chipz:gzip (coerce-to-octets input)))

(defmethod encode-content-coding ((coding (eql :gzip)) (input stream) &key level quality)
  (declare (ignore level quality))
  ;; salza2 has no pull compressing Gray stream — slurp then wrap.
  (make-octet-input-stream (%gzip-compress (slurp-octets input))))

(defmethod encode-content-coding ((coding (eql :gzip)) input &key level quality)
  (declare (ignore level quality))
  (%gzip-compress (coerce-to-octets input)))

;;; HTTP "deflate" is zlib-wrapped in practice (browsers / httpx).
(defmethod decode-content-coding ((coding (eql :deflate)) (input stream) &key)
  (chipz:make-decompressing-stream 'chipz:zlib input))

(defmethod decode-content-coding ((coding (eql :deflate)) input &key)
  (let ((octets (coerce-to-octets input)))
    (handler-case
        (chipz:decompress nil 'chipz:zlib octets)
      (error ()
        (chipz:decompress nil 'chipz:deflate octets)))))

(defmethod encode-content-coding ((coding (eql :deflate)) (input stream) &key level quality)
  (declare (ignore level quality))
  (make-octet-input-stream (%zlib-compress (slurp-octets input))))

(defmethod encode-content-coding ((coding (eql :deflate)) input &key level quality)
  (declare (ignore level quality))
  (%zlib-compress (coerce-to-octets input)))
