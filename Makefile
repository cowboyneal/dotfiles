makefile := $(abspath $(lastword $(MAKEFILE_LIST)))
dotfiles := $(abspath $(dir $(makefile)))

force:

define rule.template
$(1)/% : $(2)/% force
	mkdir -p $$(@D)
	cp -R $$< $$@
endef

rule.define = $(eval $(call rule.template,$(1),$(2)))
$(call rule.define,~,$(dotfiles))

all += bash config git mutt tmux vim
bash        : ~/.bash_logout ~/.bash_profile ~/.bashrc ~/.inputrc ~/.profile
config      : ~/.config
git         : ~/.gitconfig
mutt        : ~/.muttrc
tmux        : ~/.tmux.conf
vim         : ~/.gvimrc ~/.vim ~/.vimrc

x11 += alacritty themes urxvt Xdefaults xsession
alacritty   : ~/.alacritty.toml
themes      : ~/.themes
urxvt       : ~/.urxvt
Xdefaults   : ~/.Xdefaults
xsession    : ~/.xsessionrc

fluxbox     : ~/.fluxbox
fvwm        : ~/.fvwm

x11         : $(x11)
.PHONY: x11 $(x11)

all         : $(all)
.PHONY: all $(all)
.DEFAULT_GOAL := all
