#set page(
  paper: "a4"
)
#set text(
  font: "Cochin",
  size: 11pt,
  lang: "fr"
)

#let coloured_tag(content, colour) = {
	box(inset: (left: .48em, bottom: -.18em), 
		box(
			fill: colour,
			inset: (x: .48em, y: .24em),
			clip: true,
			radius: .5em,
			text(font: "Fira Code", size: .8em, fill: black, weight: "regular", content)
		)
	)
}

#let tag(content, data : (:)) = {
	if not "tags" in data or not "colours" in data {
		coloured_tag("incomplete data", rgb("ff0000"))
		return;
	}
	let tags = data.at("tags")
	let colours = data.at("colours")
	let pos = tags.position(x => x == content)
	let colour
	if pos == none {
		coloured_tag("undefined tag", rgb("ff0000"))
		return;
	} else {
		pos = calc.rem(pos, colours.len())
		colour = rgb(colours.at(pos))
	}
	coloured_tag(content, colour)
}

#let exercise(title: [], difficulty: 0, language: "", tags: (), source: "", data: (:)) = {
	heading(title, depth: 1)
	v(-.5em)
	h(-.5em)
	text(size: .9em, {
		if "difficulty" in data and difficulty > 0 and difficulty - 1 < data.at("difficulty").len() {
			coloured_tag(
				data.at("difficulty").at(difficulty - 1),
				rgb("#f0eded")
			)
		} else {
			coloured_tag("unknown difficulty", rgb("#ff0000"))
		}
		if "languages" in data and data.at("languages").find(x => lower(x.at(0)) == language) != none {
			coloured_tag(data.at("languages").find(x => lower(x.at(0)) == language).at(0), rgb("#f0eded"))
		} else {
			coloured_tag("unknown language '" + language + "'", rgb("#ff0000"))
		}
		for tag_label in tags {
			tag(tag_label, data: data)
		}
		if source != "" {
			v(.5em)
			emph([Source : ] + source)
		}
		v(.5em)
	})
}

#let frontpage(title: [], subtitle: [], author: "", email: "") = {
	set document(
		title: title,
		author: author
	)
	v(.5fr)
	text(size: 22pt, fill: rgb("#222222"), weight: "bold", title)
	v(0em)
	text(size: 15pt, fill: rgb("#222222"), style: "italic", subtitle)
	v(4em)
	align(right, {
		text(size: 20pt, fill: rgb("#388fce"), weight: "bold", smallcaps(author))
		linebreak()
		text(size: 13pt, fill: rgb("#222222"), raw(email))
	})
	v(1fr)
	align(center, image("./img/colles.png", width: 70%))
	v(.5fr)
	colbreak()
}