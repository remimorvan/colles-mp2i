#import "./template.typ": *

#frontpage(
  title: [Exercices de colles\ d'informatique en MP2I],
  subtitle: [donnés lors de l'année scolaire 2025--2026\ dans la classe de Géraldine Olivier au Lycée Montaigne],
  author: "Rémi Morvan",
  email: "www.morvan.xyz"
)

#set par(justify: true)
#show heading: set block(above: 2em, below: 1em)
#set enum(numbering: "1.a.")
#set heading(numbering: "I.")

#heading(numbering: none)[Organisation]

Ce polycopié d'exercices est intégralement placé sous #link("https://creativecommons.org/licenses/by/4.0/deed.fr")[licence CC BY 4.0].
Les exercices sont classés par difficulté (exercices « de cours », d'application et d'approfondissement) ainsi que par thème.
Par ailleurs, ces exercices ont été donnés entre le mois de décembre et le mois de février :
ce polycopié *ne couvre donc pas l'ensemble du programme de MP2I*.

Quand une source est mentionnée, tout ou partie de l'exercice s'inspire directement
de cette source, la formulation même de l'exercice m'étant cependant propre.
Quand aucune source n'est mentionnée, cela signifie que j'ai écrit cet exercice
sans source *directe* : je ne saurais cependant prétendre à aucune forme d'originalité.
J'ai cependant essayé, d'autant que faire se peut, de créer des exercices _motivés et motivants_. 
Par exemple, j'ai essayé de ne jamais demander d'implémenter une structure sans que la suite de
l'exercice n'en propose une véritable application. En conséquence, certains exercices
sont particulièrement longs.

#heading(numbering: none)[Sommaire par language]

#heading(numbering: none)[Sommaire par thème]

#{
  let exercices = ("binary-trees", "locality", "memory-return", "min-max-array", "mirror-string", "records", "uno", "vowels")
  for exo in exercices {
    include "./exercices/" + exo + "/" + exo + ".typ"
    
  }
}
