#import "tagged-heading.typ": *

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
	if not "themes" in data or not "colours" in data {
		coloured_tag("incomplete data", rgb("ff0000"))
		return;
	}
	let themes = data.at("themes")
	let colours = data.at("colours")
	let pos = themes.position(x => x == content)
	let colour
	if pos == none {
		coloured_tag("undefined theme", rgb("ff0000"))
		return;
	} else {
		pos = calc.rem(pos, colours.len())
		colour = rgb(colours.at(pos))
	}
	coloured_tag(content, colour)
}

#let exercise(title: [], difficulty: 0, language: "", themes: (), source: "", data: (:)) = {
	// Get difficulty
	let difficulty_text
	let difficulty_colour
	if ("difficulty" in data and difficulty > 0
	and difficulty - 1 < data.at("difficulty").len()) {
		difficulty_text = data.at("difficulty").at(difficulty - 1).at(0)
		difficulty_colour =	rgb("#f0eded")
	} else {
		difficulty_text = "unknown difficulty"
		difficulty_colour = rgb("#ff0000")
	}
	// Get language
	let language_text
	let language_colour 
	if ("languages" in data and
	data.at("languages").find(x => lower(x.at(0)) == language) != none) {
		language_text = data.at("languages").find(x => lower(x.at(0)) == language).at(0)
		language_colour = rgb("#f0eded")
	} else {
		language_text = "unknown language '" + language + "'"
		language_colour = rgb("#ff0000")
	}
	tagged_heading(title, depth: 1, tags: (
		"language": language_text,
		"difficulty": difficulty_text,
		"themes": themes
	))
	v(-.5em)
	h(-.5em)
	text(size: .9em, {
		coloured_tag(difficulty_text, difficulty_colour)
		coloured_tag(language_text, language_colour)
		for theme in themes {
			tag(theme, data: data)
		}
		if source != "" {
			v(.5em)
			emph([Source : ] + source)
		}
		v(.5em)
	})
}

#let frontpage(title: [], subtitle: [], author: "", email: "", image_url: "") = {
	set document(
		title: title,
		author: author
	)
	v(.75fr)
	text(size: 22pt, fill: rgb("#222222"), weight: "bold", title)
	v(0em)
	text(size: 15pt, fill: rgb("#222222"), style: "italic", subtitle)
	v(4em)
	align(right, {
		text(size: 20pt, fill: rgb("#388fce"), weight: "bold", author)
		linebreak()
		text(size: 13pt, fill: rgb("#222222"), raw(email))
	})
	v(1fr)
	align(center, image(image_url, width: 70%))
	v(.5fr)
	colbreak()
}