(message "[+] .emacs init")

;; (setq auto-mode-alist (cons '("\\..*$" . fundamental-mode) auto-mode-alist))

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
(global-set-key (kbd "RET") 'electric-newline-and-maybe-indent)

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
;; (keyboard-translate ?\C-h ?\C-?)
(global-set-key [(control h)] 'delete-backward-char)

;; org mode options
(setq org-startup-indent t)

(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

(defun monopaste-push-buffer ()
  (call-process-region
    1
    (point-max)
    "monopaste"
    nil
    nil
    nil
    "push"
    "--no-strip"))

(defun monopaste-push-string (string)
  (with-temp-buffer
    (progn
      (insert string)
      (monopaste-push-buffer))))

(setq interprogram-cut-function 'monopaste-push-string)

(defun monopaste-buffer-n (n)
  (shell-command-to-string
    (format "monopaste buf -n %d" n)))

(defun monopaste-buffer-top () (monopaste-buffer-n 0))

(defun kill-ring-top ()
  (let ((krtop-props (nth 0 kill-ring-yank-pointer)))
    (if krtop-props (substring-no-properties krtop-props) "")))

(defun monopaste-buffer-top-non-emacs ()
  (let
    ( (krtop (kill-ring-top))
      (mptop (monopaste-buffer-top)))
    (if (not (string-equal krtop mptop)) mptop)))

(setq interprogram-paste-function 'monopaste-buffer-top-non-emacs)

(setq org-startup-indented t)
(dolist (hook '(adoc-mode-hook))
    (add-hook hook (lambda () (flyspell-mode 1))))

(require 'el-get)
(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-recipes")
(unless (file-directory-p el-get-dir)
        (make-directory el-get-dir t))
(setq el-get-allow-insecure nil)
(setq el-get-verbose t)
(el-get 'sync '(cantora-flx hiraishin cantora-visual-regexp))

(require 'visual-regexp)
(define-key global-map (kbd "M-%") 'vr/replace)
(define-key global-map (kbd "M-C-%") 'vr/query-replace)

(require 'ido)
(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

(require 'hiraishin)
(hiraishin-mode 1)

(message "[-] .emacs init")
