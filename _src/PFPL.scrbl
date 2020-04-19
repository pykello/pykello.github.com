#lang scribble/base
@(require scribble/core
          scribble/manual)

@require[@for-label[scribble-math
                    racket/base]
         @for-syntax[racket/base
                     syntax/parse]
         "../common.rkt"]

@title{Practical Foundations of Programming Languages}

@h2{Language E}

@bold{4.1. Syntax}

@autoalign{
                   | abstract-syntax          | concrete-syntax  | meaning
Typ @${\tau}  ::=  | num                      | num              | numbers
                   | str                      | str              | strings
Exp @${e}  ::=    | @${x}                    | @${x}            | variable
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

@bold{5.2. Structural Dynamics}

The judgment @${e \, \mathrm{val}}, which states @${e} is a value, is inductively defined as:

@autoalign{
@${\dfrac{.}{num[n] \, \mathrm{val}}}                                    | (5.3a)
@${\dfrac{.}{str[s] \, \mathrm{val}}}                                    | (5.3b)
}

The transition judgment @${e \longmapsto e'} between states is inductively defined
by the following rules:

@autoalign{
@${\dfrac{n_1 + n_2 = n}{plus(num[n_1]; num[n_2]) \longmapsto num[n]}}             | (5.4a)

@${\dfrac{e \longmapsto e'_1}{plus(e_1; e_2) \longmapsto plus(e'_1; e_2)}}         | (5.4b)

@${\dfrac{e_1 \, \mathrm{val} \quad e_2 \longmapsto e'_2}{plus(e_1; e_2) \longmapsto plus(e_1; e'_2)}} | (5.4c)

@${\dfrac{s_1 \, \char`^ \, s_3 = s \, \mathrm{str}}{cat(str[s_1]; str[s_2) \longmapsto str[s]])}}         | (5.4d)

@${\dfrac{e \longmapsto e'_1}{cat(e_1; e_2) \longmapsto cat(e'_1; e_2)}}         | (5.4e)

@${\dfrac{e_1 \, \mathrm{val} \quad e_2 \longmapsto e'_2}{cat(e_1; e_2) \longmapsto cat(e_1; e'_2)}} | (5.4f)

@${\left[\dfrac{e_1 \longmapsto e'_1}{let(e_1; x.e_2) \longmapsto let(e'_1;x.e_2)}\right]}   | (5.4g)

@${\dfrac{[e_1 \, \mathrm{val}]}{let(e_1; x.e_2) \longmapsto [e_1/x]e_2}}         | (5.4h)
}

Rules (5.4a), (5.4d), and (5.4h) are @italic{instruction transitions}, because they
correspond to the primitive steps of evaluation. The remaining rules are
@italic{search transitions} that determine the order of execution of instructions.

The bracketed rule (5.4g) and bracketed premise on rule (5.4h) are included for a
@italic{by-value} interpretation of let and omitted for a @italic{by-name}
interpretation.

@h2{Type Safety}

@bold{Theorem 6.1} (Type Safety). 

@itemlist[#:style 'ordered
 @item{
     (Preservation)
     If @${e : \tau} and @${e \longmapsto e'}, then @${e' : \tau}.
 }
 @item{
     (Progress)
     If @${e : \tau}, then either @${e \, \mathrm{val}} or there exists @${e'} such that @${e \longmapsto e'}.
 }]

@bold{Error Judgment for Language E}

@autoalign{

@${\dfrac{e_1 \, \mathrm{val}}{div(e_1; num[0]) \, \mathrm{err}}}     | (6.1a)

@${\dfrac{e_1 \, \mathrm{err}}{div(e_1; e_2) \, \mathrm{err}}}     | (6.1a)

@${\dfrac{e_1 \, \mathrm{val} \quad e_2 \, \mathrm{err}}{div(e_1; e_2) \, \mathrm{err}}}     | (6.1a)

}

Expression "error" which forcibly induces an error, with the following static and dynamic semantics:

@autoalign{

@${\dfrac{.}{\Gamma \vdash \mathrm{error} : \tau}}      | (6.2a)

@${\dfrac{.}{\mathrm{error} \, \mathrm{err}}}           | (6.2b)

}

@bold{Theorem 6.5} (Progress With Error). If @${e : \tau}, then either @${e \, \mathrm{err}},
or @${e \, \mathrm{val}}, or there exists @${e'} such that @${e \longmapsto e'}.

@h2{Language ED}

Adds first-order functions to Language E:

@autoalign{
                   | abstract-syntax                 | concrete-syntax  | meaning
Exp @${e}         ::=  | @${\mathrm{apply} \, {f}(e)}                     | @${f(e)}             | application
                   | @${\mathrm{fun}\{\tau_1;\tau_2\}(x_1.e_2;f.e)} | @${\mathrm{fun} \, f(x_1 : \tau_1): \tau_2 = e_2 \, \mathrm{in} \, e}  | definition
}