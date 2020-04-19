#lang racket

(require (only-in pict scale)
         racket/math
         slideshow/latex
         scribble/core)

(provide (all-defined-out))

(latex-debug? #f)

;; Added to every tex file, before the document proper:
(add-preamble #<<latex
\usepackage{amsmath, amssymb}
\newcommand{\targetlang}{\lambda_{\mathrm{ZFC}}}
\newcommand{\meaningof}[1]{[\![{#1}]\!]}  % use in semantic functions
\newcommand{\A}{\mathcal{A}}
\renewcommand{\P}{\mathbb{P}}
\newcommand{\N}{\mathbb{N}}
\newcommand{\Z}{\mathbb{Z}}
\newcommand{\Q}{\mathbb{Q}}
\newcommand{\R}{\mathbb{R}}
latex
              )
(define ($ x)
           (scale ($$ x) 0.5))

(define omitable-style (make-style 'omitable null))

(define (x-append lst . xs)
  (for/fold ([agg lst])
            ([x xs])
    (if (null? x) agg (append agg (list x)))))

(define (tokenize-chars lst)
  (for/fold ([tokens `()]
             [token `()]
             #:result (x-append tokens token))
            ([c lst])
    (if (equal? c #\|)
        (values (x-append tokens token `(#\|)) `())
        (values tokens (x-append token c)))))

(define (tokenize-string s)
  (map list->string (tokenize-chars (string->list s))))

(define (autoalign . x)
  (define f (λ (x) (if (string? x) (tokenize-string x) x)))
  (define tokens (flatten (map f x)))
  (define table (split-list tokens))
 (make-table (make-style "STable" null) table))

(define (maybe-paragraph x)
  (if (null? x)
      `()
      (make-paragraph omitable-style x)))

(define (split-list lst)
  (for/fold ([table `()]
             [row `()]
             [cell `()]
             #:result (x-append table (x-append row (maybe-paragraph cell))))
            ([token lst])
    (cond
      [(equal? token "\n") (values (x-append table (x-append row (maybe-paragraph cell))) `() `())]
      [(equal? token "|") (values table (x-append row (maybe-paragraph cell)) `())]
      [else (values table row (x-append cell token))])))

(define (h2 x)
  (make-element "h2" x))
