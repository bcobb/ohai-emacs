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

(defun bcobb-cwd-chruby ()
  (let ((file-path (".ruby-version")))
    (if (file-exists-p file-path)
        (chruby (bcobb-ruby-version file-path))
      "no .ruby-version in the current directory"))  )

(defun bcobb-chruby ()
  (interactive)
  (if (projectile-project-p)
      (bcobb-projectile-chruby)
    (bcobb-cwd-chruby)))

(add-hook 'projectile-after-switch-project-hook 'bcobb-projectile-chruby)

(provide 'bcobb-chruby)
