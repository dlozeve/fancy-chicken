(import (chicken format) srfi-18 fancy)

(define (main . args)
  (display (rule "[bold green]Fancy demo" style: 'simple))
  (display (parse-markup
	  "[bold red]Lorem ipsum[/bold red] dolor sit amet, [underline]consectetur[/underline] adipiscing elit, sed do
eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad
minim veniam, [cyan]quis nostrud exercitation [yellow]ullamco[/yellow] laboris[/cyan] nisi ut
aliquip ex ea commodo consequat. Duis aute irure dolor in
reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla
pariatur. [black on yellow]Excepteur sint [on red]occaecat[/on red] cupidatat non proident, sunt in
culpa qui officia deserunt mollit anim id est laborum."))
  (display "\n\n")

  (define tab (make-table '("[bold]#" "[bold]Name" "[bold]Property") '(3 20 20)))
  (display (table-header tab))
  (display (table-row tab "42" "[green]Foo" "Bar"))
  (display (table-row tab "21" "[red]Toto" "Blublu"))
  (display (table-footer tab))
  (display "\n\n")

  (let loop ((i 0))
    (when (< i 20)
      (display (spinner i "[yellow]Waiting:" (format "(computing ~a/20)" (add1 i))
			style: 'dots))
      (thread-sleep! 0.1)
      (loop (add1 i)))))
