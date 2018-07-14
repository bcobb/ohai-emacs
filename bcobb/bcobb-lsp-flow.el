(require 'lsp-javascript-flow)
(use-package add-node-modules-path)

(add-hook 'web-mode-hook #'(lambda ()
                             (add-node-modules-path)
                             (lsp-javascript-flow-enable)))

(provide 'bcobb-lsp-flow)
