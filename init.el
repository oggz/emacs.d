;; EXTERMINATE! EXTERMINATE! EXTERMINATE!
;; (setq debug-on-error t)
;; (setq max-lisp-eval-depth 500)
;; (setq ad-redefinition-action 'warn)

;; Customs
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; package manager
(require 'package)
(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
	("melpa-stable" . "https://stable.melpa.org/packages/")
	("melpa" . "https://melpa.org/packages/")))
(setq package-archive-priorities
      '(("melpa-stable" . 15)
        ("melpa" . 10 )
        ("gnu" . 5)
        ("marmalade" . 0)))
;(setq package-enable-at-startup nil)
(package-initialize)

;; use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
;; (add-to-list 'load-path "~/.emacs.d/elpa/use-package-2.4/")
;; (add-to-list 'load-path "~/.emacs.d/elpa/bind-key-2.4/")

;; Highlight current line
(global-hl-line-mode +1)

;; Display time in the modeline
(setq display-time-format "%I:%M - %m/%d/%Y")
(display-time-mode 1)

;; Backups
;; (setq temporary-file-directory "~/.emacs.d/backup_files/")
;; (setq backup-directory-alist
;;       `((".*" . ,temporary-file-directory)))
;; (setq auto-save-file-name-transforms
;;       `((".*" ,temporary-file-directory t)))
;; (setq delete-old-versions t
;;       kept-new-versions 6
;;       kept-old-versions 2
;;       version-control t)

;; keys for built-in functions
(global-set-key (kbd "C-c x") 'sunrise)
(global-set-key (kbd "C-c c") 'compile)
(global-set-key (kbd "C-c z") 'gdb)
(global-set-key (kbd "C-c f") 'sudo-find-file)
(global-set-key "\C-z" 'undo)
(global-set-key "\M-TAB" 'my-complete-file-name)
(global-set-key "\M-|" 'shell-command)
(global-set-key "\M-n" 'View-scroll-half-page-forward)
(global-set-key "\M-p" 'View-scroll-half-page-backward)
;;(global-set-key "\M-o" 'w3m-view-url-with-external-browser)
(global-set-key "\C-cd" 'org-decrypt-entry)
(global-set-key "\C-ce" 'mu4e)
(global-set-key "\C-ct" 'oggz-ansi-term)
(global-set-key "\C-cs" 'shell)
(global-set-key (kbd "C-c C") 'close-all-buffers)
(global-set-key (kbd "C-c R") 'revert-buffer)
(global-set-key (kbd "C-c C-n") (lambda () 
				  (interactive) 
				  (ido-find-file-in-dir "~/notes")))

;; File Associations
(add-to-list 'auto-mode-alist '("\\.vert\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.frag\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.vshader\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.fshader\\'" . c++-mode))

;; Colors
;; (setq custom-theme-load-path
;;       '("~/.emacs.d/themes/emacs-color-theme-solarized"))
;; (load-theme 'solarized-dark t)

;; Fonts
(set-face-attribute 'default nil :height 118)

;; Tabs as spaces
(setq-default indent-tabs-mode nil)

;; Window Move With Arrow Keys
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;; GUI Settings
(tool-bar-mode 0)
(menu-bar-mode 0)
(toggle-scroll-bar -1)

;; make emacs use the clipboard
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;; Load Tramp
(require 'tramp)
(when (eq window-system 'w32)
  (setq tramp-default-method "plink"))
(defun tramp-cleanup-all ()
  (interactive)
  (tramp-cleanup-all-buffers)
  (tramp-cleanup-all-connections))

;; Line Numbers
(setq linum-format "%d")
(global-linum-mode 0)

;; We don't need to be absolutely sure about things
(defalias 'yes-or-no-p 'y-or-n-p)

;; show-paren-mode
(show-paren-mode 1)

;; gdb-mode
(setq gdb-many-windows t)

;; ido-mode
(ido-mode)				        
(setq ido-file-extensions-order '(".org" t))

;; dired
(require 'dired)
(defun dired-do-shell-unmount-device ()
  (interactive)
  (save-window-excursion
    (dired-do-async-shell-command
     "udevil unmount" current-prefix-arg ;; linux
     ;; "diskutil unmount" current-prefix-arg ;; mac os x
     (dired-get-marked-files t current-prefix-arg))))
(define-key dired-mode-map (kbd "C-c u") 'dired-do-shell-unmount-device)
(eval-after-load "dired-aux"
   '(add-to-list 'dired-compress-file-suffixes 
                 '("\\.zip\\'" ".zip" "unzip")))

;; calc
(defmath eres (c i)
  (if (> n 0)
      (/ 1 (* 2 3.14 c i))))

;; Save sessions
(desktop-save-mode 0)
(savehist-mode 1)
(setq savehist-additional-variables '(kill-ring search-ring regexp-search-ring))
(setq savehist-file "~/.emacs.d/tmp/savehist")

;; term-mode
(add-hook 'term-mode-hook 
	  (lambda () 
	    (yas-minor-mode -1)
	    (local-set-key (kbd "C-c C-c") 'term-interrupt-subjob)))

;; Browser
(setq browse-url-browser-function 'browse-url-firefox)

;; compilation
(setq compilation-scroll-output t)

;docview 
(setq doc-view-continuous t)
(setq doc-view-resolution 300)

;; lua mode
(setq auto-mode-alist (cons '("\.lua$" . lua-mode) auto-mode-alist ))
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)

;; gnupg
(require 'epa-file)
(setenv "GPG_AGENT_INFO" nil)
;; (defadvice epg--start (around advice-epg-disable-agent activate)
;;   (let ((agent (getenv "GPG_AGENT_INFO")))
;;     (setenv "GPG_AGENT_INFO" nil)
;;     ad-do-it
;;     (setenv "GPG_AGENT_INFO" agent)))

;; wpa
;; (add-to-list 'load-path "~/.emacs.d/projects/")
;; (require 'wpa.el)




;;; Hooks ++++++++++++++++++++++++++++++++++++++++++++++++++

(defun oggz-after-init-hook ()
  ;(org-agenda-list)
  ;(switch-to-buffer "*Org Agenda*")
  )

(add-hook 'after-init-hook 'oggz-after-init-hook)

;; (defun oggz-image-mode-hook ()
;;   (image-toggle-display-text))
;; (add-hook 'image-mode-hook 'oggz-image-mode-hook)




;;; Custom Functions ++++++++++++++++++++++++++++++++++++++++++++++++++

;; open coords in marble
;; (defun open-coords-in-marble ()
;;   (interactive)
;;   (let ((args (concat "--latlon " (car kill-ring) "--distance 2")))
;;     (call-process "marble" nil nil nil args)))

;; toggle theme
(defun toggle-theme ()
  (interactive)
  (if (custom-theme-enabled-p 'solarized-dark)
      (disable-theme 'solarized-dark)
    (enable-theme 'solarized-dark)))

;; sudo shell command
(defun sudo-shell-command (command)
  (interactive "MShell command (root): ")
  (with-temp-buffer
    (cd "/sudo::/")
    (async-shell-command command)))

;; resize window interactively
(defun v-resize (key)
  "interactively resize the window"  
  (interactive "cHit +/- to enlarge/shrink") 
  (cond                                  
   ((eq key (string-to-char "+"))                      
    (enlarge-window 1)             
    (call-interactively 'v-resize)) 
   ((eq key (string-to-char "-"))                      
    (enlarge-window -1)            
    (call-interactively 'v-resize)) 
   (t (push key unread-command-events))))

;; vpn funcs
(defun vpn-start ()
  (interactive)
  (message "Starting VPN...")
  (sudo-shell-command "sudo -S openvpn --config /etc/openvpn/se1.nordvpn.com.tcp443.ovpn")
  (message "VPN Active."))

;; wpa funcs
(defun wpa-reassoc ()
  (interactive)
  (call-process "wpa_cli" nil nil nil "reassociate")
  (call-process "wpa_cli" nil nil nil "reconnect"))
(defun wpa-stop ()
  (interactive)
  (call-process "wpa_cli" nil nil nil "disconnect"))

;; indent buffer or region
(defun indent-buffer ()
  "Indent the currently visited buffer."
  (interactive)
  (indent-region (point-min) (point-max)))
(defun indent-region-or-buffer ()
  "Indent a region if selected, otherwise the whole buffer."
  (interactive)
  (save-excursion
    (if (region-active-p)
        (progn
          (indent-region (region-beginning) (region-end))
          (message "Indented selected region."))
      (progn
        (indent-buffer)
        (message "Indented buffer.")))))

;; edit as root
(defun sudo-find-file (&optional arg)
  (interactive "P")
  (if (or arg (not buffer-file-name))
      (find-file (concat "/sudo:root@localhost:"
                         (ido-read-file-name "Find file(as root): ")))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

(defun oggz-ansi-term ()
  "Start a new ansi-term with a bash shell."
  (interactive)
  (ansi-term "/bin/bash")
  (call-interactively 'rename-buffer))

(defun erc-kill-all-buffers ()
  "Kill all erc-mode buffers. Useful to cleanup after an ERC
  session"
  (interactive)
  (let (final-list (list ))
    (dolist (buff (buffer-list) final-list)
      (if (equal 'erc-mode (with-current-buffer buff major-mode))
	  (setq final-list (append (list (buffer-name buff)) final-list))))
    (if final-list
	(if (y-or-n-p "Kill all ERC buffers? ")
	    (dolist (buff final-list nil)
	      (kill-buffer buff)))
      (message "No ERC buffers to kill"))))

(defun remote-ansi-term (new-buffer-name cmd &rest switches)
  "Open a remote terminal"
  (setq term-ansi-buffer-name (concat "*" new-buffer-name "*"))
  (setq term-ansi-buffer-name (generate-new-buffer-name term-ansi-buffer-name))
  (setq term-ansi-buffer-name (apply 'make-term term-ansi-buffer-name cmd nil switches))
  (set-buffer term-ansi-buffer-name)
  (term-mode)
  (term-char-mode)
  (term-set-escape-char ?\C-x)
  (switch-to-buffer term-ansi-buffer-name))
(defun remote-term (host)
  (interactive "sEnter hostname: ")
  (remote-ansi-term (concat host "-shell") "ssh" host))

(defun close-all-buffers ()
  (interactive)
  (mapc 'kill-buffer (buffer-list)))

(defun rename-file-and-buffer ()
  "Rename the current buffer and file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
	(message "Buffer is not visiting a file!")
      (let ((new-name (read-file-name "New name: " filename)))
	(cond
	 ((vc-backend filename) (vc-rename-file filename new-name))
	 (t
	  (rename-file filename new-name t)
	  (set-visited-file-name new-name t t)))))))
(global-set-key (kbd "C-c r") 'rename-file-and-buffer)

;; Compile bury buffer if no errors or warnings
(defun bury-compile-buffer-if-successful (buffer string)
  "Bury a compilation buffer if succeeded without warnings "
  (if (and
       (string-match "compilation" (buffer-name buffer))
       (string-match "finished" string)
       (not
        (with-current-buffer buffer
          (goto-char 1)
          (search-forward "warning" nil t))))
      (run-with-timer 1 nil
                      (lambda (buf)
                        (bury-buffer buf)
			(delete-windows-on buf))
                      buffer)))
(add-hook 'compilation-finish-functions 'bury-compile-buffer-if-successful)

;; play web video
(defun mplayer-url ()
  (interactive)
  (shell-command-on-region (point) (mark) "smplayer" nil t))





;;; Libraries ++++++++++++++++++++++++++++++++++++++++++++++++++

(use-package exwm
  :ensure t
  :config
  (require 'exwm-config)
  (exwm-config-default)
  (require 'exwm-systemtray)
  (exwm-systemtray-enable)
  (setq exwm-systemtray-height 16)
  (setq exwm-input-simulation-keys
        '(([?\C-x?\C-s] . [?\C-s])
          ([?\C-c?\C-p] . [?\C-p])
          ([?\C-s] . [?\C-f])
          ([?\M-w] . [?\C-c])
          ([?\C-y] . [?\C-v])
          ([?\C-b] . [left])
          ;([?\C-M-b] . [?\M-left])
          ([?\C-f] . [right])
          ;([?\C-M-b] . [?\M-right])
          ([?\C-p] . [up])
          ([?\C-n] . [down])
          ([?\C-a] . [home])
          ([?\C-e] . [end])
          ([?\M-v] . [prior])
          ([?\C-v] . [next])
          ([?\C-d] . [delete])
          ([?\C-k] . [S-end delete])))
  (setq exwm-workspace-number 4)
  (add-hook 'exwm-update-class-hook
            (lambda ()
              (unless (or (string-prefix-p "sun-awt-X11-" exwm-instance-name)
                          (string= "gimp" exwm-instance-name))
                (exwm-workspace-rename-buffer exwm-class-name))))
  (add-hook 'exwm-update-title-hook
            (lambda ()
              (when (or (not exwm-instance-name)
                        (string-prefix-p "sun-awt-X11-" exwm-instance-name)
                        (string= "gimp" exwm-instance-name))
                (exwm-workspace-rename-buffer exwm-title))))
  (setq exwm-input-global-keys
        `(([?\s-r] . exwm-reset)
          ([?\s-w] . exwm-workspace-switch)
          ,@(mapcar (lambda (i)
                      `(,(kbd (format "s-%d" i)) .
                        (lambda ()
                          (interactive)
                          (exwm-workspace-switch-create ,i))))
                    (number-sequence 0 9))
          ([?\s-&] . (lambda (command)
		       (interactive (list (read-shell-command "$ ")))
		       (start-process-shell-command command nil command)))
          ([s-f2] . (lambda ()
		      (interactive)
		      (start-process "" nil "/usr/bin/slock"))))))

(use-package slime
  :commands slime
  :init
  (load (expand-file-name "~/documents/code/lisp/slime-helper.el"))
  (setq inferior-lisp-program "sbcl"))

(use-package clojure-mode
  :ensure t)

(use-package cider
  :ensure t)

(use-package solarized-theme
  :ensure t
  :load-path "themes"
  :config
  (load-theme 'solarized-dark))

(use-package spaceline
  :ensure t
  :config
  (require 'spaceline-config)
  (setq powerline-default-seperator 'arrow)
  (spaceline-spacemacs-theme))

(use-package ghc
  :ensure t
  :config
  (add-hook 'haskell-mode-hook 'turn-on-haskell-indent))

(use-package paredit
  :ensure t
  :config
  (defun turn-on-paredit () (paredit-mode t))
  (add-hook 'clojure-mode-hook 'turn-on-paredit)
  (add-hook 'lisp-mode-hook 'turn-on-paredit)
  (add-hook 'emacs-lisp-mode-hook 'turn-on-paredit))

(use-package magit
  :ensure t
  :config
  (global-set-key (kbd "C-c g") 'magit-status)
  (setq magit-last-seen-setup-instructions "1.4.0"))


(use-package auto-complete
  :ensure t
  :init
  (ac-config-default)
  (global-auto-complete-mode t)
  :config
  (add-to-list 'ac-sources 'ac-source-filename)
  (defun my:ac-c-header-init ()
    (require 'auto-complete-c-headers)
    (add-to-list 'ac-sources 'ac-source-c-headers)
    (add-to-list 'ac-sources 'ac-source-filename))
  (add-hook 'c-common-mode-hook 'my:ac-c-header-init))


(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1)
  (add-hook 'org-mode 'yas-minor-mode))


(use-package erc
  :ensure t
  :config
  ;; (erc-autojoin-mode t)
  ;; (setq erc-autojoin-channels-alist
  ;;       '((".*\\.freenode.net" "#emacs" "#archlinux")))
  (erc-track-mode t)
  (setq erc-track-exclude-types '("JOIN" "PART" "QUIT" "NICK"))
  (setq erc-hide-list '("JOIN" "PART" "QUIT" "NICK"))
  (add-hook 'erc-mode-hook 'my-erc-mode-hook)
  (defun my-erc-mode-hook ()
    (set (make-local-variable 'scroll-conservatively) 101)
  (set (make-local-variable 'scroll-step) 1)))


(use-package helm
  :ensure t
  :bind (("M-x" . helm-M-x)
         ("C-x b" . helm-buffers-list)
         ("C-x r b" . helm-bookmarks)
         ("M-x" . helm-M-x)
         ("C-c C-f" . helm-for-files)
         ("C-x f" . helm-for-files)
         ("C-c i" . helm-imenu)
         ("C-h a" . helm-apropos)))

(use-package org
  :config
  (setq org-directory "~/notes")
  ;;(plist-put org-format-latex-options :scale 1.5)
  (global-set-key "\C-ca" 'org-agenda)
  (setq org-agenda-custom-commands
        '(("A" "Month long agenda view."
	   ((agenda "" ((org-agenda-ndays 31)))
	    ))))
  (setq org-export-html-postamble nil)
  (require 'org-crypt)
  (org-crypt-use-before-save-magic)
  (setq org-tags-exclude-from-inheritance (quote ("crypt")))
  (setq org-crypt-key nil)
  (setq org-confirm-babel-evaluate nil)
  ;; (org-babel-do-load-languages
  ;;  'org-babel-load-languages
  ;;  '((gnuplot . t)
  ;;    (sh . t)))
  (defun org-gnuplot-refresh-images ()
    (org-ctrl-c-ctrl-c))
  (add-hook 'org-mode-hook
	    (lambda ()
	      (local-set-key (kbd "C-c C-x p") 'org-plot/gnuplot)
	      (local-set-key (kbd "C-c C-x v") 'org-gnuplot-refresh-images)
	      (visual-line-mode)
	      (flyspell-mode))))


;; javadoc-lookup
;; (add-to-list 'load-path "~/.emacs.d/elpa/javadoc-lookup-20130618.1736/")
;; (require 'javadoc-lookup)
;; (javadoc-add-roots "/usr/share/doc/openjdk7-doc/api")

;; JDEE
;;(setq jdee-server-dir "~/.emacs.d/jdee-server/target/")

;; (add-hook 'doc-view-mode-hook 'auto-revert-mode)
;; (defadvice doc-view-display (after fit-width activate)
;;   (doc-view-fit-height-to-window))

;; eclim
;; (require 'eclim)
;; (require 'eclimd)
;; (require 'ac-emacs-eclim-source)
;; (setq eclim-auto-save t
;;       eclim-executable (or (executable-find "eclim") "/usr/lib/eclipse/eclim")
;;       eclimd-executable (or (executable-find "eclimd") "/usr/lib/eclipse/eclimd")
;;       eclimd-wait-for-process nil
;;       eclimd-default-workspace "~/documents/code/java/eclim/"
;;       help-at-pt-display-when-idle t
;;       help-at-pt-timer-delay 0.1)
;; (ac-emacs-eclim-config)
;; (add-hook 'java-mode-hook
;;           (lambda ()
;;             (add-to-list 'ac-sources 'ac-source-emacs-eclim)))
;; (add-hook 'eclim-mode-hook
;;           (lambda ()
;;             (local-set-key (kbd "C-c C-e c") 'eclim-project-build)
;; 	    (local-set-key (kbd "C-c C-e e") 'eclim-problems-compilation-buffer)))


;; w3m Config
;; (require 'w3m-load)
;; (require 'w3m)
;; (require 'w3m-image)
;; (require 'w3m-session)
;; (require 'w3m-lnum)
;; (require 'mime-w3m)

;; (setq browse-url-browser-function 'browse-url-firefox)
;; (setq browse-url-new-window-flag t)
;; (setq w3m-home-page "http://www.google.com")

;; (setq w3m-session-file "~/.emacs.d/w3m-session")
;; (setq w3m-session-save-always nil)
;; (setq w3m-session-load-always nil)
;; (setq w3m-session-show-titles t)
;; (setq w3m-session-duplicate-tabs 'ask)

;; (define-key w3m-mode-map "f" 'w3m-lnum-goto)


;; (defun w3m-yt-view ()
;;   "View a YouTube link with youtube-dl and mplayer."
;;   (interactive)
;;   (let ((url (or (w3m-anchor) (w3m-image))))
;;     (string-match "[^v]*v.\\([^&]*\\)" url)
;;     (let* ((vid (match-string 1 url))
;;            (out (format "%s/%s.mp4" w3m-default-save-directory vid)))
;;       (call-process "youtube-dl" nil nil nil "-U" "-q" "-c" "-o" out url)
;;       (start-process "mplayer" nil "mplayer" "-quiet" out))))

;; sunrise commander
;; (if (file-exists-p "~/.emacs.d/sunrise-commander.el")
;;     (load "~/.emacs.d/sunrise-commander.el"))
;; (setq dired-omit-files "^\\.[^.]")
;; (if (file-exists-p "~/.emacs.d/sunrise-loop.el")
;;     (load "~/.emacs.d/sunrise-loop.el"))
;; (defun oggz:dired-rsync (dest)
;;   (interactive
;;    ;; offer dwim target as the suggestion
;;    (list (expand-file-name (read-file-name "Rsync to:" (dired-dwim-target-directory)))))
;;   ;; store all selected files into "files" list
;;   (let ((files (dired-get-marked-files nil current-prefix-arg)))
;;     ;; the rsync command
;;     (setq tmtxt/rsync-command "rsync -arvz --progress ")
;;     ;; add all selected file names as arguments to the rsync command
;;     (dolist (file files)
;;       (setq tmtxt/rsync-command
;; 	    (concat tmtxt/rsync-command
;; 		    (shell-quote-argument file)
;; 		    " ")))
;;     ;; append the destination
;;     (setq tmtxt/rsync-command
;; 	  (concat tmtxt/rsync-command
;; 		  (shell-quote-argument 
;; 		   (replace-regexp-in-string (regexp-quote "/ssh:") "" dest))))
;;     ;; run the async shell command
;;     (async-shell-command tmtxt/rsync-command "*rsync*")
;;     ;; finally, switch to that window
;;     (other-window 1)))


;; cedet
;; (require 'semantic/ia)
;; (require 'semantic/db)
;; (require 'semantic/bovine/gcc)
;; (global-semantic-idle-scheduler-mode 1)
;; (global-semanticdb-minor-mode 1)
;; (global-semantic-mru-bookmark-mode 1)
;; (global-semantic-decoration-mode 1)
;; (semantic-mode 1)
;; (add-hook 'c-mode-common-hook
;; 	  '(lambda ()
;; 	     (add-to-list 'ac-sources 'ac-source-semantic)
;; 	     (local-set-key "\C-c?" 'semantic-ia-complete-symbol-menu)
;; 	     (local-set-key "\C-cj" 'semantic-ia-fast-jump)))
;; (setq semanticdb-project-roots (list (expand-file-name "~/documents/code/")))


;; mu4e
;;(add-to-list 'load-path "~/.emacs.d/mu4e")
;; (if (file-exists-p "~/.emacs.d/mu4e.el")
;;     (load "~/.emacs.d/mu4e.el"))

;; elpy
;(elpy-enable)
;(elpy-use-ipython)

;;; End External Modules --------------------------------------------------
