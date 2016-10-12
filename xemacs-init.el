

;; Options Menu Settings
;; =====================
(cond
 ((and (string-match "XEmacs" emacs-version)
       (boundp 'emacs-major-version)
       (or (and
            (= emacs-major-version 19)
            (>= emacs-minor-version 14))
           (= emacs-major-version 20))
       (fboundp 'load-options-file))
  (load-options-file "h:/.xemacs-options")))
;; ============================
;; End of Options Menu Settings

(setq auto-mode-alist
  (append
    '(("\\.cc$"  . c++-mode)
      ("\\.hh$"  . c++-mode)
      ("\\.cpp$" . c++-mode)
      ("\\.hpp$" . c++-mode)
      ("\\.c$"   . c-mode)
      ("\\.h$"   . c++-mode)
      ("\\.m$"   . objc-mode)
      ("\\.pl$"  . cperl-mode)
      ("\\.pm$"  . cperl-mode)
     ) auto-mode-alist))



;; Turn on Auto Fill mode automatically in Text mode and related
;; modes.
(add-hook 'text-mode-hook '(lambda () (auto-fill-mode 1)))

;; Comment out this next line when running XEmacs.
;;; (global-font-lock-mode)

;; Handy key definitions.
(global-set-key "\M-g" 'goto-line)
(global-set-key [home] 'beginning-of-line)
(global-set-key [end] 'end-of-line)

(load-library "Desktop")
(desktop-load-default)
(desktop-read)

;; Fix for poorly-behaved Win95 FTP program.
;; NOTE: Doesn't seem to help.  XEmacs still buggy?
;(setq ange-ftp-ftp-program-name "c:/bin/ftp")
;(setq efs-ftp-program-name "c:/bin/ftp")
