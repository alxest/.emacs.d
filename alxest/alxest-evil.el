(require-package 'evil)
(evil-mode 1)
(global-set-key "\M-d" 'evil-scroll-up)
(global-set-key "\C-u" 'evil-scroll-up)

(global-set-key "\C-x\C-n" 'next-buffer)
(global-set-key "\C-x\C-p" 'previous-buffer)

;It originally hided all other key bindings, including scala-mode, company-coq-mode, etc.
;Setting it nil will make other bindings work, it was originally some command that I do not use.
(define-key evil-normal-state-map (kbd "M-.") nil)

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
;; (define-key key-translation-map (kbd "ch") (kbd "C-h"))
;; (define-key key-translation-map (kbd "cu") (kbd "C-x"))
;; (define-key key-translation-map (kbd "cb") (kbd "C-b"))


(define-key key-translation-map (kbd "ca") (kbd "C-a"))
(define-key key-translation-map (kbd "cb") (kbd "C-b"))
(define-key key-translation-map (kbd "cc") (kbd "C-c"))
(define-key key-translation-map (kbd "cd") (kbd "C-d"))
(define-key key-translation-map (kbd "ce") (kbd "C-e"))
(define-key key-translation-map (kbd "cf") (kbd "C-f"))
(define-key key-translation-map (kbd "cg") (kbd "C-g"))
(define-key key-translation-map (kbd "ch") (kbd "C-h"))
(define-key key-translation-map (kbd "ci") (kbd "C-i"))
(define-key key-translation-map (kbd "cj") (kbd "C-j"))
(define-key key-translation-map (kbd "ck") (kbd "C-k"))
(define-key key-translation-map (kbd "cl") (kbd "C-l"))
(define-key key-translation-map (kbd "cm") (kbd "C-m"))
(define-key key-translation-map (kbd "cn") (kbd "C-n"))
(define-key key-translation-map (kbd "co") (kbd "C-o"))
(define-key key-translation-map (kbd "cp") (kbd "C-p"))
(define-key key-translation-map (kbd "cq") (kbd "C-q"))
(define-key key-translation-map (kbd "cr") (kbd "C-r"))
(define-key key-translation-map (kbd "cs") (kbd "C-s"))
(define-key key-translation-map (kbd "ct") (kbd "C-t"))
(define-key key-translation-map (kbd "cu") (kbd "C-x"))
(define-key key-translation-map (kbd "cv") (kbd "C-v"))
(define-key key-translation-map (kbd "cw") (kbd "C-w"))
(define-key key-translation-map (kbd "cu") (kbd "C-x"))
(define-key key-translation-map (kbd "cy") (kbd "C-y"))
(define-key key-translation-map (kbd "cz") (kbd "C-z"))

(define-key key-translation-map (kbd "c;") (kbd "C-;"))
(define-key key-translation-map (kbd "c,") (kbd "C-,"))
(define-key key-translation-map (kbd "c.") (kbd "C-."))
(define-key key-translation-map (kbd "c{") (kbd "C-{"))
(define-key key-translation-map (kbd "c}") (kbd "C-}"))

;(define-key evil-normal-state-map "c" nil)

;https://github.com/GriffinSchneider/emacs-config/blob/master/evil-mode-customizations.el
;; (evil-global-set-key 'insert (kbd "<RET>") 'evil-ret-and-indent)
;; Problem: it sets globally, including eshell-mode
;; google "evil-mode eshell ret" -> https://github.com/asok/.emacs.d/blob/master/inits/init-evil.el

;; THIS IS THE ANSWER: https://github.com/syl20bnr/spacemacs/issues/6662
(evil-define-key 'insert evil-insert-state-map (kbd "RET") #'evil-ret-and-indent)
;; (define-key evil-insert-state-map (kbd "<RET>") 'evil-ret-and-indent)
(evil-define-key `insert eshell-mode-map (kbd "RET") 'nil)
;; (define-key eshell-mode-map (kbd "<RET>") `eshell-send-input)
;; (eval-after-load "eshell"
;;   `(evil-define-key `insert eshell-mode-map (kbd "RET") 'nil))

(define-key evil-normal-state-map "C" nil)

;for coq bindings. coq bindings did not override those bindings and this is a detour
(define-key evil-normal-state-map (kbd "C-p") 'nil)
(define-key evil-normal-state-map (kbd "C-a") 'nil)
(define-key evil-motion-state-map (kbd "C-b") 'nil)
;; (define-key evil-normal-state-map (kbd "C-j") 'nil)
;; (define-key evil-normal-state-map (kbd "C-k") 'nil)

(define-key evil-motion-state-map (kbd "C-z") 'nil)
(define-key evil-normal-state-map (kbd "C-n") 'nil)
(define-key evil-motion-state-map (kbd "C-e") 'nil)
;; C-h v evil map -> found normal-state-map, motion-state-map, etc. checked each value and found where "evil-paste-pop-next" was bound. Not motion-state-map, but normal-state-map.
(global-set-key "\C-z" 'nil)

(require 'highlight)
(require-package 'evil-search-highlight-persist)
(global-evil-search-highlight-persist t)

;(require-package 'evil-search-highlight-persist)
;(evil-search-highlight-persist)

(provide 'alxest-evil)
