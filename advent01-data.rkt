#lang racket

;; 

(require threading)

(provide
 part-1-test-data
 part-2-test-data
 part-1-data
 part-2-data
 )

(require "data-tools.rkt")

(define raw-part-1-test-data
  "1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet
")

(define part-1-test-data (split-raw raw-part-1-test-data))

(define raw-part-2-test-data
  "two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen
")

;; ordered by length
(define text-digits
  (list
   '("oneight" "18")
   '("twone" "21")
   '("threeight" "38")
   '("fiveight" "58")
   '("sevenine" "79")
   '("eightwo" "82")
   '("nineight" "98")
   '("three" "3")
   '("seven" "7")
   '("eight" "8")
   '("four" "4")
   '("five"  "5")
   '("nine" "9")
   '("one" "1")
   '("two" "2")
   '("six" "6")))

(define (replace-prefix-digit in-str)
  (let ([match (for/first ([digit-pair (in-list text-digits)]
                          #:when (string-prefix? in-str (first digit-pair)))
                 digit-pair)])
    (cond
      [(false? match)  (values (substring in-str 1) (substring in-str 0 1))]
      [else
       (let ([len (string-length (first match))])
         (values (substring in-str len) (second match) ))]))) 

(define (replace-text-digits str)
  (let loop ([in-str str]
             [out-str ""])
    (cond
      [(equal? in-str "") out-str]
      [else
       (let-values ([(next-in next-out) (replace-prefix-digit in-str)])
         (loop next-in (string-append out-str next-out)))])))      

(define part-2-test-data (map replace-text-digits (split-raw raw-part-2-test-data)))

(define data-id "advent01.data")

(define data (data-from-file data-id))

(define part-1-data (split-raw data))

(define part-2-data (map replace-text-digits (split-raw data)))
