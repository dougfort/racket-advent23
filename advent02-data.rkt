#lang racket

;; 

(require threading)

(provide
 cubeset
 cubeset-red
 cubeset-green
 cubeset-blue
 game-result
 game-result-id
 game-result-cubesets
 test-data
 data)

(require "data-tools.rkt")

(module+ test
  (require rackunit))

(struct cubeset (red green blue)
  #:transparent)

(struct game-result (id cubesets)
  #:transparent)

(define (parse raw-str)
  (map parse-game (split-raw raw-str)))

(define (parse-game line)
  (let ([split-line (string-split line ":")])
    (game-result (parse-game-id (first split-line)) (parse-cubesets (second split-line)))))

(define (parse-game-id game-str)
  (string->number (string-trim game-str "Game ")))

(define (parse-cubesets cubesets-str)
  (map parse-cubeset (string-split cubesets-str ";")))

(define (parse-cubeset cubeset-str)
  (let ([counts (make-hash)])
    (for ([count-pair-str (string-split cubeset-str ",")])
      (let ([count-pair (string-split (string-trim count-pair-str))])
        (hash-set! counts (second count-pair) (string->number (first count-pair)))))
    (cubeset (hash-ref counts "red" 0) (hash-ref counts "green" 0) (hash-ref counts "blue" 0))))

(define raw-test-data 
  "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
")

(define data-id "advent02.data")

(define raw-data (data-from-file data-id))

(define test-data (parse raw-test-data))
(define data (parse raw-data))