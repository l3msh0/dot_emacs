(el-get-bundle markdown-mode)
(use-package markdown-mode
  :mode "\\.md\\'"
  :config
  (bind-key "C-x m" (lambda () (interactive) (start-process "Marked" nil "/Applications/Marked.app/Contents/MacOS/Marked" (buffer-file-name)) markdown-mode-map))
  (add-hook 'markdown-mode-hook 'orgtbl-mode)
  (add-hook 'markdown-mode-hook
            (lambda ()
              (interactive)
              (add-hook 'before-save-hook 'cleanup-org-tables  nil 'make-it-local)
              (remove-hook 'before-save-hook 'delete-trailing-whitespace))))

(el-get-bundle yaml-mode)
(use-package yaml-mode
  :mode ("\\.yml\\'" "\\.yaml\\'"))

(el-get-bundle restclient)
(use-package restclient
  :commands (restclient)
  :mode ("\\.rest\\'" . restclient-mode))

;; Libraries
(el-get-bundle deferred)
;(el-get-bundle json)


(require 'org-table)

(defun cleanup-org-tables ()
  (save-excursion
    (goto-char (point-min))
    (while (search-forward "-+-" nil t) (replace-match "-|-"))
    ))
