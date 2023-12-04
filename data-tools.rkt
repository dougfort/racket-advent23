#lang racket

;; 

(require threading)

(provide split-raw data-from-file)

(define (split-raw raw)
  (~>
   raw
   string-trim
   (string-split "\n")))

(define (data-from-file data-id)
  (port->string (open-input-file data-id) #:close? #t))
