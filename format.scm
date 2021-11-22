;; ========================= Constants =========================

(define +CSI+ "\033[")

(define +basic-colors+
  '((black . 0)
    (red . 1)
    (green . 2)
    (yellow . 3)
    (blue . 4)
    (magenta . 5)
    (cyan . 6)
    (white . 7)))

(define +basic-bg-colors+
  '((on-black . 0)
    (on-red . 1)
    (on-green . 2)
    (on-yellow . 3)
    (on-blue . 4)
    (on-magenta . 5)
    (on-cyan . 6)
    (on-white . 7)))

(define +re-tags+ (irregex "\\[(/?[a-z ]*?)\\]"))


;; ========================= Control sequences =========================

(define (cursor-up #!optional (n 1)) (format "~a~aA" +CSI+ n))
(define (cursor-down #!optional (n 1)) (format "~a~aB" +CSI+ n))
(define (cursor-forward #!optional (n 1)) (format "~a~aC" +CSI+ n))
(define (cursor-back #!optional (n 1)) (format "~a~aD" +CSI+ n))
(define (cursor-next #!optional (n 1)) (format "~a~aE" +CSI+ n))
(define (cursor-previous #!optional (n 1)) (format "~a~aF" +CSI+ n))
(define (cursor-hor #!optional (n 1)) (format "~a~aG" +CSI+ n))
(define (cursor-pos #!optional (n 1) (m 1)) (format "~a~a;~aH" +CSI+ n m))
(define (erase-in-display #!optional (n 0)) (format "~a~aJ" +CSI+ n))
(define (erase-in-line #!optional (n 0)) (format "~a~aK" +CSI+ n))
(define (scroll-up #!optional (n 1)) (format "~a~aS" +CSI+ n))
(define (scroll-down #!optional (n 1)) (format "~a~aT" +CSI+ n))
(define (save-pos) (format "~as" +CSI+))
(define (restore-pos) (format "~au" +CSI+))


;; ========================= Graphics rendition parameters =========================

(define (graphics-rendition-code tag)
  (define basic-color (assoc tag +basic-colors+))
  (define basic-bg-color (assoc tag +basic-bg-colors+))
  (cond
   ((eq? tag 'bold) "2")
   ((eq? tag 'italic) "3")
   ((eq? tag 'underline) "4")
   (basic-color (format "3~a" (cdr basic-color)))
   (basic-bg-color (format "4~a" (cdr basic-bg-color)))))

(define (graphics-style #!optional (style '()))
  (define colors (lset-intersection eq? style (map car +basic-colors+)))
  (define bg-colors (lset-intersection eq? style (map car +basic-bg-colors+)))
  (define style-without-colors (lset-difference eq? style
						(map car +basic-colors+)
						(map car +basic-bg-colors+)))
  (define final-style (cons* (unless (null? colors) (car colors))
			     (unless (null? bg-colors) (car bg-colors))
			     style-without-colors))
  (format "~a~am" +CSI+
	  (string-join (filter string? (map graphics-rendition-code final-style)) ";")))


;; ========================= Console markup =========================

(define (parse-tag contents #!optional (style '()))
  (define closing (eq? #\/ (string-ref contents 0)))
  (define clean-contents (if closing (string-drop contents 1) contents))
  (define clean-contents (irregex-replace/all "on " clean-contents "on-"))
  (define tags (map string->symbol (string-split clean-contents " ")))
  (define new-style (if closing
			(lset-difference eq? style tags)
			(lset-union eq? style tags)))
  (define control-seq (graphics-style new-style))
  (values control-seq new-style))

(define (parse-markup text #!optional (style '()))
  (define match (irregex-search +re-tags+ text))
  (if match
      (let-values (((control-seq new-style) (parse-tag (irregex-match-substring match 1) style)))
	(parse-markup (irregex-replace +re-tags+ text control-seq) new-style))
      (string-append text (graphics-style '()))))

(define (remove-markup text)
  (irregex-replace/all +re-tags+ text ""))

