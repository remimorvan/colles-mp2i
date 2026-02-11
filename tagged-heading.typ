#let tagged_heading(tags: none, ..args) = {
	heading(..args)
	[#metadata(tags) <tags>]
}

#let headings_with_tag(filter_tag, filter_heading) = {
	query(<tags>).filter(x => filter_tag(x.value)).map(tag =>
	("hd": {
		query(
			selector(heading).before(tag.location())
		).last()
	}, "tags": tag.value)).filter(x => filter_heading(x.hd))
}
#let tagged_outline(
	target_tag: (x => true),
	target_heading: (x => true),
	addendum: (dict => "")
) = context{
	for dct in headings_with_tag(target_tag, target_heading) {
		let hd = dct.hd
		let tags = dct.tags
		let loc = hd.location()
		let num = if hd.numbering != none {
			numbering(hd.numbering, ..counter(heading).at(loc))
		}
		link(loc, box(
			num + " " + hd.body + addendum(dct) 
			+ " " + box(width: 1fr, repeat[~.~]) + " "
			+ [#loc.page()]
		))
		linebreak()
	}
}

// #set heading(numbering: "I.1.")
// #context{tagged_outline(target_tag: t => "language" in t and t.at("language") == "c", target_heading: x => (x.level <= 2))}

// #tagged_heading(level: 1, tags: ("language": "ocaml"))[My first heading]
// #tagged_heading(level: 1, tags: ("language": "c"))[My second heading]
// #tagged_heading(level: 2, tags: ("language": "ocaml"))[My first subheading]