(use-package add-node-modules-path)

(use-package flow-minor-mode)
(use-package flycheck-flow)
(use-package company-flow)

(add-hook 'web-mode-hook #'(lambda ()
                             (flow-minor-enable-automatically)
                             (add-node-modules-path)))

(with-eval-after-load 'flycheck
  (flycheck-add-mode 'javascript-flow 'flow-minor-mode)
  (flycheck-add-mode 'javascript-eslint 'flow-minor-mode)
  (flycheck-add-next-checker 'javascript-flow 'javascript-eslint))

(with-eval-after-load 'company
  (add-to-list 'company-backends 'company-flow))

(provide 'bcobb-js-flow)
