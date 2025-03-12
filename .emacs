(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(explicit-bash-args '("--login" "-i"))
 '(indent-tabs-mode nil)
 '(package-selected-packages
   '(bash-completion csharp-mode csv-mode git less-css-mode magit markdown-mode powershell swift-mode))
 '(save-place t nil (saveplace)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Consolas" :foundry "outline" :slant normal :weight regular :height 98 :width normal)))))

;; BEGIN: Make cperl-mode the default for Perl files.
(add-to-list 'interpreter-mode-alist '("perl" . cperl-mode))
;; END: Make cperl-mode the default for Perl files.

;; BEGIN: load emacs 24's package system. Add MELPA repository.
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
;; END: load emacs 24's package system. Add MELPA repository.

;; BEGIN: Settings for PowerShell mode
(add-to-list 'load-path "/Users/terry/Packages/powershell,el")
;; END: Settings for PowerShell mode

;; BEGIN: Prevent issues with the Windows null device (NUL) when using cygwin find with rgrep.
(setq null-device "/dev/null")
;; END: Prevent issues with the Windows null device (NUL) when using cygwin find with rgrep.

;; BEGIN: Settings for using Git-Bash as our shell.
(if (equal system-type 'windows-nt)
    (progn (setq explicit-shell-file-name
                 "C:/Program Files/Git/bin/sh.exe")
           (setq shell-file-name explicit-shell-file-name)
           (setq explicit-sh.exe-args '("--login" "-i"))
           (setenv "SHELL" shell-file-name)
           ;;;;(add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m)
	   (add-to-list 'exec-path "C:/Program Files/Git/bin")))
;; END: Settings for using Git-Bash as our shell.

;; BEGIN: git completion
;; Found at https://www.masteringemacs.org/article/pcomplete-context-sensitive-completion-emacs

(defconst pcmpl-git-commands
  '("add" "bisect" "branch" "checkout" "clone"
    "commit" "diff" "fetch" "grep"
    "init" "log" "merge" "mv" "pull" "push" "rebase"
    "reset" "rm" "show" "status" "tag" )
  "List of `git' commands")

(defvar pcmpl-git-ref-list-cmd "git for-each-ref refs/ --format='%(refname)'"
  "The `git' command to run to get a list of refs")

(defun pcmpl-git-get-refs (type)
  "Return a list of `git' refs filtered by TYPE"
  (with-temp-buffer
    (insert (shell-command-to-string pcmpl-git-ref-list-cmd))
    (goto-char (point-min))
    (let ((ref-list))
      (while (re-search-forward (concat "^refs/" type "/\\(.+\\)$") nil t)
        (add-to-list 'ref-list (match-string 1)))
      ref-list)))

(defun pcomplete/git ()
  "Completion for `git'"
  ;; Completion for the command argument.
  (pcomplete-here* pcmpl-git-commands)  
  ;; complete files/dirs forever if the command is `add' or `rm'
  (cond
   ((pcomplete-match (regexp-opt '("add" "rm")) 1)
    (while (pcomplete-here (pcomplete-entries))))
   ;; provide branch completion for the command `checkout'.
   ((pcomplete-match "checkout" 1)
    (pcomplete-here* (pcmpl-git-get-refs "heads")))
   ;; provide branch completion for the command `merge'.
   ((pcomplete-match "merge" 1)
    (pcomplete-here* (pcmpl-git-get-refs "heads")))))
;; END: git completion

;; BEGIN: settings for dirtrack-mode, a minor mode of shell-mode.
(setq dirtrack-list '("\\(\\[.*?\\]\\)" 1 nil))
;; END: settings for dirtrack-mode, a minor mode of shell-mode.

;; BEGIN: Disable upcase-region by default to prevent accidental usage.
(put 'upcase-region 'disabled nil)
;; END: Disable upcase-region by default to prevent accidental usage.

;; BEGIN: Define the meeting template macro, an example for future macros.
(fset 'meeting-template
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([15 15 return 68 105 115 99 117 115 115 105 111 110 115 58 return 42 32 91 32 93 32 97 98 99 return return 84 79 68 79 58 return 42 32 91 32 93 32 100 101 102] 0 "%d")) arg)))
(global-set-key (kbd "C-x C-k 1") 'meeting-template)
;; END: Define the meeting template macro, an example for future macros.

;; END of .emacs
