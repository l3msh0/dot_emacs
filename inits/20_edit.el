(el-get-bundle undo-tree)
(use-package undo-tree
  :config
  (global-undo-tree-mode 1))

(el-get-bundle wgrep)

(el-get-bundle ag)
(use-package ag
  :commands (ag)
  :config
  (use-package wgrep)
  (bind-key "C-x C-q" 'wgrep-change-to-wgrep-mode ag-mode-map)
  (define-key ag-mode-map (kbd "C-x C-q") 'wgrep-change-to-wgrep-mode))

(el-get-bundle anzu)
(use-package anzu
  :config
  (global-anzu-mode 1))

(el-get-bundle ddskk)
(use-package ddskk
  :bind ("C-x C-j" . skk-mode))

(el-get-bundle smartrep)
(use-package smartrep)

(el-get-bundle open-junk-file)
(use-package open-junk-file
  :bind ("C-x C-z" . open-junk-file))

(el-get-bundle smex)
(use-package smex
  :bind ("M-x" . smex))

(el-get-bundle highlight-symbol)
(use-package highlight-symbol
  :commands (highlight-symbol-mode))

;; copy buffer file name
(defun my/copy-buffer-file-name ()
  "Copy buffer file name"
  (interactive)
  (if buffer-file-name
      (progn
        (kill-new buffer-file-name)
        (message buffer-file-name))
    (message "the buffer is not bound to any file")))
(global-set-key (kbd "C-x y") 'my/copy-buffer-file-name)
