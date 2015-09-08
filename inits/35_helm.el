(el-get-bundle helm)
(use-package helm)

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
