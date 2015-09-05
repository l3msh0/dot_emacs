(el-get-bundle popwin)
(use-package popwin
  :config
  (setq display-buffer-function 'popwin:display-buffer))

  ;; (push '("helm" :regexp t) popwin:special-display-config)
  ;; (push '("*Async Shell Command*") popwin:special-display-config)
  ;; (push '("*twittering-edit*" :regexp t) popwin:special-display-config)
