(module fancy
(cursor-up
 cursor-down
 cursor-forward
 cursor-back
 cursor-next
 cursor-previous
 cursor-hor
 cursor-pos
 erase-in-display
 erase-in-line
 scroll-up
 scroll-down
 save-pos
 restore-pos
 graphics-rendition-code
 graphics-style
 parse-tag
 parse-markup
 remove-markup
 rule)

(import scheme
	(chicken base)
	(chicken format)
	(chicken irregex)
	srfi-1
	utf8
	srfi-152)

(include "colors.scm")
(include "format.scm")
(include "rule.scm")

)
