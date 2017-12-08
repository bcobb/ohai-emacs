;;; -*- lexical-binding: t -*-

;;; logbook.el --- keep a logbook in Emacs

;; Inspired by https://routley.io/tech/2017/11/23/logbook.html

(defgroup logbook nil
  "logbook"
  :group 'local)

(defcustom logbook-directory (expand-file-name "~/.logbook")
  "Path to directory which contains logbook files"
  :type 'directory
  :safe 'stringp
  :group 'logbook)

(defun logbook--directory ()
  (expand-file-name
   (file-name-as-directory logbook-directory)))

(defun logbook--today ()
  (let ((name (format-time-string "%Y-%m-%d"))
        (extension ".markdown"))
    (concat
     (logbook--directory)
     name
     extension)))

(defun logbook-header ()
  (interactive)
  (let ((content (format-time-string "%A, %B %-d, %Y")))
    (insert (concat "# " content))))

(defun logbook-entries ()
  (interactive)
  (dired (logbook--directory)))

(defun logbook-open ()
  (interactive)
  (let ((file-name (logbook--today)))
    (find-file file-name)
    (save-buffer)))

(provide 'logbook)
