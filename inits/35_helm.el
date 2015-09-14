(el-get-bundle helm)
(use-package helm
  :commands (helm-mini)
  :bind (("C-c ?" . helm-descbinds)
         ("C-c i" . helm-imenu)
         ("M-y" . helm-show-kill-ring)
         ("C-, r" . helm-resume))
  :config
  (bind-key "C-h" 'delete-backward-char helm-map))

(use-package helm-files
  :defer t
  :config
  (bind-key "C-h" 'delete-backward-char helm-find-files-map))

(el-get-bundle helm-descbinds)
(use-package helm-descbinds)

(el-get-bundle helm-ls-git)
(use-package helm-ls-git
  :bind ("C-'" . helm-ls-git-ls))

(el-get-bundle helm-ag)
(use-package helm-ag
  :bind ("M-g ." . helm-ag)
  :commands (helm-ag)
  :config
  (bind-keys* ("M-g ," . helm-ag-pop-stack)))

(el-get-bundle helm-gtags)
(use-package helm-gtags
  :bind (("M-." . helm-gtags-dwim)
         ("M-*" . helm-gtags-pop-stack))
  :commands (helm-gtags-find-tag helm-gtags-find-rtag helm-gtags-select)
  :init
  (key-chord-define-global "jt" 'helm-gtags-find-tag)
  (key-chord-define-global "jr" 'helm-gtags-find-rtag)
  (key-chord-define-global "js" 'helm-gtags-select))
