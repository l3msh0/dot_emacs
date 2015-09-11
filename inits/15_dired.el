(setq dired-isearch-filenames t)


(el-get-bundle dired-hacks)
(use-package dired
  :defer t
  :config
  (bind-keys :map dired-mode-map
             ("z" . dired-zip-files)
             ("SPC" . my/dired-do-quicklook))
  (use-package dired-filter))

(use-package dired-aux
  :defer t
  :config
  ; enable to unzip on dired
  (add-to-list 'dired-compress-file-suffixes '("\\.zip\\'" "" "unzip")))

;; 選択したファイルをzip圧縮
;; http://stackoverflow.com/questions/1431351/how-do-i-uncompress-unzip-within-emacs
(defun dired-zip-files (zip-file)
  "Create an archive containing the marked files."
  (interactive "sEnter name of zip file: ")
  ;; create the zip file
  (let ((zip-file (if (string-match ".zip$" zip-file) zip-file (concat zip-file ".zip"))))
    (shell-command
     (concat "zip "
             zip-file
             " "
             (concat-string-list
              (mapcar
               '(lambda (filename)
                  (file-name-nondirectory filename))
               (dired-get-marked-files))))))
  (revert-buffer)
  ;; remove the mark on all the files  "*" to " "
  (dired-change-marks 42 ?\040)
  ;; mark zip file
  (dired-mark-files-regexp (filename-to-regexp zip-file)))

(defun concat-string-list (list)
   "Return a string which is a concatenation of all elements of the list separated by spaces"
    (mapconcat 'identity list " "))
