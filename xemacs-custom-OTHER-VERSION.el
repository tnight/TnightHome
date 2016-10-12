(custom-set-variables
 '(user-mail-address "terryn@trendwestresorts.com")
 '(query-user-mail-address nil))

(custom-set-faces)

;; Are we running on MS Windows?
(defconst running-on-windows (eq window-system 'mswindows))
(if running-on-windows
 (custom-set-faces
  '(default ((t (:family "Andale Mono" :size "9pt"))) t)))

