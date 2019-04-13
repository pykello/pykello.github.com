#lang racket

(provide highlight-pgtree)

(require xml/xexpr
         xml)

(define (highlight-pgtree xs)
  (for/list ([x xs])
    (match x
      [(list 'pre '((class "brush: pgtree")) (list 'code '() (? string? s)))
         (match (parse_pgtree (tokenize s))
           ["null" '(b () "parse failed")]
           [(cons obj _)
              (string->xexpr 
                (string-append 
                  "<div class='pgtree'>"
                  (render_pgtree obj #t) 
                  "</div>"
                ) 
              )
            ])]
      [(list* (? symbol? tag) (? list? attributes) elements)
         (list* tag attributes (highlight-pgtree elements))]
      [x x])
    )
)

(define (tokenize s)
  (let* ([s1 (string-replace s "(" " ( ")]
         [s2 (string-replace s1 ")" " ) ")]
         [s3 (string-replace s2 "{" " { ")]
         [s4 (string-replace s3 "}" " } ")])
    (string-split s4)))


;; parse_pgtree returns (result, unprocesed)
(define (parse_pgtree tokens)
  (match tokens
    ['() "null"]
    [(cons "{" rest) (match (parse_pgtree_obj rest)
                       ;; if the unprocessed part of the result starts with "}", success
                       [(cons value (cons "}" unprocessed))
                           (cons value unprocessed)]
                       ;; fail otherwise
                       [_
                           "null"])]
    [(cons "(" rest) (match (parse_pgtree_arr rest '())
                       ;; if the unprocessed part of the result starts with ")", success
                       [(cons value (cons ")" unprocessed))
                           (cons value unprocessed)]
                       ;; fail otherwise
                       [_
                           "null"]
                      )]
    [_ (parse_pgtree_atom tokens '())]
  )
)


(define (parse_pgtree_obj tokens)
  (match tokens
    [(cons label rest) (match (parse_pgtree_kvlist rest '())
                          ["null"
                              "null"]
                          [(cons kvlist unprocessed)
                              (cons (list "obj" label kvlist) unprocessed)]
                       )]
    [_ "null"]
  )
)

(define (parse_pgtree_kvlist tokens agg)
  (match tokens
    [(cons "}" _) (cons (reverse agg) tokens)]
    [(cons key rest) (match (parse_pgtree rest)
                        ["null" "null"]
                        [(cons value unprocessed)
                           (let (
                              [agg_updated (cons (cons key value) agg)])
                            (parse_pgtree_kvlist unprocessed agg_updated))
                        ]
                       )]
    [_ "null"]
  )
)

(define (parse_pgtree_arr tokens agg)
  (match tokens
    [(cons ")" _) (cons (list "arr" (reverse agg)) tokens)]
    [_ (match (parse_pgtree tokens)
         ["null"
            "null"]
         [(cons item unprocessed)
            (parse_pgtree_arr unprocessed (cons item agg))]
       )
    ]
  )
)

(define (parse_pgtree_atom tokens agg)
   (if (value-terminated? tokens)
       (cons (list "val" (reverse agg)) tokens)
       (parse_pgtree_atom (cdr tokens) (cons (car tokens) agg)))
)

(define (value-terminated? tokens)
  (or (empty? tokens)
      (value-terminator? (car tokens)))
)

(define (value-terminator? s)
  (member (string-ref s 0) (string->list "}):")))

(define (render_pgtree pgtree isroot)
  (match pgtree
    [(list "obj" label kvlist)
       (render_pgtree_obj label kvlist isroot)]
    [(list "arr" items)
       (render_pgtree_arr items)]
    [(list "val" tokens)
       (render_pgtree_value tokens)]
  )
)

(define (render_pgtree_obj label kvlist isroot)
  (let ([checked (if isroot "checked='true'" "")]
        [id (string-append "chk-" (~v (random 0 1000000000)))])
    (string-append
       "<ul><li><input " checked " type='checkbox' id='" id
       "' />"
       (xexpr->string
          (list 'label (list (list 'for id)) label))
       "<ul class='obj-contents'>"
       (render_pgtree_kvlist kvlist)
       "</ul>"
       "<div class='obj-placeholder'>&nbsp;&nbsp;&nbsp;&nbsp;...</div>"
       "</li><li>&nbsp;&nbsp;}</li></ul>")))

(define (render_pgtree_kvlist kvlist)
  (string-join (map render_pgtree_kv kvlist)))

(define (render_pgtree_kv kv)
  (xexpr->string
    (list 'li '()
       (list 'b '() (car kv) " ")
       (string->xexpr (render_pgtree (cdr kv) #f)))))
 
(define (render_pgtree_arr items)
   (let* ([cnt (length items)]
          [checked (if (< cnt 2) "checked='true'" "")]
          [id (string-append "chk-" (~v (random 0 1000000000)))])
     (string-append
        "<ul><li><input " checked " type='checkbox' id='" id "' />"
        (xexpr->string
          (list 'label (list (list 'for id)) "("))
        "<ul class='obj-contents'>"
        (string-join (map render_pgtree_arr_item items))
        "</ul>"
        (xexpr->string
          (list 'div '((class "obj-placeholder")) "    (" (~v cnt) " items)"))
        "</li><li>&nbsp;&nbsp;)</li></ul>")))

(define (render_pgtree_arr_item item)
  (xexpr->string
    (list 'li '()
      (string->xexpr (render_pgtree item #f)))))

(define (render_pgtree_value tokens)
  (xexpr->string
    (list 'span '() (string-join tokens " "))))
