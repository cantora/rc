
define install-template 
cd $$HOME && cp -v -s -b $(CURDIR)/$(1) ./$(2)
endef

.PHONY: install
install:
	$(call install-template,bashrc,.bashrc)
	$(call install-template,tmux.conf,.tmux.conf)
	$(call install-template,emacs,.emacs)
	$(call install-template,key.map,.key.map)
	echo "set /etc/vconsole.conf KEYMAP variable to:"
	echo "KEYMAP=/home/USER/.key.map"

