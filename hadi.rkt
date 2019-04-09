#lang racket
 
(provide format-date)
 
(define (format-date d)
    (string-append
        (number->string (date-day d))
        " "
        (month->string (date-month d))
        " "
        (number->string (date-year d))
    )
)

(define (month->string m)
    (case m
     [(1) "Jan"]
     [(2) "Feb"]
     [(3) "Mar"]
     [(4) "Apr"]
     [(5) "May"]
     [(6) "Jun"]
     [(7) "Jul"]
     [(8) "Aug"]
     [(9) "Sept"]
     [(10) "Oct"]
     [(11) "Nov"]
     [(12) "Dec"])
)