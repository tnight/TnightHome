;; Turn on Auto Fill mode automatically in Text mode and related
;; modes.
(add-hook 'text-mode-hook '(lambda () (auto-fill-mode 1)))

;; Custom modes that we like
(setq auto-mode-alist
  (append
    '(
      ("\\.c$" . c-mode)
      ("\\.cc$" . c++-mode)
      ("\\.conf$" . text-mode)
      ("\\.cpp$" . c++-mode)
      ("\\.h$" . c-mode)
      ("\\.hh$" . c++-mode)
      ("\\.hpp$" . c++-mode)
      ("\\.m$" . objc-mode)
      ("\\.pl$" . cperl-mode)
      ("\\.pm$" . cperl-mode)
      ("\\.ma?ke?\\'" . makefile-mode)
      ("[Mm]akefile\\(\\.\\|\\'\\)" . makefile-mode)
      ("\\.sql$" . sql-mode)
      ("\\.properties$" . text-mode)
      ("\\.servlet_engine$" . xml-mode)
      ("\\.webapp$" . xml-mode)
     ) auto-mode-alist))

;; Load all files from the last session.
(load-library "desktop")
(desktop-read)

