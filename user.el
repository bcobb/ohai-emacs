(setq magit-last-seen-setup-instructions "1.4.0")

(package-require 'ag)

(package-require 'clj-refactor)
(package-require 'paredit)
(package-require 'cider)

(add-hook
 'clojure-mode-hook
 (lambda ()
   (paredit-mode)
   (clj-refactor-mode 1)))

(add-hook
 'cider-mode-hook
 #'eldoc-mode)
