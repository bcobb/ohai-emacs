(use-package ag)
(use-package undo-tree
  :config (global-undo-tree-mode))

(add-to-list 'load-path (concat dotfiles-dir "bcobb"))
(add-to-list 'load-path (concat dotfiles-dir "lib"))

(require 'bcobb-chruby)
(require 'bcobb-copypasta)
(require 'bcobb-rubocop)
(require 'bcobb-ohai-tweaks)
(require 'bcobb-javascript)
(require 'bcobb-swiper)
(require 'bcobb-logbook)
(require 'bcobb-yaml)

(add-to-list 'default-frame-alist '(font . "Hack-16"))
