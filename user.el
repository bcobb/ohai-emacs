(setq magit-last-seen-setup-instructions "1.4.0")

(use-package ag)

(use-package clj-refactor)
(use-package paredit)
(use-package cider)

(add-hook
 'clojure-mode-hook
 (lambda ()
   (paredit-mode)
   (eldoc-mode)
   (clj-refactor-mode 1)))

(add-hook
 'cider-repl-mode-hook
 'eldoc-mode)

(add-hook
 'cider-repl-mode-hook
 #'paredit-mode)

;; Grab PATH from the containing shell

(use-package exec-path-from-shell)

(when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize))

;; Open recent files in style. (C-x f)

(require 'recentf)
(setq recentf-max-saved-items 200
      recentf-max-menu-items 25)
(recentf-mode +1)
(setq ido-save-directory-list-file (expand-file-name "~/.emacs.d/.ido.last"))

(defun recentf-ido-find-file ()
  "Find a recent file using ido."
  (interactive)
  (let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
    (when file
      (find-file file))))

(global-set-key (kbd "C-x f") 'recentf-ido-find-file)

;; Unify copy/paste

(defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

(setq interprogram-cut-function 'paste-to-osx)
(setq interprogram-paste-function 'copy-from-osx)

;; Use C-n/C-p to navigate vertical ido

(setq ido-vertical-define-keys 'C-n-and-C-p-only)

;; Rubby

(use-package enh-ruby-mode)
(setq ruby-align-chained-calls t)

(use-package yard-mode)

(add-hook 'ruby-mode-hook 'yard-mode)
(add-hook 'ruby-mode-hook 'eldoc-mode)

(use-package chruby)

(defun bcobb-ruby-version (path)
  (car (with-temp-buffer
         (insert-file-contents path)
         (split-string (buffer-string) "\n" t))))

(defun bcobb-projectile-chruby ()
  (let ((file-path (concat (projectile-project-root) ".ruby-version")))
    (if (file-exists-p file-path)
        (chruby (bcobb-ruby-version file-path))
      "no .ruby-version in the project root")))

(defun bcobb-projectile-bundler-p ()
  (when (projectile-project-p)
    (let ((file-path (concat (projectile-project-root) "Gemfile.lock")))
      (file-exists-p file-path))))

(defun bcobb-flycheck-rubocop-wrapper (command)
  (if (bcobb-projectile-bundler-p)
      (append '("bundle" "exec") command)
    command))

(defun bcobb-cwd-chruby ()
  (let ((file-path (".ruby-version")))
    (if (file-exists-p file-path)
        (chruby (bcobb-ruby-version file-path))
      "no .ruby-version in the current directory"))  )

(defun bcobb-chruby ()
  (if (projectile-project-p)
      (bcobb-projectile-chruby)
    (bcobb-chruby-cwd)))

;; Undo Tree

(use-package undo-tree)

;; Company

(setq company-idle-delay nil)

;; YAML

(use-package yaml-mode)

;; Projectile

(setq projectile-switch-project-action 'projectile-dired)

(add-hook 'projectile-after-switch-project-hook 'bcobb-projectile-chruby)

;; This little light of mine
(use-package beacon)

(beacon-mode 1)

;; Markdown

(use-package markdown-mode)

(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("README\\.md$" . gfm-mode))
(add-to-list 'auto-mode-alist '("README\\.markdown$" . gfm-mode))

(setq markdown-open-command "marked")

;; Flycheck

(setq flycheck-command-wrapper-function 'bcobb-flycheck-rubocop-wrapper)

;; Misc

(defun show-xml-path (arg)
  "Shows the names of all elements enclosing point, in the echo area."
  (interactive "*P")
  (let ((q ""))
    (nxml-ensure-scan-up-to-date)
    (setq q "")
    (condition-case ()
        (save-excursion
          (while t
            (nxml-backward-up-element)
            (setq q (concat (xmltok-start-tag-qname) "/" q))))
      (error (message q)))))
