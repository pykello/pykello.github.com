#lang scribble/manual
@require[@for-label[scribble-math
                    racket/base
                    scribble/core]
         @for-syntax[racket/base
                     syntax/parse]
         "../common.rkt"]

@title{PFPL Languages}

@bold{Language E}

@bold{4.1. Syntax}

@autoalign{
                   | abstract-syntax          | concrete-syntax  | meaning
Typ @${\tau}  ::=  | num                      | num              | numbers
                   | str                      | str              | strings
Expr @${e}  ::=    | @${x}                    | @${x}            | variable
                   | num[@${n}]               | @${n}            | numeral
                   | str[@${s}]               | "@${s}"          | literal
                   | plus(@${e_1} ; @${e_2})  | @${e_1} + @${e_2} | addition
}

@bold{4.2. Type System}

@autoalign{
@${\dfrac{.}{\Gamma,x : \tau \vdash x : \tau}}           | (4.1a)

@${\dfrac{.}{\Gamma \vdash str[s] : str}}                | (4.1b)

@${\dfrac{.}{\Gamma \vdash num[n] : num}}                | (4.1c)

@${\dfrac{\Gamma \vdash e_1 : num \quad \Gamma \vdash e_2 : num}{\Gamma \vdash plus(e_1 ; e_2) : num}} | (4.1d)

@${\dfrac{\Gamma \vdash e_1 : num \quad \Gamma \vdash e_2 : num}{\Gamma \vdash times(e_1 ; e_2) : num}} | (4.1e)

@${\dfrac{\Gamma \vdash e_1 : str \quad \Gamma \vdash e_2 : str}{\Gamma \vdash cat(e_1 ; e_2) : str}} | (4.1f)

@${\dfrac{\Gamma \vdash e : str}{\Gamma \vdash len(e) : num}} | (4.1g)

@${\dfrac{\Gamma \vdash e_1 : \tau_1 \quad \Gamma, x : \tau_1 \vdash e_2 : \tau_2}{\Gamma \vdash let(e_1; x.e_2) : \tau_2}} | (4.1h)

}

