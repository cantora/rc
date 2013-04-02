(setq auto-mode-alist (cons '("\\..*$" . fundamental-mode) auto-mode-alist))

;; Don't make me type out 'yes' and 'no'
(fset 'yes-or-no-p 'y-or-n-p)

;; Show column number at bottom of screen
(column-number-mode 1)

(menu-bar-mode (if window-system 1 -1))

(setq change-major-mode-with-file-name nil)
(setq search-highlight           t) ; Highlight search object
(setq query-replace-highlight    t) ; Highlight query object
(setq mouse-sel-retain-highlight t) ; Keep mouse high-lightening



;;(setq-default indent-tabs-mode 1)
;;(setq-default default-tab-width 4)
(setq-default tab-width 4)
(global-set-key (kbd "TAB") 'self-insert-command)


(defun indent-region-with-tab ()
  (interactive)
  (save-excursion
	(if (< (point) (mark)) (exchange-point-and-mark))
	(let ((save-mark (mark)))
	    (if (= (point) (line-beginning-position)) (previous-line 1))
		  (goto-char (line-beginning-position))
		    (while (>= (point) save-mark)
			  (goto-char (line-beginning-position))
			  (insert "\t")
			  (previous-line 1)))))

			  

(global-set-key [?\C-x ?\t] 'indent-region-with-tab)  

				
(defun kill-leading-space-region ()
  (interactive)
  (save-excursion
	(if (< (point) (mark)) (exchange-point-and-mark))
	(let ((save-mark (mark)))
	    (if (= (point) (line-beginning-position)) (previous-line 1))
		  (goto-char (line-beginning-position))
		    (while (>= (point) save-mark)
			  (goto-char (line-beginning-position))
			  (delete-horizontal-space)
			  (previous-line 1)))))

(global-set-key (read-kbd-macro "ESC C-\\") 'kill-leading-space-region)

(defun unindent-region-with-tab ()
  (interactive)
  (save-excursion
	(if (< (point) (mark)) (exchange-point-and-mark))
	(let ((save-mark (mark)))
	    (if (= (point) (line-beginning-position)) (previous-line 1))
		  (goto-char (line-beginning-position))
		    (while (>= (point) save-mark)
			  (goto-char (line-beginning-position))
			  (if (= (string-to-char "\t") (char-after (point))) (delete-char 1))
			  (previous-line 1)))))

(global-set-key [?\C-\\] 'unindent-region-with-tab)  


(defconst use-backup-dir t)   
(setq backup-directory-alist (quote ((".*" . "~/.emacs_backup/")))
      version-control t                ; Use version numbers for backups
      kept-new-versions 16             ; Number of newest versions to keep
      kept-old-versions 2              ; Number of oldest versions to keep
      delete-old-versions t            ; Ask to delete excess backup versions?
      backup-by-copying-when-linked t) ; Copy linked files, don't rename.


;; Translate C-h to DEL
(keyboard-translate ?\C-h ?\C-?)



