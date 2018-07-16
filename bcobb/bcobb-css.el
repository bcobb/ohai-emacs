(use-package scss-mode)
(use-package css-mode)

(add-to-list 'auto-mode-alist '("\\.scss.erb\\'" . css-mode))

(provide 'bcobb-scss)
