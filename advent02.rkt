#lang racket

;; 

(require threading)

(module+ test
  (require rackunit))

(require "advent02-data.rkt")

(define (possible-games bag games)
  (for/list ([game (in-list games)]
             #:when (game-is-possible? bag (game-result-cubesets game)))
    (game-result-id game)))

(define (game-is-possible? bag cubesets)
  (for/and ([cs (in-list cubesets)])
    (cond
      [(< (cubeset-red bag) (cubeset-red cs)) #f]
      [(< (cubeset-green bag) (cubeset-green cs)) #f]
      [(< (cubeset-blue bag) (cubeset-blue cs)) #f]
      [else #t])))
      
(module+ test
  (test-begin
   (define bag (cubeset 12 13 14))
   (check-equal? 8 (apply + (possible-games bag test-data))))) 

(define bag (cubeset 12 13 14))
(apply + (possible-games bag data)) 

