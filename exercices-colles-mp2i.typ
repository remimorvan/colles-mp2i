#import "./template.typ": *
#import "@preview/in-dexter:0.7.2": *

#set page(
  paper: "a4"
)
#set text(
  font: "Cochin",
  size: 11pt,
  lang: "fr"
)

#frontpage(
  title: [Exercices de colles\ d'informatique en MP2I],
  subtitle: [donnés lors de l'année scolaire 2025--2026\ dans la classe de Géraldine Olivier au Lycée Montaigne],
  author: "Rémi Morvan",
  email: "www.morvan.xyz",
  image_url: "./img/colles.png"
)

#set par(justify: true)
#show heading: set block(above: 2em, below: 1em)
#set enum(numbering: "1.a.")
#set heading(numbering: "I.")

#heading(numbering: none)[Organisation]

Ce polycopié d'exercices est intégralement placé sous #link("https://creativecommons.org/licenses/by/4.0/deed.fr")[licence CC BY 4.0].
Les exercices sont classés par difficulté (exercices « de cours », d'application et d'approfondissement) ainsi que par thème. Les pages suivantes contiennent d'une part
un *sommaire par langage (sous-catégorifié selon la difficulté),
ainsi qu'un sommaire par thème abordé*.
Par ailleurs, ces exercices ont été donnés entre le mois de décembre et le mois de février :
ce polycopié *ne couvre donc pas l'ensemble du programme de MP2I*.

Quand une source est mentionnée, tout ou partie de l'exercice s'inspire directement
de cette source, la formulation même de l'exercice m'étant cependant propre.
Quand aucune source n'est mentionnée, cela signifie que j'ai écrit cet exercice
sans source _directe_ : je ne saurais cependant prétendre à aucune forme d'originalité.
J'ai cependant essayé, d'autant que faire se peut, de créer des exercices _motivés et motivants_. 
Par exemple, j'ai essayé de ne jamais demander d'implémenter une structure sans que la suite de
l'exercice n'en propose une véritable application. En conséquence, certains exercices
sont particulièrement longs.

Ce document a été mis en page à l'aide de #link("https://typst.app/")[Typst].

#colbreak()
#let is_before(x, y) = {
  return (
    (x.location().position().at("page") < y.location().position().at("page"))
    or ((x.location().position().at("page") == y.location().position().at("page"))
    and (x.location().position().at("y") <= y.location().position().at("y")))
  )
}
#heading(level: 1, numbering: none)[Sommaires par langage]
#context {
  for mylang in ("OCaml", "C", "Théorique") {
    heading(level: 2, numbering: none)[Sommaire des exercices #mylang]
    let exos = query(
      heading.where(numbering: "I.")
    )
    let langs = query(selector(<language>))
    assert(exos.len() == langs.len())
    for i in range(exos.len()) {
      if langs.at(i).value == mylang {
        let loc = exos.at(i).location()
        link(loc, box(
          numbering("I.", i+1) + " " + exos.at(i).body
          + " " + box(width: 1fr, repeat[~.~]) + " "
          + [#loc.page()]
        ))
        linebreak()
      }
    }
  }
}
#colbreak()
#heading(level: 1, numbering: none)[Sommaires par thème abordé]
#colbreak()

#{
  let exercices = ("binary-trees", "locality", "memory-return", "min-max-array", "mirror-string", "records", "uno", "vowels")
  for exo in exercices {
    include "./exercices/" + exo + "/" + exo + ".typ"
    
  }
}
