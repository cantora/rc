
define install-template 
cd $$HOME && cp -v -s $(CURDIR)/$(1) ./$(2)
endef

.PHONY: install
install:
	$(call install-template,bashrc,.bashrc)
	$(call install-template,tmux.conf,.tmux.conf)
	$(call install-template,emacs,.emacs)

