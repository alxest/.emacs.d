
;(require-package 'misc)
(defun forward-to-word (arg)
  "Move forward until encountering the beginning of a word.
With argument, do this that many times."
  (interactive "^p")
  (or (re-search-forward (if (> arg 0) "\\W\\b" "\\b\\W") nil t arg)
      (goto-char (if (> arg 0) (point-max) (point-min)))))
(global-set-key (kbd "M-f") 'forward-to-word)
(global-set-key (kbd "C-c C-;") 'comment-or-uncomment-region)
(global-set-key "\C-t" 'previous-line)
(global-set-key "\M-k" '(lambda () (interactive) (kill-line 0))) 
(global-set-key (kbd "C-x k") 'kill-buffer-and-window)
(global-set-key "\C-x\C-k" 'kill-this-buffer)
(blink-cursor-mode 0)
(global-set-key "\C-w" 'clipboard-kill-region)
(global-set-key "\M-w" 'clipboard-kill-ring-save)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq scroll-conservatively 101)
(global-set-key (kbd "C-@") '(lambda () (interactive) (setq prefix-arg '0)))
(desktop-save-mode 1)
(global-linum-mode t)

(require 'hi-lock)
(global-set-key (kbd "C-x w p") 'highlight-phrase)
(require-package 'dictionary)
(global-set-key (kbd "C-c d") 'dictionary-search)
(global-set-key (kbd "M-}") 'other-window)
(global-set-key (kbd "M-{") '(lambda () (interactive) (other-window -1)))
(global-set-key (kbd "C-M-}") 'other-frame)
(global-set-key (kbd "C-M-{") '(lambda () (interactive) (other-frame -1)))
(global-set-key (kbd "M-`") 'other-frame)

(require-package 'undo-tree)
(global-undo-tree-mode 1)


(require-package 'bm)
(global-set-key (kbd "C-S-b t") 'bm-toggle)
(global-set-key (kbd "C-S-b n") 'bm-next)
(global-set-key (kbd "C-S-b p") 'bm-previous)


;;http://emacsredux.com/blog/2013/04/01/highlight-matching-parentheses/
(require-package 'paren)
(setq show-paren-style 'parenthesis)
(show-paren-mode t)
(setq show-paren-delay 0)

(setq isearch-lazy-highlight-initial-delay 0)


(setq lazy-highlight-cleanup nil)
(setq global-visual-line-mode t)
(provide 'alxest-misc)

(global-set-key (kbd "C-x C-b") 'ibuffer)

;http://emacswiki.org/emacs/AutoIndentation
;; (define-key global-map (kbd "RET") 'newline-and-indent)
(define-key global-map (kbd "<RET>") 'evil-ret-and-indent)

(define-key grep-mode-map (kbd "h") nil)

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)



;http://stackoverflow.com/questions/9435019/how-do-i-source-my-zshrc-within-emacs
;; (let ((path (shell-command-to-string ". ~/.zshrc; echo -n $PATH")))
;;   (setenv "PATH" path)
;;   (setq exec-path 
;;         (append
;;          (split-string-and-unquote path ":")
;;          exec-path)))
(require-package 'exec-path-from-shell)
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(require-package 'solarized-theme)
(load-theme 'solarized-light t)
