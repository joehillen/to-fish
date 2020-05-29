all:
	cp conf.d/to.fish ~/.config/fish/conf.d/
	cp functions/to.fish ~/.config/fish/functions/
	cp completions/to.fish ~/.config/fish/completions/

uninstall:
	rm -f ~/.config/fish/conf.d/to.fish
	rm -f ~/.config/fish/functions/to.fish
	rm -f ~/.config/fish/completions/to.fish
