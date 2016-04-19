(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(save-place t nil (saveplace))
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Trying to make AngeFTP work properly with AdHost's Windows FTP server
;; I found this code at: 
;; https://www.emacswiki.org/emacs-test/AngeFtp#toc3

(defvar ange-ftp-windows-hosts '("216.211.129.207")
  "List of hosts running a Windows FTP server"
  )

(defun ange-ftp-msdos-dirstyle-off ()
  "Toggles the dirstyle of the host if listed in the
   `ange-ftp-windows-hosts' variable. This function is intended to
   be called from inside the hook `ange-ftp-process-startup-hook'"
  (if (member host ange-ftp-windows-hosts)
      (let* ((result (ange-ftp-send-cmd host user '(quote "site dirstyle")))
 	     (line (cdr result))
 	     (ok (car result))
 	     (msdos (string-match "200 .+off" line))
 	     )
 	(if ok
 	    (if (not msdos)
 		(ange-ftp-send-cmd host user '(quote "site dirstyle") "Host declared to be running Windows, turning off MSDOS dirstyle")
 	      (message "Host declared to be running Windows, and MSDOS dirstyle already off."))
 	  (message "Host declared to be running Windows, but didn't accept DIRSTYLE command.")
 	  )
 	))) 

(add-hook 'ange-ftp-process-startup-hook 'ange-ftp-msdos-dirstyle-off)

;; END of .emacs
