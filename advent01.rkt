#lang racket

;; 

(require threading)

(module+ test
  (require rackunit))

(require "advent01-data.rkt")

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

(module+ test
  (test-begin
   (define part-1-values (apply + (map parse-line part-1-test-data)))
   (check-equal? part-1-values 142))
  (define part-2-values (apply + (map parse-line part-2-test-data)))
  (check-equal? part-2-values 281))
   
(define part-1-sum-of-calibration-values (apply + (map parse-line part-1-data)))
(define part-2-sum-of-calibration-values (apply + (map parse-line part-2-data)))