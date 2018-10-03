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

(defun helm-find-files (arg)
  "Preconfigured `helm' for helm implementation of `find-file'.
Called with a prefix arg show history if some.
Don't call it from programs, use `helm-find-files-1' instead.
This is the starting point for nearly all actions you can do on files."
  (interactive "P")
  (let* ((hist            (and arg helm-ff-history (helm-find-files-history)))
         ;; (default-input   (or hist (helm-find-files-initial-input)))
         (default-input   nil)
         (input           (cond ((and (eq major-mode 'org-agenda-mode)
                                      org-directory
                                      (not default-input))
                                 (expand-file-name org-directory))
                                ((and (eq major-mode 'dired-mode) default-input)
                                 (file-name-directory default-input))
                                ((and (not (string= default-input ""))
                                      default-input))
                                (t (expand-file-name (helm-current-directory)))))
         (input-as-presel (null (nth 0 (file-attributes input))))
         (presel          (helm-aif (or hist
                                        (and input-as-presel input)
                                        (buffer-file-name (current-buffer))
                                        (and (eq major-mode 'dired-mode)
                                             default-input))
                              (if helm-ff-transformer-show-only-basename
                                  (helm-basename it) it))))
    (set-text-properties 0 (length input) nil input)
    (helm-find-files-1 input (and presel (null helm-ff-no-preselect)
                                  (concat "^" (regexp-quote presel))))))

(global-set-key (kbd "M-x") 'helm-M-x)
(setq helm-M-x-fuzzy-match t)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(helm-mode 1)
(global-set-key (kbd "C-x C-d") 'helm-browse-project)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-b") 'ibuffer)

(global-set-key (kbd "C-c p s l") 'helm-do-ag-this-file)

(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(provide 'alxest-helm)
