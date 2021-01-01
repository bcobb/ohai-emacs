(use-package clojure-mode)
(use-package cider)
(use-package clj-refactor)

(add-hook 'clojure-mode-hook
          (lambda ()
            (paredit-mode)
            (eldoc-mode)
            (clj-refactor-mode 1)))

(add-hook 'cider-repl-mode-hook 'eldoc-mode)

(add-hook 'cider-repl-mode-hook 'paredit-mode)
