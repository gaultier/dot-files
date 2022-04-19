.PHONY: test

test: gitlab.lua
	cd ~/projects/test && nvim -R --headless -u NONE --clean README.md\
		-c ':luafile ~/.config/nvim/lua/gitlab.lua'\
		-c ':GitlabUrlCopy true'\
		-c ':GitlabUrlCopy false'\
		-c ':GitlabUrlOpen true'\
		-c ':GitlabUrlOpen false'\
		-c ":lua vim.pretty_print(gitlab_url_at_point(3, 4, 'true'))"\
		-c ":lua vim.pretty_print(gitlab_url_at_point(3, 3, 'true'))"\
		-c ":lua vim.pretty_print(gitlab_url_at_point(3, 4, 'false'))"\
		-c ":lua vim.pretty_print(gitlab_url_at_point(3, 4, ''))"\
		-c ':qa'
