(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-engine (quote luatex))
 '(TeX-view-program-selection
   (quote
    (((output-dvi style-pstricks)
      "dvips and gv")
     (output-dvi "xdvi")
     (output-pdf "Evince")
     (output-html "xdg-open"))))
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["black" "red" "green" "yellow" "cyan" "magenta" "cyan" "white"])
 '(auto-revert-interval 1.5)
 '(auto-save-default nil)
 '(background-mode light)
 '(cider-cljs-lein-repl
   "(do (require 'figwheel-sidecar.repl-api) (figwheel-sidecar.repl-api/start-figwheel!) (figwheel-sidecar.repl-api/cljs-repl))")
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" default)))
 '(erc-input-line-position nil)
 '(erc-modules
   (quote
    (autojoin button completion fill irccontrols list match menu move-to-prompt netsplit networks noncommands readonly ring scrolltobottom stamp track)))
 '(helm-external-programs-associations (quote (("pdf" . "evince"))))
 '(inhibit-startup-screen t)
 '(make-backup-files nil)
 '(org-agenda-files
   (quote
    ("~/notes/misc.org" "~/notes/school.org" "~/notes/billing.org")))
 '(org-confirm-babel-evaluate nil)
 '(org-crypt-key nil)
 '(org-directory "~/notes")
 '(org-export-babel-evaluate nil)
 '(org-export-use-babel nil)
 '(org-export-with-sub-superscripts (quote {}))
 '(org-file-apps
   (quote
    ((auto-mode . emacs)
     ("\\.mm\\'" . default)
     ("\\.x?html?\\'" . default)
     ("\\.pdf\\'" . "evince %s"))))
 '(org-format-latex-options
   (quote
    (:foreground default :background default :scale 2.0 :html-foreground "White" :html-background "Transparent" :html-scale 2.0 :matchers
                 ("begin" "$1" "$" "$$" "\\(" "\\["))))
 '(org-from-is-user-regexp nil)
 '(org-table-copy-increment t)
 '(package-selected-packages
   (quote
    (solarized-theme exwm yasnippet auto-complete org-plus-contrib spaceline use-package helm dired-rsync paredit gnuplot cider undo-tree clojure-mode anaconda-mode doremi elpy lua-mode window-margin request rainbow-delimiters pretty-lambdada magit lorem-ipsum javadoc-lookup httpd htmlize gist ghc elnode color-theme-solarized cmake-mode cdlatex auto-complete-c-headers auctex arduino-mode)))
 '(safe-local-variable-values
   (quote
    ((require-final-newline)
     (emacs-lisp-docstring-fill-column . 75))))
 '(solarized-terminal-themed t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-selection ((t (:background "dark slate gray" :foreground "white" :underline t))))
 '(org-agenda-structure ((t nil)))
 '(term-color-blue ((t (:background "blue2" :foreground "deep sky blue")))))
