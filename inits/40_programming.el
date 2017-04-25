;;; General
(add-hook 'emacs-lisp-mode-hook 'eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)

;;; flycheck
(el-get-bundle flycheck)
(use-package flycheck
  :config
  (key-chord-define flycheck-mode-map "bf" 'flycheck-buffer))

;;; dash
(when (eq 'darwin system-type)
  (el-get-bundle dash-at-point)
  (use-package dash-at-point
    :config
    (key-chord-define-global "d." 'dash-at-point)))

(el-get-bundle ctags-update)
(use-package ctags-update
  :commands (turn-on-ctags-auto-update-mode ctags-update)
  :config
  (add-hook 'ruby-mode-hook 'turn-on-ctags-auto-update-mode))

(el-get-bundle quickrun)
(use-package quickrun)

;;; smartparens
(el-get-bundle smartparens)
(use-package smartparens
  :config
  (smartparens-global-mode 1)

  (eval-after-load "ruby-mode"
    '(require 'smartparens-ruby))

  (sp-pair "<%" "%>")

  (sp-local-pair 'minibuffer-inactive-mode "'" nil :actions nil)
  ; html-mode
  (sp-with-modes '(html-mode sgml-mode web-mode)
    (sp-local-pair "<" ">"))
  ; lisp modes
  (sp-with-modes sp--lisp-modes
    (sp-local-pair "(" nil :bind "C-("))
  ; markdown modes
  (sp-with-modes '(markdown-mode gfm-mode rst-mode)
    (sp-local-pair "*" "*" :bind "C-*")
    (sp-local-tag "2" "**" "**")
    (sp-local-tag "s" "```scheme" "```")
    (sp-local-tag "<"  "<_>" "</_>" :transform 'sp-match-sgml-tags))

  (define-key smartparens-mode-map (kbd "C-<right>") 'sp-forward-slurp-sexp)
  (define-key smartparens-mode-map (kbd "C-<right>") 'sp-forward-barf-sexp)
  (define-key smartparens-mode-map (kbd "C-M-f") 'sp-forward-sexp)
  (define-key smartparens-mode-map (kbd "C-M-b") 'sp-backward-sexp)
  (define-key smartparens-mode-map (kbd "C-M-d") 'sp-down-sexp)
  (define-key smartparens-mode-map (kbd "C-M-a") 'sp-backward-down-sexp)
  (define-key smartparens-mode-map (kbd "C-S-a") 'sp-beginning-of-sexp)
  (define-key smartparens-mode-map (kbd "C-S-d") 'sp-end-of-sexp)
  (define-key smartparens-mode-map (kbd "C-M-e") 'sp-up-sexp)
  (define-key emacs-lisp-mode-map (kbd ")") 'sp-up-sexp)
  (define-key smartparens-mode-map (kbd "C-M-u") 'sp-backward-up-sexp)
  (define-key smartparens-mode-map (kbd "C-M-t") 'sp-transpose-sexp)
  (define-key smartparens-mode-map (kbd "C-M-n") 'sp-next-sexp)
  (define-key smartparens-mode-map (kbd "C-M-p") 'sp-previous-sexp)
  (define-key smartparens-mode-map (kbd "C-M-k") 'sp-kill-sexp)
  (define-key smartparens-mode-map (kbd "C-M-w") 'sp-copy-sexp)
  (define-key smartparens-mode-map (kbd "M-<delete>") 'sp-unwrap-sexp)
  (define-key smartparens-mode-map (kbd "M-<backspace>") 'sp-backward-unwrap-sexp)
  (define-key smartparens-mode-map (kbd "M-<right>") 'sp-forward-slurp-sexp)
  (define-key smartparens-mode-map (kbd "M-<left>") 'sp-forward-barf-sexp)
  (define-key smartparens-mode-map (kbd "M-S-<left>") 'sp-backward-slurp-sexp)
  (define-key smartparens-mode-map (kbd "M-S-<right>") 'sp-backward-barf-sexp)
  (define-key smartparens-mode-map (kbd "C-M-<delete>") 'sp-splice-sexp)
  (define-key smartparens-mode-map (kbd "C-M-<backspace>") 'sp-splice-sexp-killing-backward)
  (define-key smartparens-mode-map (kbd "C-S-<backspace>") 'sp-splice-sexp-killing-around)
  (define-key smartparens-mode-map (kbd "C-]") 'sp-select-next-thing-exchange)
  (define-key smartparens-mode-map (kbd "C-<left_bracket>") 'sp-select-previous-thing)
  (define-key smartparens-mode-map (kbd "C-M-]") 'sp-select-next-thing)
  (define-key smartparens-mode-map (kbd "M-F") 'sp-forward-symbol)
  (define-key smartparens-mode-map (kbd "M-B") 'sp-backward-symbol)
  (define-key smartparens-mode-map (kbd "H-t") 'sp-prefix-tag-object)
  (define-key smartparens-mode-map (kbd "H-p") 'sp-prefix-pair-object)
  (define-key smartparens-mode-map (kbd "H-s c") 'sp-convolute-sexp)
  (define-key smartparens-mode-map (kbd "H-s a") 'sp-absorb-sexp)
  (define-key smartparens-mode-map (kbd "H-s e") 'sp-emit-sexp)
  (define-key smartparens-mode-map (kbd "H-s p") 'sp-add-to-previous-sexp)
  (define-key smartparens-mode-map (kbd "H-s n") 'sp-add-to-next-sexp)
  (define-key smartparens-mode-map (kbd "H-s j") 'sp-join-sexp)
  (define-key smartparens-mode-map (kbd "H-s s") 'sp-split-sexp))

;;; editorconfig
(el-get-bundle editorconfig)
(use-package editorconfig
  :config
  (editorconfig-mode 1))

;;; web-mode
(el-get-bundle web-mode)
(el-get-bundle emmet-mode)
(use-package web-mode
  :mode ("\\.html\\'" "\\.erb\\'")
  :config
  (bind-key "C-c C-v" 'browse-url-of-buffer web-mode-map)
  (use-package emmet-mode
    :config
    (add-hook 'web-mode-hook 'emmet-mode)
    (bind-key "M-RET" 'emmet-expand-line emmet-mode-keymap)))

;;; scss-mode
;; (el-get-bundle scss-mode)
;; (use-package scss-mode
;;   :mode ("\\.scss\\'"))

;;; yasnippet
(el-get-bundle yasnippet)
(use-package yasnippet
  :config
  (yas-global-mode 1)
  (add-to-list 'yas-snippet-dirs (concat user-emacs-directory "site-lisp/snippets") t))

;;; auto-complete
(el-get-bundle auto-complete)
(use-package auto-complete
  :config
  (global-auto-complete-mode 1)
  (ac-config-default)

  ;;; advice for whitespace-mode conflict
  (defvar my-prev-whitespace-mode nil)
  (make-variable-buffer-local 'my-prev-whitespace-mode)

  (defadvice popup-draw (before my-turn-off-whitespace)
    "Turn off whitespace mode before showing popup"
    (make-local-variable 'my-prev-whitespace-mode)
    (when global-whitespace-mode
      (setq my-prev-whitespace-mode t)
      (global-whitespace-mode 0)))

  (defadvice popup-delete (after my-restore-whitespace)
    "Restore previous whitespace mode when deleting popup"
    (when my-prev-whitespace-mode
      (global-whitespace-mode 1)
      (setq my-prev-whitespace-mode nil)))

  (ad-activate 'popup-draw)
  (ad-activate 'popup-delete))

;;; PHP
(el-get-bundle php-mode)
(el-get-bundle php-eldoc)
(use-package php-mode
  :mode ("\\.php$" . php-mode)
  :config
  (use-package php-eldoc)
  (defun my-php-mode-hook ()
    (linum-mode 1)
    (flycheck-mode 1)
    (setq indent-tabs-mode t)
    (highlight-symbol-mode 1))
  (add-hook 'php-mode-hook 'my-php-mode-hook))

;;; JavaScript
(el-get-bundle js2-mode)
(use-package js2-mode
  :mode ("\\.js\\'" . js2-mode))

(el-get-bundle coffee-mode)
(use-package coffee-mode
  :mode ("\\.coffee\\'" . coffee-mode))

;; ;;; Clojure
(el-get-bundle cider)
(use-package cider
  :config
  (add-hook 'clojure-mode-hook 'cider-mode)
  (add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
  (add-hook 'cider-repl-mode-hook 'smartparens-strict-mode))

;;; Golang
(el-get-bundle go-mode)
(use-package go-mode
  :mode ("\\.go\\'" . go-mode)
  :init
  (add-hook 'go-mode-hook 'flycheck-mode)
  (add-hook 'go-mode-hook (lambda () (interactive)
                            (setq ac-sources '(ac-source-go ac-source-yasnippet))))
  (add-hook 'before-save-hook (lambda () (interactive)
                                (when (eq major-mode 'go-mode) (gofmt)))))

(el-get-bundle go-autocomplete)
(use-package go-autocomplete)

(el-get-bundle go-eldoc)
(use-package go-eldoc
  :commands go-eldoc-setup
  :init
  (add-hook 'go-mode-hook 'go-eldoc-setup))

;; (el-get-bundle go-rename)
;; (use-package go-rename
;;   :commands go-rename
;;   :init
;;   (key-chord-define go-mode-map "gn" 'go-rename))

(el-get-bundle lispxmp)
(use-package lispxmp)

;;; Ruby
(use-package ruby-mode
  :mode ("\\.rb\\'" . ruby-mode)
  :config
  (add-hook 'ruby-mode-hook (lambda ()
                              (interactive)
                              (flycheck-mode 1)))
  (modify-syntax-entry ?! "_"))

(el-get-bundle rspec-mode)
(use-package rspec-mode
  :init (add-hook 'ruby-mode-hook 'rspec-mode)
  :commands rspec-mode
  :config
  (rspec-install-snippets))

;;; Haml

(el-get-bundle haml-mode)
(use-package haml-mode
  :mode ("\\.haml\\'" . haml-mode))
