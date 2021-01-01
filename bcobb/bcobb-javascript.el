(use-package prettier-js)
(use-package add-node-modules-path)
(use-package indium)

(use-package typescript-mode
  :mode (("\\.tsx?$" . typescript-mode)))

(use-package web-mode
  :mode (("\\.jsx?$" . web-mode)
         ("\\.es6\\'" . web-mode)
         ("\\.ejs\\'" . web-mode))
  :config
  (setq web-mode-content-types-alist
        '(("jsx" . "\\.jsx?$")))
  ;; Stop web-mode from using block comments in comment-dwim.
  (setq web-mode-comment-formats
        (-map-when (lambda (i) (equal (car i) "javascript"))
                   (lambda (i) (cons (car i) "//"))
                   web-mode-comment-formats))
  (add-to-list 'web-mode-comment-formats `("jsx" . "//"))

  ;; Let Flycheck know that we're using web-mode for JS.
  (with-eval-after-load "flycheck"
    (flycheck-add-mode 'javascript-eslint 'web-mode)
    (setq flycheck-javascript-eslint-executable (executable-find "eslint"))))

(require 'bcobb-lib)

(add-hook 'web-mode-hook #'(lambda ()
                             (enable-minor-mode
                              '("\\.jsx?\\'" . prettier-js-mode))
                             (flow-minor-enable-automatically)
                             (add-node-modules-path)
                             (nvm-use-for-buffer)))

(add-hook 'typescript-mode-hook 'prettier-js-mode)

(when (not (member 'javascript-jshint flycheck-disabled-checkers))
  (setq-default flycheck-disabled-checkers (append flycheck-disabled-checkers '(javascript-jshint))))

(when (not (member 'json-jsonlist flycheck-disabled-checkers))
  (setq-default flycheck-disabled-checkers (append flycheck-disabled-checkers '(json-jsonlist))))

(require 'nvm)

(provide 'bcobb-javascript)
