(use-package tide)
(use-package web-mode)

(require 'bcobb-lib)

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

(add-hook 'typescript-mode-hook #'setup-tide-mode)

(add-to-list 'auto-mode-alist '("\\.tsx?\\'" . web-mode))
(add-hook 'web-mode-hook
          #'(lambda ()
              (enable-minor-mode '("\\.tsx?\\'" . setup-tide-mode))))

;; enable typescript-tslint checker
(flycheck-add-mode 'typescript-tslint 'web-mode)

(add-hook 'typescript-mode-hook #'prettier-js-mode)

(provide 'bcobb-typescript)
