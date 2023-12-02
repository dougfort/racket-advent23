#lang racket

;; 

(require threading)

(provide
 part-1-test-data
 part-2-test-data
 part-1-data
 part-2-data
 )

(define (split-raw raw)
  (~>
   raw
   string-trim
   (string-split "\n")))

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

(define text-digits
  (list
   '("one" "1")
   '("two" "2")
   '("three" "3")
   '("four" "4")
   '("five"  "5")
   '("six" "6")
   '("seven" "7")
   '("eight" "8")
   '("nine" "9")))

(define (replace-prefix-digit in-str)
  (let ([match (for/last ([digit-pair (in-list text-digits)]
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

(define part-2-test-data (split-raw (replace-text-digits raw-part-2-test-data)))

(define data-id "advent01.data")

(define data (port->string (open-input-file data-id) #:close? #t))

(define part-1-data (split-raw data))

(define part-2-data (split-raw (replace-text-digits data)))
