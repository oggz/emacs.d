(require 'mu4e)
(require 'smtpmail)
(require 'org-mu4e)

;; Settings
(setq mu4e-maildir "~/.mail"
      mu4e-update-interval 300
      mu4e-headers-skip-duplicates t
      mu4e-sent-messages-behavior 'delete
      ;; mu4e-get-mail-command "imap.sh"
      mu4e-get-mail-command "mbsync -a"
      mu4e-compose-signature-auto-include t
      mu4e-view-show-addresses t
      mu4e-view-show-images nil
      mu4e-view-prefer-html nil
      mu4e-compose-format-flowed t
      mu4e-compose-keep-self-cc nil
      ;mu4e-html2text-command "html2text"
      ;mu4e-html2text-command "w3m -T text/html"
      message-send-mail-function 'smtpmail-send-it
      message-kill-buffer-on-exit t
      org-mu4e-convert-to-html nil)

;; Initial account info
(setq user-mail-address "adoccolo@gmail.com"
      user-full-name "Alex Doccolo"
      mu4e-compose-signature (concat "Alexadner A. Doccolo\n" "")
      mu4e-drafts-folder "/adoccolo/drafts"
      mu4e-trash-folder "/adoccolo/trash"
      mu4e-sent-folder "/adoccolo/sent"
      smtpmail-smtp-user "adoccolo@gmail.com"
      smtpmail-stream-type 'starttls
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587)

;; Account specific settings
(setq mu4e-trash-folder
      (lambda (msg)
	(if (and msg
		 (mu4e-message-contact-field-matches msg :to "aldoc001@mail.goucher.edu"))
	    "/school/[Gmail].Trash"
	    "/main/[Gmail].Trash")))

(defvar my-mu4e-account-alist
  '(("adoccolo"
     (user-mail-address "adoccolo@gmail.com")
     (user-full-name "Alex Doccolo")
     (mu4e-compose-signature (concat "Alexander A. Doccolo\n" ""))
     (mu4e-drafts-folder "/adoccolo/drafts")
     (mu4e-trash-folder "/adoccolo/trash")
     (mu4e-sent-folder "/adoccolo/sent")
     (smtpmail-smtp-user "adoccolo@gmail.com")
     (smtpmail-stream-type starttls)
     (smtpmail-default-smtp-server "smtp.gmail.com")
     (smtpmail-smtp-server "smtp.gmail.com")
     (smtpmail-smtp-service 587))
    ("aldoc001"
     (user-mail-address "aldoc001@mail.goucher.edu")
     (user-full-name "Alex Doccolo")
     (mu4e-compose-signature (concat "Alexander A. Doccolo\n" ""))
     (mu4e-drafts-folder "/aldoc001/drafts")
     (mu4e-trash-folder "/aldoc001/trash")
     (mu4e-sent-folder "/aldoc001/sent")
     (smtpmail-smtp-user "aldoc001@mail.goucher.edu")
     (smtpmail-stream-type starttls)
     (smtpmail-default-smtp-server "smtp.gmail.com")
     (smtpmail-smtp-server "smtp.gmail.com")
     (smtpmail-smtp-service 587))
    ("alex.doccolo"
     (user-mail-address "alex.doccolo@gmail.com")
     (user-full-name "Alex Doccolo")
     (mu4e-compose-signature (concat "Alexander A. Doccolo\n" ""))
     (mu4e-drafts-folder "/alex.doccolo/drafts")
     (mu4e-trash-folder "/alex.doccolo/trash")
     (mu4e-sent-folder "/alex.doccolo/sent")
     (smtpmail-smtp-user "alex.doccolo@gmail.com")
     (smtpmail-stream-type starttls)
     (smtpmail-default-smtp-server "smtp.gmail.com")
     (smtpmail-smtp-server "smtp.gmail.com")
     (smtpmail-smtp-service 587))))

;; Shortcuts
(setq mu4e-maildir-shortcuts
      '(("/adoccolo/all" . ?a)
	("/adoccolo/sent" . ?s)
	("/adoccolo/drafts" . ?d)
	("/adoccolo/junk" . ?j)
        ("/aldoc001/all" . ?A)
	("/aldoc001/sent" . ?S)
	("/aldoc001/drafts" . ?D)
	("/aldoc001/junk" . ?T)))
;; Type aV when viewing difficult messages to open them in the default web browser.
(add-to-list 'mu4e-view-actions
	     '("browser" . mu4e-action-view-in-browser) t)

;; Bookmarks
(setq mu4e-bookmarks
      '(("flag:unread AND NOT flag:trashed" "Unread messages" ?u)
	("date:today..now AND NOT flag:trashed" "Today's messages" ?t)
	("date:1d..today AND NOT flag:trashed" "Yesterday's messages" ?y)
	("date:7d..now AND NOT flag:trashed" "Last 7 days" ?w)
	("date:31d..now AND NOT flag:trashed" "Last 31 days" ?m)))

(defun my-mu4e-set-account ()
  "Set the account for composing a message."
  (let* ((account
	  (if mu4e-compose-parent-message
	      (let ((maildir (mu4e-message-field mu4e-compose-parent-message :maildir)))
		(string-match "/\\(.*?\\)/" maildir)
		(match-string 1 maildir))
	    (completing-read (format "Compose with account: (%s) "
				     (mapconcat #'(lambda (var) (car var)) my-mu4e-account-alist "/"))
			     (mapcar #'(lambda (var) (car var)) my-mu4e-account-alist)
			     nil t nil nil (caar my-mu4e-account-alist))))
	 (account-vars (cdr (assoc account my-mu4e-account-alist))))
    (if account-vars
	(mapc #'(lambda (var)
		  (set (car var) (cadr var)))
	      account-vars)
      (error "No email account found"))))
(add-hook 'mu4e-compose-pre-hook 'my-mu4e-set-account)
(add-hook 'mu4e-compose-mode-hook (defun mu4e-compose-settings ()
				   "Set modes and local settinggs for composing mail with mu4e."
				   (auto-fill-mode)
				   (visual-line-mode)
				   (flyspell-mode)))
(add-hook 'mu4e-view-mode-hook (defun mu4e-compose-settings ()
				 "Set modes and local settinggs for composing mail with mu4e."
				 (visual-line-mode)
				 (flyspell-mode)))
