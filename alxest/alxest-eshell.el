(global-set-key (kbd "C-c C-z") 'alxest-eshell/new)
(global-set-key (kbd "C-}") 'alxest-eshell/next)
(global-set-key (kbd "C-{") 'alxest-eshell/prev)

(defvar alxest-eshell/buffer-list nil
		"List of eshell buffers.")

(defvar alxest-eshell/buffer-name "alxest-eshell"
		"Name of eshell buffer.")

(defvar alxest-eshell/default-dir "~/"
		"Name of eshell buffer.")

(defun alxest-eshell/new ()
  "Create new eshell buffer."
  (interactive)
  (let ((buffer-name (alxest-eshell/get-buffer-name))
	(buffer))
    (setq buffer (generate-new-buffer buffer-name))
    (setq alxest-eshell/buffer-list (nconc alxest-eshell/buffer-list (list buffer)))
    (pop-to-buffer-same-window buffer)
    (unless (eq major-mode 'eshell-mode)
      (eshell-mode))
    buffer))
;eshell doesn't take name as argument

(defun alxest-eshell/get-buffer-name ()
  (let ((index 1))
    (while (buffer-live-p (get-buffer (format "*%s[%s]*" alxest-eshell/buffer-name index)))
      (setq index (1+ index)))
    (cd (or default-directory (expand-file-name alxest-eshell/default-dir)))
    (format "*%s[%s]*" alxest-eshell/buffer-name index)))

(defun alxest-eshell/next (&optional offset)
  "Move next buffer. Takes Offset as an argument."
  (interactive)
  (setq offset (or offset 1))
  (unless
      (if alxest-eshell/buffer-list
	  (let ((len (length alxest-eshell/buffer-list))
		(cur (position (current-buffer) alxest-eshell/buffer-list)))
	    (if cur
		(switch-to-buffer (nth (mod (+ cur offset) len) alxest-eshell/buffer-list))
	      (switch-to-buffer (car alxest-eshell/buffer-list)))))
    (alxest-eshell/new)))

(defun alxest-eshell/prev (&optional offset)
		"Move to prev buffer. Takes Offset as an argument."
		(interactive)
		(setq offset (or offset 1))
		(alxest-eshell/next (- offset)))

(add-hook 'kill-buffer-hook 'alxest-eshell/kill-buffer-hook)	
(defun alxest-eshell/kill-buffer-hook ()
  (when (eq major-mode 'eshell-mode)
    (let ((killed-buffer (current-buffer)))
      (setq alxest-eshell/buffer-list
												(delq killed-buffer alxest-eshell/buffer-list)))))

;; (eval-after-load "eshell"
;;     '(define-key evil-insert-state-map (kbd "RET") 'nil))
;; Problem: It changes globally

(provide 'alxest-eshell)


;; (() () ())


;; (defun
;;   fold
;;   (f x li)
;;   "Applies (f x ele) recursively to the list li "
;;   (let
;;     (
;;       (li2 li)
;;       (ele)
;;       (x2 x)
;;     )
;;     (while
;;       (setq ele (pop li2))
;;       (setq x2 (funcall f x2 ele))
;;     )
;;     x2
;;   )
;; )

;; (if t 1 2)
;; (if nil 1 2)
;; (if . (t . (1 . (2 . nil))))
;; (if . (nil . (1 . (2 . nil))))

;; (1 . (2 . (3 . nil)))
;; (1 2 3)
;; (push-mark
;; 	  (save-excursion
;; 	    (forward-sexp (prefix-numeric-value 1))
;; 	    (point))
;; 	  nil t)

;; (push-mark
;; 	(save-excursion
;; 		(next-line 5)) t t)
;; (set-mark
;; 	(next-line 5))
;; (set-mark
;; 	(save-excursion
;; 			(next-line -5)))
;; (end-of-defun)
;; (beginning-of-defun)

;; (generate-new-buffer "*alxest-eshell*")
;; (get-buffer-create "*alxest-eshell*")



(setq desktop-buffers-not-to-save "*eshell*")
(setq desktop-buffers-not-to-save nil)
;; (add-hook 'eshell-mode-hook #'company-mode)
;; (add-hook 'eshell-mode-hook
;;           (lambda ()
;;             (define-key eshell-mode-map (kbd "<f9>") #'emacs-version)))
;; (eval-after-load "eshell"
;;   '(define-key eshell-mode-map (kbd "TAB") #'company-complete))


(add-hook 'eshell-mode-hook (lambda () (helm-mode -1)))
(setq completion-auto-help nil)
(setq completion-cycle-threshold 5)
