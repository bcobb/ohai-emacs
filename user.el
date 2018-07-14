(use-package ag)

(add-to-list 'load-path (concat dotfiles-dir "bcobb"))
(add-to-list 'load-path (concat dotfiles-dir "lib"))

(require 'bcobb-chruby)
(require 'bcobb-copypasta)
(require 'bcobb-rubocop)
(require 'bcobb-ohai-tweaks)
(require 'bcobb-javascript)
(require 'bcobb-swiper)

(add-to-list 'default-frame-alist '(font . "Hack-16"))
