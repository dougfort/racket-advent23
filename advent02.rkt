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

;; compare two cubesets
;; return a cubeset that contains the maximum if each cube type
(define (max-cubes lhs rhs)
  (cubeset (max (cubeset-red lhs) (cubeset-red rhs))
           (max (cubeset-green lhs) (cubeset-green rhs))
           (max (cubeset-blue lhs) (cubeset-blue rhs))))

(define (min-cubes-for-game game)
  (let ([max-c (for/fold ([accum (cubeset 0 0 0)])
                         ([c (game-result-cubesets game)])
                 (max-cubes c accum))])
    max-c))

(define (power-of-cubeset cs)
  (* (cubeset-red cs) (cubeset-green cs) (cubeset-blue cs)))
      
(module+ test
  (test-begin
   (define bag (cubeset 12 13 14))
   (check-equal? 8 (apply + (possible-games bag test-data)))
   (check-equal? 2286 (apply + (map power-of-cubeset (map min-cubes-for-game test-data))))))


(define bag (cubeset 12 13 14))
(apply + (possible-games bag data)) 
(apply + (map power-of-cubeset (map min-cubes-for-game data)))
