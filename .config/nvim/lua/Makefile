.PHONY: test

test: gitlab.lua
	cd ~/projects/test && nvim -R --headless -u NONE --clean README.md\
		-c ':pwd'\
		-c ':luafile ~/.config/nvim/lua/gitlab.lua'\
		-c ':luafile ~/.config/nvim/lua/gitlab_test.lua'\
		-c ':GitlabUrlCopy true'\
		-c ':GitlabUrlCopy false'\
		-c ':qa'
