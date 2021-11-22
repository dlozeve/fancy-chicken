(define +spinner-styles+
  '((dots . "⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏")
    (block . "▖▘▝▗")
    (triangle . "◢◣◤◥")
    (circle . "◐◓◑◒")
    (vertical . "▁▃▄▅▆▇█▇▆▅▄▃")
    (horizontal . "▉▊▋▌▍▎▏▎▍▌▋▊▉")
    (ascii . "|/-\\")))

(define (spinner i text-before text-after #!key (style 'dots))
  (define spinner-chars (cdr (assoc style +spinner-styles+)))
  (string-append
   (cursor-up 1)
   (parse-markup text-before)
   " "
   (string (string-ref spinner-chars (modulo i (string-length spinner-chars))))
   " "
   (parse-markup text-after)
   "\n"))
