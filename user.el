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
 'cider-mode-hook
 #'eldoc-mode)

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
