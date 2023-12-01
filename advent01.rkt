#lang racket

;; 

(module+ test
  (require rackunit))

(require "advent01-data.rkt")

(module+ test
  (test-begin
   (define sum-of-calibration-values (apply + (test-data)))
   (check-equal? sum-of-calibration-values 142)))
   
(define sum-of-calibration-values (apply + (data)))