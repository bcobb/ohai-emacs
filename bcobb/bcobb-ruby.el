(use-package enh-ruby-mode)
(use-package rspec-mode)
(use-package rufo
  :diminish 'rufo-minor-mode)
(use-package inf-ruby)

(add-to-list 'auto-mode-alist
             '("\\(?:\\.rb\\|ru\\|rake\\|thor\\|jbuilder\\|gemspec\\|podspec\\|/\\(?:Gem\\|Rake\\|Cap\\|Thor\\|Vagrant\\|Guard\\|Pod\\)file\\)\\'" . enh-ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))

;(add-hook 'enh-ruby-mode-hook 'rufo-minor-mode)
;(add-hook 'enh-ruby-mode-hook #'(lambda () (enable-minor-mode '("\\.rb\\'" . prettier-js-mode)) (add-node-modules-path)))

                                        ;(remove-hook 'enh-ruby-mode-hook 'rufo-minor-mode)

(require 'rubocop)

;(add-hook 'enh-ruby-mode-hook 'rubocop-mode)

(provide 'bcobb-ruby)
