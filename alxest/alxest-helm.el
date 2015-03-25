;helm
(require-package 'helm)
(require-package 'helm-projectile)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           nil ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)
(helm-mode 1)
(setq helm-split-window-default-side 'below)

(defun helm-split-window-default-fn (window)
  (let (split-width-threshold)
    (if (and (fboundp 'window-in-direction)
             ;; Don't try to split when starting in a minibuffer
             ;; e.g M-: and try to use helm-show-kill-ring.
             (not (minibufferp helm-current-buffer)))
        (split-window (frame-root-window (selected-window)) nil nil)
        ;(split-window (frame-root-window (selected-window)) nil (if (eq helm-splibt-window-default-side 'other) 'below helm-split-window-default-side))
        ;; (if (or (one-window-p t)
        ;;         helm-split-window-in-side-p)
        ;;     (split-window
        ;;      (selected-window) nil (if (eq helm-split-window-default-side 'other)
        ;;                                'below helm-split-window-default-side))
        ;;   ;; If more than one window reuse one of them.
        ;;   (cl-case helm-split-window-default-side
        ;;     (left  (or (helm-window-in-direction 'left)
        ;;                (helm-window-in-direction 'above)
        ;;                (selected-window)))
        ;;     (above (or (helm-window-in-direction 'above)
        ;;                (helm-window-in-direction 'left)
        ;;                (selected-window)))
        ;;     (right (or (helm-window-in-direction 'right)
        ;;                (helm-window-in-direction 'below)
        ;;                (selected-window)))
        ;;     (below (or (helm-window-in-direction 'below)
        ;;                (helm-window-in-direction 'right)
        ;;                (selected-window)))
        ;;     (same  (selected-window))
        ;;     (other (other-window-for-scrolling))
        ;;     (t     (or (window-next-sibling) (selected-window)))))
      (split-window-sensibly window))))


;(global-set-key (kbd "M-x") 'helm-M-x)
;(helm-mode 1)



(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
(provide 'alxest-helm)
