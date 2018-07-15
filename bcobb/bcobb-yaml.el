(use-package yaml-mode)
(use-package flycheck-yamllint
  :commands flycheck-yamllint-setup)

(when (ohai/is-exec "yamllint")
  (add-hook 'flycheck-mode-hook 'flycheck-yamllint-setup))

(provide 'bcobb-yaml)
