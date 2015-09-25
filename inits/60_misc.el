(el-get-bundle markdown-mode)
(use-package markdown-mode
  :mode "\\.md\\'")

(el-get-bundle restclient)
(use-package restclient
  :commands (restclient))

;; Libraries
(el-get-bundle deferred)
(el-get-bundle json)


(require 'org-table)

(defun cleanup-org-tables ()
  (save-excursion
    (goto-char (point-min))
    (while (search-forward "-+-" nil t) (replace-match "-|-"))
    ))

(add-hook 'markdown-mode-hook 'orgtbl-mode)
(add-hook 'markdown-mode-hook
          (lambda()
            (add-hook 'before-save-hook 'cleanup-org-tables  nil 'make-it-local)))
