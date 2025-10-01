makefile := $(abspath $(lastword $(MAKEFILE_LIST)))
dotfiles := $(abspath $(dir $(makefile)))

force:

define rule.template
$(1)/% : $(2)/% force
	mkdir -p $$(@D)
	cp -Rd $$< $$@
endef

rule.define = $(eval $(call rule.template,$(1),$(2)))
$(call rule.define,~,$(dotfiles))

all += bash config tmux vim
bash   : ~/.bash_logout ~/.bash_profile ~/.bashrc ~/.inputrc ~/.profile
config : ~/.config
tmux   : ~/.tmux.conf
vim    : ~/.vim ~/.vimrc

all : $(all)
.PHONY: all $(all)
.DEFAULT_GOAL := all
