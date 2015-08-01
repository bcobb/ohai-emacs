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
 'cider-repl-mode-hook
 #'eldoc-mode)

(add-hook
 'cider-repl-mode-hook
 #'paredit-mode)

;; Grab PATH from the containing shell

(package-require 'exec-path-from-shell)

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
