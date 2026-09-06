(in-package #:http-encoding-chipz)

;;; Thin http-protocol adapters. Bytes live in compression-protocol.
;;; HTTP :deflate encode = zlib; decode = zlib then raw deflate.

(defmethod decode-content-coding ((coding (eql :gzip)) (input stream) &key)
  (compression-protocol:make-decompressing-stream input :algorithm :gzip))

(defmethod decode-content-coding ((coding (eql :gzip)) input &key)
  (compression-protocol:decompress input :algorithm :gzip))

(defmethod encode-content-coding ((coding (eql :gzip)) (input stream) &key level quality)
  (declare (ignore quality))
  (make-octet-input-stream
   (compression-protocol:compress input :algorithm :gzip :level level)))

(defmethod encode-content-coding ((coding (eql :gzip)) input &key level quality)
  (declare (ignore quality))
  (compression-protocol:compress input :algorithm :gzip :level level))

(defmethod decode-content-coding ((coding (eql :deflate)) (input stream) &key)
  (compression-protocol:make-decompressing-stream input :algorithm :zlib))

(defmethod decode-content-coding ((coding (eql :deflate)) input &key)
  (let ((octets (coerce-to-octets input)))
    (handler-case
        (compression-protocol:decompress octets :algorithm :zlib)
      (error ()
        (compression-protocol:decompress octets :algorithm :deflate)))))

(defmethod encode-content-coding ((coding (eql :deflate)) (input stream) &key level quality)
  (declare (ignore quality))
  (make-octet-input-stream
   (compression-protocol:compress input :algorithm :zlib :level level)))

(defmethod encode-content-coding ((coding (eql :deflate)) input &key level quality)
  (declare (ignore quality))
  (compression-protocol:compress input :algorithm :zlib :level level))
