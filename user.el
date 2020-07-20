(use-package ag)
(use-package undo-tree
  :config (global-undo-tree-mode))

(add-to-list 'load-path (concat dotfiles-dir "bcobb"))
(add-to-list 'load-path (concat dotfiles-dir "lib"))
(add-to-list 'load-path (concat dotfiles-dir "local"))
(add-to-list 'load-path (concat dotfiles-dir "vendor"))

(load "environment" 't)

(require 'bcobb-lib)

(require 'bcobb-chruby)
(require 'bcobb-copypasta)
(require 'bcobb-javascript)
(require 'bcobb-js-flow)
(require 'bcobb-logbook)
(require 'bcobb-ohai-tweaks)
(require 'bcobb-rubocop)
(require 'bcobb-ruby)
(require 'bcobb-swiper)
(require 'bcobb-yaml)

(add-to-list 'default-frame-alist '(font . "Hack-16"))
