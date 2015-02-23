
define install-template 
cd $$HOME && cp -v -s -b $(CURDIR)/$(1) ./$(2)
endef

.PHONY: install
install:
	$(call install-template,bashrc,.bashrc)
	$(call install-template,tmux.conf,.tmux.conf)
	$(call install-template,emacs,.emacs)
	mkdir -p $(HOME)/.config
	$(call install-template,user-dirs.dirs,.config/user-dirs.dirs)
	$(call install-template,environment.sh,.environment)
