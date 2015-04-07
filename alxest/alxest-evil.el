(require-package 'evil)
(evil-mode 1)
(global-set-key "\M-d" 'evil-scroll-up)
(global-set-key "\C-u" 'evil-scroll-up)

(global-set-key "\C-x\C-n" 'next-buffer)
(global-set-key "\C-x\C-p" 'previous-buffer)

(define-key evil-normal-state-map (kbd "<escape>") 'evil-end-of-line)
(define-key evil-normal-state-map (kbd "&") 'evil-end-of-line)

;; (evil-define-operator evil-insert (beg end type char)
;;   "Replace text from BEG to END with CHAR."
;;   :motion evil-forward-char
;;   (interactive "<R>"
;;                (evil-save-cursor
;;                  (evil-refresh-cursor 'replace)
;;                  (list (evil-read-key))))
;;   (when char
;;     (if (eq type 'block)
;;         (save-excursion
;;           (evil-apply-on-rectangle
;;            #'(lambda (begcol endcol char)
;;                (let ((maxcol (evil-column (line-end-position))))
;;                  (when (< begcol maxcol)
;;                    (setq endcol (min endcol maxcol))
;;                    (let ((beg (evil-move-to-column begcol nil t))
;;                          (end (evil-move-to-column endcol nil t)))
;;                      (delete-region beg end)
;;                      (insert (make-string (- endcol begcol) char))))))
;;            beg end char))
;;       (goto-char beg)
;;       (cond
;;        ((eq char ?\n)
;;         (delete-region beg end)
;;         (newline)
;;         (when evil-auto-indent
;;           (indent-according-to-mode)))
;;        (t
;;         (while (< (point) end)
;;           (if (eq (char-after) ?\n)
;;               (forward-char)
;;             (delete-char 1)
;;             (insert-char char 1)))
;;         (goto-char (max beg (1- end))))))))

(define-key evil-normal-state-map (kbd "SPC") 'evil-end-of-line)


;; (my-move-key evil-motion-state-map evil-normal-state-map (kbd "RET"))
;; (my-move-key evil-motion-state-map evil-normal-state-map " ")

;http://www.emacswiki.org/emacs/Evil#toc13
(define-key evil-normal-state-map "c" nil)
(define-key evil-motion-state-map "cu" 'universal-argument)
(define-key key-translation-map (kbd "ch") (kbd "C-h"))
(define-key key-translation-map (kbd "cu") (kbd "C-x"))
(define-key key-translation-map (kbd "cb") (kbd "C-b"))
;(define-key evil-normal-state-map "c" nil)

;https://github.com/GriffinSchneider/emacs-config/blob/master/evil-mode-customizations.el
(evil-global-set-key 'insert (kbd "<RET>") 'evil-ret-and-indent)


(provide 'alxest-evil)
