;; see http://d.hatena.ne.jp/tarao/20150221/1424518030#tips-isolated-setup
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name))
  (setq custom-file (concat user-emacs-directory "custom.el"))
  (when (file-exists-p custom-file)
    (load-file custom-file)))

(let ((versioned-dir (locate-user-emacs-file emacs-version)))
  (setq el-get-dir (expand-file-name "el-get" versioned-dir)
        package-user-dir (expand-file-name "elpa" versioned-dir)))

;;; el-get bootstrap
(add-to-list 'load-path (locate-user-emacs-file (concat el-get-dir "/el-get")))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(el-get-bundle! use-package)

;;; init-loader
(el-get-bundle! emacs-jp/init-loader
  ;; load
  (setq-default init-loader-show-log-after-init nil
                init-loader-byte-compile nil)
  (init-loader-load (locate-user-emacs-file "inits"))
  ;; hide compilation results
  (let ((win (get-buffer-window "*Compile-Log*")))
    (when win (delete-window win))))
