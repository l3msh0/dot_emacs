;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Language Enviornment
;;;

(set-language-environment "Japanese")
(set-default-coding-systems 'utf-8)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Font & Theme
;;;

(el-get-bundle elpa:noctilux-theme)
(load-theme 'wombat)


;; transparent
(add-to-list 'default-frame-alist '(alpha . 93))

;; variables
(setq-default indent-line-function 'indent-relative-maybe)

(put 'erase-buffer 'disabled nil)
;; built-in minor-mode
(global-hl-line-mode 1)
(column-number-mode 1)
(line-number-mode 1)
(show-paren-mode 1)
(global-whitespace-mode 1)
(display-time-mode 1)
(auto-fill-mode 0)
(menu-bar-mode 0)
(tool-bar-mode 0)
(cua-mode 0)
(ido-mode 1)
(which-function-mode 1)

;; aliases
(defalias 'yes-or-no-p 'y-or-n-p)

;; hook
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; regard camelCase as separated word
(let (upper lower)
  (setq upper (get-unused-category))
  (define-category upper "Upper case")
  (modify-category-entry (cons ?A ?Z) upper)

  (setq lower (get-unused-category))
  (define-category lower "Lower case")
  (modify-category-entry (cons ?a ?z) lower)

  (add-to-list 'word-separating-categories (cons lower upper)))

; Problem with TRAMP mode
; Control Path too long error
; TMPDIR variable is really large
; http://lists.macosforge.org/pipermail/macports-tickets/2011-June/084295.html
(setenv "TMPDIR" "/tmp")
