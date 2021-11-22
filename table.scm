(define-record table names widths)

(define (column-text text width)
  (string-append
   " "
   (parse-markup text)
   (make-string (- width (string-length (remove-markup text)) 1) #\ )))

(define (table-header tab)
  (string-append
   "┌" (string-join (map (lambda (w) (make-string (+ 2 w) #\─))  (table-widths tab)) "┬") "┐\n"
   "│" (string-join (map (lambda (name width) (column-text name (+ 2 width))) (table-names tab) (table-widths tab)) "│") "│\n"
   "├" (string-join (map (lambda (w) (make-string (+ 2 w) #\─)) (table-widths tab)) "┼") "┤\n"))

(define (table-row tab . args)
  (string-append
   "│"
   (string-join (map (lambda (text width) (column-text text (+ 2 width))) args (table-widths tab)) "│")
   "│\n"))

(define (table-footer tab)
  (string-append "└" (string-join (map (lambda (w) (make-string (+ 2 w) #\─)) (table-widths tab)) "┴") "┘\n"))
