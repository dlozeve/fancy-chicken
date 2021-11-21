(define (rule text #!key (width 80) (style 'simple))
  (define rule-len (- width (+ 2 (string-length (remove-markup text)))))
  (define left-len (sub1 (quotient rule-len 2)))
  (define right-len (sub1 (+ (remainder rule-len 2) (quotient rule-len 2))))
  (define c (cond
	     ((eq? style 'simple) #\━)
	     ((eq? style 'double) #\═)
	     ((eq? style 'dashed) #\╌)))
  (string-join
   (list (make-string left-len c)
	 " "
	 (parse-markup text)
	 " "
	 (make-string right-len c)
	 "\n")))

