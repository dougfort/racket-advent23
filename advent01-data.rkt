#lang racket

;; 

(require threading)

(provide test-data data)

(define (split-raw raw)
  (~>
   raw
   string-trim
   (string-split "\n")))

(define (numeric-chars line)
  (for/list ([chr (in-list (string->list line))]
             #:when (char-numeric? chr))
    chr))

(define (calibration-value-chars chrs)
  (list (first chrs) (last chrs)))

(define (parse-line line)
  (~>
   line
   numeric-chars
   calibration-value-chars
   list->string
   string->number))
   
(define (parse raw)  
  (map parse-line (split-raw raw)))

(define raw-test-data
  "1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet
")

(define test-data (λ () (parse raw-test-data)))

(define data-id "advent01.data")

(define data (λ ()
               (let ([raw-data (port->string (open-input-file data-id) #:close? #t)])               
                 (parse raw-data))))
